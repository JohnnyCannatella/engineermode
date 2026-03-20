'use server'

import { createClient } from '@/lib/supabase/server'
import {
  recommendLearningPath,
  serializeProfilePreferences,
  type ExperienceLevel,
  type LearningGoal,
} from '@/lib/profile-preferences'
import { levelFromXp } from '@/lib/utils'
import { revalidatePath } from 'next/cache'
import type { Achievement, MissionStep, UserTopicStatus } from '@/types'

export type CompleteMissionResult =
  | { error: string }
  | {
      xpEarned: number
      newXp: number
      newLevel: number
      previousLevel: number
      streakBonus: number
      newStreak: number
      newAchievements: Achievement[]
    }

type SubmittedAnswer = number | null

export async function completeMission(
  missionId: string,
  answers: SubmittedAnswer[],
  isDaily?: boolean
): Promise<CompleteMissionResult> {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return { error: 'Not authenticated' }

  const [{ data: profile }, { data: mission }, { data: existingProgress }] = await Promise.all([
    supabase
      .from('profiles')
      .select('xp, level, streak, streak_shields, last_active_date')
      .eq('id', user.id)
      .single(),
    supabase
      .from('missions')
      .select('id, path_id, xp_reward, is_published, review_after_days, steps')
      .eq('id', missionId)
      .maybeSingle(),
    supabase
      .from('user_mission_progress')
      .select('status')
      .eq('user_id', user.id)
      .eq('mission_id', missionId)
      .maybeSingle(),
  ])

  if (!profile) return { error: 'Profile not found' }
  if (!mission?.is_published) return { error: 'Mission not available' }
  if (existingProgress?.status === 'completed') {
    return { error: 'Mission already completed' }
  }

  const steps = mission.steps as MissionStep[]
  const gradedSteps = steps.filter((step) => step.type !== 'lesson')
  const maxScore = gradedSteps.length
  const score = gradedSteps.reduce((total: number, step: MissionStep, index: number) => {
    if (step.type === 'sorting') {
      return total + (answers[index] === 0 ? 1 : 0)
    }
    if ('correct' in step) {
      return total + (answers[index] === step.correct ? 1 : 0)
    }
    return total
  }, 0)

  // XP multiplier from streak: +10% per 3 streak days, capped at +50%
  const streakBonus = Math.min(50, Math.floor(profile.streak / 3) * 10)
  let actualXpEarned = Math.round(mission.xp_reward * (1 + streakBonus / 100))

  // Daily challenge 2x XP — server-verified
  if (isDaily) {
    const { data: allMissions } = await supabase
      .from('missions')
      .select('id')
      .eq('is_published', true)
      .order('created_at')
    const today = new Date().toISOString().split('T')[0]
    const dayHash = today.split('-').reduce((acc: number, n: string) => acc + parseInt(n), 0)
    const dailyMissionId = allMissions?.[dayHash % (allMissions?.length || 1)]?.id
    if (missionId === dailyMissionId) {
      actualXpEarned = actualXpEarned * 2
    }
  }

  // Update streak
  const today = new Date().toISOString().split('T')[0]
  const lastActive = profile.last_active_date
  let newStreak = profile.streak
  let shieldUsed = false

  if (lastActive !== today) {
    const yesterday = new Date(Date.now() - 86400000).toISOString().split('T')[0]
    if (lastActive === yesterday) {
      newStreak = profile.streak + 1
    } else if ((profile.streak_shields ?? 0) > 0) {
      // Spend a shield to preserve the streak after a missed day.
      newStreak = Math.max(profile.streak, 1)
      shieldUsed = true
    } else {
      newStreak = 1
    }
  }

  const previousLevel = profile.level
  const newXp = profile.xp + actualXpEarned
  const newLevel = levelFromXp(newXp)
  const scorePct = maxScore > 0 ? Math.round((score / maxScore) * 100) : 100
  const masteryLevel =
    scorePct >= 90 ? 'mastered' :
    scorePct >= 70 ? 'practicing' :
    'learning'
  const reviewDays = Math.max(1, mission.review_after_days ?? 7)
  const nextReviewAt = new Date(Date.now() + reviewDays * 86400000).toISOString()

  // Upsert mission progress
  const { error: progressError } = await supabase
    .from('user_mission_progress')
    .upsert(
      {
        user_id: user.id,
        mission_id: mission.id,
        status: 'completed',
        xp_earned: actualXpEarned,
        score,
        max_score: maxScore,
        completed_at: new Date().toISOString(),
      },
      { onConflict: 'user_id,mission_id' }
    )

  if (progressError) return { error: progressError.message }

  await supabase
    .from('user_mission_mastery')
    .upsert(
      {
        user_id: user.id,
        mission_id: mission.id,
        mastery_level: masteryLevel,
        last_score_pct: scorePct,
        completion_count: 1,
        last_completed_at: new Date().toISOString(),
        next_review_at: nextReviewAt,
      },
      {
        onConflict: 'user_id,mission_id',
        ignoreDuplicates: false,
      }
    )

  // Update profile
  const profileUpdate: Record<string, unknown> = {
    xp: newXp,
    level: newLevel,
    streak: newStreak,
    last_active_date: today,
  }
  if (shieldUsed) {
    profileUpdate.streak_shields = Math.max(0, (profile.streak_shields ?? 0) - 1)
  }

  await supabase.from('profiles').update(profileUpdate).eq('id', user.id)

  // Check achievements
  const newAchievements = await checkAndAwardAchievements(user.id, supabase, {
    newXp,
    newStreak,
    newLevel,
    score,
    maxScore,
  })

  revalidatePath('/dashboard')
  revalidatePath(`/mission/${mission.id}`)
  revalidatePath('/profile')

  return { xpEarned: actualXpEarned, newXp, newLevel, previousLevel, streakBonus, newStreak, newAchievements }
}

async function checkAndAwardAchievements(
  userId: string,
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  supabase: any,
  context: { newXp: number; newStreak: number; newLevel: number; score: number; maxScore: number }
): Promise<Achievement[]> {
  const { data: allAchievements } = await supabase.from('achievements').select('*')
  const { data: userAchievements } = await supabase
    .from('user_achievements')
    .select('achievement_id')
    .eq('user_id', userId)

  const earned = new Set((userAchievements || []).map((a: { achievement_id: string }) => a.achievement_id))

  const { data: completedMissions } = await supabase
    .from('user_mission_progress')
    .select('id, mission_id, missions(path_id, learning_paths(slug, mission_count))')
    .eq('user_id', userId)
    .eq('status', 'completed')

  const completedCount = completedMissions?.length ?? 0

  const pathMap = new Map<string, { completed: number; total: number }>()
  for (const row of completedMissions || []) {
    const mission = row.missions as { path_id: string; learning_paths: { slug: string; mission_count: number } } | null
    if (!mission?.learning_paths) continue
    const { slug, mission_count } = mission.learning_paths
    const existing = pathMap.get(slug) ?? { completed: 0, total: mission_count }
    pathMap.set(slug, { completed: existing.completed + 1, total: mission_count })
  }

  const pathsStarted = pathMap.size

  const shouldEarn = (slug: string): boolean => {
    const a = (allAchievements || []).find((a: { slug: string }) => a.slug === slug)
    if (!a || earned.has(a.id)) return false
    switch (slug) {
      case 'first-mission':    return completedCount >= 1
      case 'three-missions':   return completedCount >= 3
      case 'path-complete': {
        const systemsPath = pathMap.get('systems-foundations')
        return !!systemsPath && systemsPath.completed >= systemsPath.total
      }
      case 'perfect-score':    return context.maxScore > 0 && context.score === context.maxScore
      case 'xp-500':           return context.newXp >= 500
      case 'xp-1000':          return context.newXp >= 1000
      case 'xp-2500':          return context.newXp >= 2500
      case 'streak-3':         return context.newStreak >= 3
      case 'streak-7':         return context.newStreak >= 7
      case 'streak-14':        return context.newStreak >= 14
      case 'level-5':          return context.newLevel >= 5
      case 'level-10':         return context.newLevel >= 10
      case 'electronics-first':    return (pathMap.get('electronics-basics')?.completed ?? 0) >= 1
      case 'electronics-complete': {
        const ep = pathMap.get('electronics-basics')
        return !!ep && ep.completed >= ep.total
      }
      case 'mechanical-first':    return (pathMap.get('mechanical-thinking')?.completed ?? 0) >= 1
      case 'mechanical-complete': {
        const mp = pathMap.get('mechanical-thinking')
        return !!mp && mp.completed >= mp.total
      }
      case 'software-first':    return (pathMap.get('software-systems')?.completed ?? 0) >= 1
      case 'software-complete': {
        const sp = pathMap.get('software-systems')
        return !!sp && sp.completed >= sp.total
      }
      case 'multi-path':       return pathsStarted >= 3
      default:                 return false
    }
  }

  const toAward = (allAchievements || []).filter((a: { slug: string }) => shouldEarn(a.slug))

  if (toAward.length > 0) {
    await supabase.from('user_achievements').insert(
      toAward.map((a: { id: string }) => ({ user_id: userId, achievement_id: a.id }))
    )
  }

  return toAward as Achievement[]
}

export async function purchaseStreakShield(): Promise<{ success?: boolean; error?: string }> {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return { error: 'Not authenticated' }

  const { data: profile } = await supabase
    .from('profiles')
    .select('xp, streak_shields')
    .eq('id', user.id)
    .single()

  if (!profile) return { error: 'Profile not found' }
  if (profile.xp < 100) return { error: 'Not enough XP. You need 100 XP to buy a shield.' }
  if ((profile.streak_shields ?? 0) >= 3) return { error: 'You already have 3 shields (maximum).' }

  await supabase.from('profiles').update({
    xp: profile.xp - 100,
    streak_shields: (profile.streak_shields ?? 0) + 1,
  }).eq('id', user.id)

  revalidatePath('/profile')
  return { success: true }
}

export async function updateProfile(data: {
  display_name?: string
  goal?: LearningGoal
  experience_level?: ExperienceLevel
  onboarding_completed?: boolean
}) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return { error: 'Not authenticated' }

  const updateData: Record<string, string | boolean | null | undefined> = {
    display_name: data.display_name,
    onboarding_completed: data.onboarding_completed,
  }

  if ('goal' in data || 'experience_level' in data) {
    const recommendedPath = recommendLearningPath({
      goal: data.goal ?? null,
      experienceLevel: data.experience_level ?? null,
    })
    updateData.goal = serializeProfilePreferences({
      goal: data.goal ?? null,
      experienceLevel: data.experience_level ?? null,
    })
    updateData.learning_goal = data.goal ?? null
    updateData.experience_level = data.experience_level ?? null
    updateData.recommended_path_slug = recommendedPath
  }

  const { error } = await supabase.from('profiles').update(updateData).eq('id', user.id)
  if (error) return { error: error.message }

  revalidatePath('/dashboard')
  revalidatePath('/profile')
  revalidatePath('/onboarding')

  return { success: true }
}

export async function updateTopicStatus(topicSlug: string, status: UserTopicStatus) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return { error: 'Not authenticated' }

  const now = new Date().toISOString()
  const payload = {
    user_id: user.id,
    topic_slug: topicSlug,
    status,
    started_at: status === 'not_started' ? null : now,
    completed_at: status === 'understood' ? now : null,
  }

  const { error } = await supabase
    .from('user_topic_progress')
    .upsert(payload, { onConflict: 'user_id,topic_slug' })

  if (error) return { error: error.message }

  revalidatePath(`/topic/${topicSlug}`)
  revalidatePath('/dashboard')
  return { success: true }
}
