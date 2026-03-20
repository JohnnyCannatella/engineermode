import { redirect } from 'next/navigation'
import Link from 'next/link'
import { getProfilePreferences } from '@/lib/profile-preferences'
import { createClient } from '@/lib/supabase/server'
import { xpProgress } from '@/lib/utils'
import ActivityCalendar from '@/components/profile/ActivityCalendar'
import BottomNav from '@/components/ui/BottomNav'
import StreakShieldButton from '@/components/profile/StreakShieldButton'
import type { LearningArea, Topic, UserTopicProgress } from '@/types'

const STAGE_LABELS = {
  foundation: 'Fondamenta',
  builder: 'Costruttore',
  inventor: 'Inventore',
  architect: 'Architetto',
} as const

export default async function ProfilePage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) redirect('/auth')

  const [
    { data: profile },
    { data: progressRows },
    { data: userAchievements },
    { data: allAchievements },
    { data: paths },
    { data: missions },
    { data: masteryRows },
    { data: areas },
    { data: topics },
    { data: userTopicRows },
    { data: missionTopicRows },
  ] = await Promise.all([
    supabase.from('profiles').select('*').eq('id', user.id).single(),
    supabase.from('user_mission_progress').select('*').eq('user_id', user.id),
    supabase.from('user_achievements').select('*, achievements(*)').eq('user_id', user.id),
    supabase.from('achievements').select('*').order('created_at'),
    supabase.from('learning_paths').select('id,slug,title,icon,color,mission_count,learning_stage,area_slug').order('order_index'),
    supabase.from('missions').select('id,path_id,xp_reward').order('order_index'),
    supabase.from('user_mission_mastery').select('mission_id,mastery_level,next_review_at').eq('user_id', user.id),
    supabase.from('learning_areas').select('*').order('order_index'),
    supabase.from('topics').select('slug,title,summary,difficulty_level,estimated_minutes,overview,key_takeaways,created_at').order('title'),
    supabase.from('user_topic_progress').select('*').eq('user_id', user.id).order('updated_at', { ascending: false }),
    supabase.from('mission_topics').select('mission_id,topic_slug').order('sort_order'),
  ])

  if (!profile) redirect('/auth')

  const xp = xpProgress(profile.xp)
  const preferences = getProfilePreferences(profile)
  const progressMap = new Map((progressRows || []).map((p) => [p.mission_id, p]))
  const completedMissions = (progressRows || []).filter((p) => p.status === 'completed').length
  const totalScore = (progressRows || []).reduce((sum, p) => sum + (p.score ?? 0), 0)
  const totalMax = (progressRows || []).reduce((sum, p) => sum + (p.max_score ?? 0), 0)
  const accuracy = totalMax > 0 ? Math.round((totalScore / totalMax) * 100) : 0
  const earnedIds = new Set((userAchievements || []).map((ua) => ua.achievement_id))
  const displayName = profile.display_name || user.email?.split('@')[0] || 'Ingegnere'
  const dueReviewCount = (masteryRows || []).filter((row) => row.next_review_at && row.next_review_at <= new Date().toISOString()).length
  const masteredCount = (masteryRows || []).filter((row) => row.mastery_level === 'mastered').length
  const typedTopics = (topics || []) as Topic[]
  const typedAreas = (areas || []) as LearningArea[]
  const topicProgressRows = (userTopicRows || []) as UserTopicProgress[]
  const topicProgressMap = new Map(topicProgressRows.map((row) => [row.topic_slug, row]))
  const studiedTopicCount = topicProgressRows.filter((row) => row.status !== 'not_started').length
  const studyingTopicCount = topicProgressRows.filter((row) => row.status === 'studying').length
  const understoodTopicCount = topicProgressRows.filter((row) => row.status === 'understood').length
  const topicCoveragePct = typedTopics.length > 0 ? Math.round((studiedTopicCount / typedTopics.length) * 100) : 0

  const pathStats = (paths || []).map((path) => {
    const pathMissions = (missions || []).filter((m) => m.path_id === path.id)
    const completedInPath = pathMissions.filter((m) => progressMap.get(m.id)?.status === 'completed').length
    const xpInPath = pathMissions.reduce((sum, m) => {
      const progress = progressMap.get(m.id)
      return sum + (progress?.xp_earned ?? 0)
    }, 0)
    return { ...path, completedInPath, totalInPath: pathMissions.length, xpInPath }
  })
  const stageTotals = (['foundation', 'builder', 'inventor', 'architect'] as const)
    .map((stage) => {
      const stagePaths = pathStats.filter((path) => (path.learning_stage ?? 'foundation') === stage)
      return {
        stage,
        total: stagePaths.length,
        completed: stagePaths.filter((path) => path.completedInPath >= path.totalInPath && path.totalInPath > 0).length,
      }
    })
    .filter((stage) => stage.total > 0)

  const learnPath = pathStats.find((ps) => ps.completedInPath < ps.totalInPath)?.slug ?? 'systems-foundations'
  const activityDates = (progressRows || []).filter((p) => p.completed_at).map((p) => p.completed_at as string)
  const pathSlugByPathId = new Map((paths || []).map((path) => [path.id, path.slug]))
  const missionPathSlugById = new Map((missions || []).map((mission) => [mission.id, pathSlugByPathId.get(mission.path_id) ?? null]))
  const areaSlugByPathSlug = new Map((paths || []).map((path) => [path.slug, (path as { area_slug?: string | null }).area_slug ?? 'systems-thinking']))
  const uniqueAreaTopics = new Map<string, Set<string>>()
  for (const row of missionTopicRows || []) {
    const pathSlug = missionPathSlugById.get(row.mission_id)
    if (!pathSlug) continue
    const areaSlug = areaSlugByPathSlug.get(pathSlug) ?? 'systems-thinking'
    const set = uniqueAreaTopics.get(areaSlug) ?? new Set<string>()
    set.add(row.topic_slug)
    uniqueAreaTopics.set(areaSlug, set)
  }
  const areaTopicStats = typedAreas
    .map((area) => {
      const topicSlugs = Array.from(uniqueAreaTopics.get(area.slug) ?? [])
      const understood = topicSlugs.filter((slug) => topicProgressMap.get(slug)?.status === 'understood').length
      return {
        area,
        total: topicSlugs.length,
        understood,
        pct: topicSlugs.length > 0 ? Math.round((understood / topicSlugs.length) * 100) : 0,
      }
    })
    .filter((item) => item.total > 0)

  async function signOut() {
    'use server'
    const { createClient: c } = await import('@/lib/supabase/server')
    const sb = await c()
    await sb.auth.signOut()
    const { redirect: r } = await import('next/navigation')
    r('/auth')
  }

  return (
    <div className="min-h-screen max-w-lg mx-auto px-5 pb-28 pt-8 text-white">
      <header className="pb-5">
        <div className="mb-5 flex items-center justify-between">
          <Link href="/dashboard" className="text-sm text-slate-400 transition-colors hover:text-white">← Dashboard</Link>
          <Link href="/settings" className="rounded-xl border border-white/10 bg-white/5 px-3 py-2 text-xs uppercase tracking-[0.16em] text-slate-300 transition-colors hover:text-white">
            Assetto
          </Link>
        </div>

        <div className="panel-strong flex flex-col items-center text-center">
          <div className="eyebrow mb-3">Dossier Ingegneristico</div>
          <div
            className="mb-4 flex h-24 w-24 items-center justify-center rounded-[2rem] border border-white/10 text-4xl font-bold text-white shadow-[0_20px_40px_rgba(8,17,31,0.35)]"
            style={{ background: profile.avatar_color || '#f6a63b' }}
          >
            {displayName.charAt(0).toUpperCase()}
          </div>
          <h1 className="text-3xl font-semibold text-white">{displayName}</h1>
          <p className="mt-2 text-sm text-slate-400">{user.email}</p>
          <div className="mt-4 flex items-center gap-2 rounded-full border border-[#f6a63b]/30 bg-[#f6a63b]/10 px-4 py-2">
            <span className="text-xs font-semibold uppercase tracking-[0.16em] text-[#f8c777]">Livello {xp.level}</span>
            <span className="text-[#f6a63b]/60">·</span>
            <span className="text-xs text-slate-300">{xp.totalXp} XP</span>
          </div>
          {(preferences.goal || preferences.experienceLevel) && (
            <div className="mt-4 flex flex-wrap items-center justify-center gap-2">
              {preferences.goal && <span className="hud-chip">Obiettivo: {{ career: 'Carriera', curiosity: 'Curiosita', study: 'Studio', build: 'Costruire' }[preferences.goal] ?? preferences.goal}</span>}
              {preferences.experienceLevel && <span className="hud-chip">Livello: {{ beginner: 'Principiante', student: 'Studente', professional: 'Professionista', expert: 'Esperto' }[preferences.experienceLevel] ?? preferences.experienceLevel}</span>}
            </div>
          )}
        </div>
      </header>

      <section className="mb-5">
        <div className="panel">
          <div className="mb-3 flex justify-between">
            <span className="text-sm font-semibold text-white">Progressione livello {xp.level} → {xp.level + 1}</span>
            <span className="text-sm text-slate-400">{xp.current} / {xp.needed}</span>
          </div>
          <div className="h-2 overflow-hidden rounded-full bg-white/5">
            <div
              className="h-full rounded-full transition-all duration-700"
              style={{ width: `${Math.min(100, (xp.current / xp.needed) * 100)}%`, background: 'linear-gradient(90deg, #2dd4bf, #7dd3fc)' }}
            />
          </div>
          <span className="mt-2 block text-xs uppercase tracking-[0.16em] text-slate-500">{xp.needed - xp.current} XP al prossimo livello</span>
        </div>
      </section>

      <section className="mb-5">
        <h2 className="eyebrow mb-3">Metriche Chiave</h2>
        <div className="grid grid-cols-2 gap-3">
          {[
            { label: 'Missioni completate', value: completedMissions, icon: '✅' },
            { label: 'Serie giorni', value: profile.streak, icon: '🔥' },
            { label: 'Precisione', value: `${accuracy}%`, icon: '🎯' },
            { label: 'Review in scadenza', value: dueReviewCount, icon: '🧭' },
            { label: 'Topic in studio', value: studyingTopicCount, icon: '🧠' },
            { label: 'Topic compresi', value: understoodTopicCount, icon: '◈' },
            { label: 'Copertura topic', value: `${topicCoveragePct}%`, icon: '🗺️' },
          ].map((stat) => (
            <div key={stat.label} className="flex items-center gap-3 rounded-[1.6rem] border border-white/10 bg-[linear-gradient(180deg,rgba(255,255,255,0.06),rgba(255,255,255,0.03))] p-4">
              <span className="text-2xl">{stat.icon}</span>
              <div>
                <div className="text-xl font-bold text-white">{stat.value}</div>
                <div className="text-xs text-slate-400">{stat.label}</div>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="mb-5">
        <h2 className="eyebrow mb-3">Maturità Curriculum</h2>
        <div className="grid grid-cols-2 gap-3">
          {stageTotals.map((stage) => (
            <div key={stage.stage} className="rounded-[1.5rem] border border-white/10 bg-[linear-gradient(180deg,rgba(255,255,255,0.06),rgba(255,255,255,0.03))] p-4">
              <div className="text-[11px] uppercase tracking-[0.18em] text-slate-500">{STAGE_LABELS[stage.stage]}</div>
              <div className="mt-2 text-xl font-semibold text-white">{stage.completed}/{stage.total}</div>
              <div className="mt-1 text-xs text-slate-400">percorsi completati</div>
            </div>
          ))}
        </div>
        <div className="mt-3 rounded-[1.5rem] border border-white/10 bg-white/5 p-4">
          <div className="flex items-center justify-between">
            <span className="text-sm text-slate-300">Missioni in mastery</span>
            <span className="text-lg font-semibold text-white">{masteredCount}</span>
          </div>
        </div>
      </section>

      <section className="mb-5">
        <h2 className="eyebrow mb-3">Knowledge Graph</h2>
        <div className="rounded-[1.5rem] border border-white/10 bg-white/5 p-4">
          <div className="flex items-center justify-between">
            <span className="text-sm text-slate-300">Topic avviati</span>
            <span className="text-lg font-semibold text-white">{studiedTopicCount}/{typedTopics.length}</span>
          </div>
          <div className="mt-3 h-2 overflow-hidden rounded-full bg-white/5">
            <div
              className="h-full rounded-full"
              style={{ width: `${topicCoveragePct}%`, background: 'linear-gradient(90deg, #f6a63b, #5eead4)' }}
            />
          </div>
        </div>
        <div className="mt-3 grid gap-3">
          {areaTopicStats.map(({ area, understood, total, pct }) => (
            <div key={area.slug} className="rounded-[1.5rem] border border-white/10 bg-[linear-gradient(180deg,rgba(255,255,255,0.06),rgba(255,255,255,0.02))] p-4">
              <div className="flex items-center gap-3">
                <div className="flex h-10 w-10 items-center justify-center rounded-xl text-lg" style={{ background: `${area.color}20`, color: area.color }}>
                  {area.icon}
                </div>
                <div className="min-w-0 flex-1">
                  <div className="text-sm font-medium text-white">{area.title}</div>
                  <div className="text-xs text-slate-400">{understood}/{total} topic compresi</div>
                </div>
                <span className="text-xs text-slate-400">{pct}%</span>
              </div>
              <div className="mt-3 h-1.5 overflow-hidden rounded-full bg-white/5">
                <div className="h-full rounded-full" style={{ width: `${pct}%`, background: `linear-gradient(90deg, ${area.color}, #5eead4)` }} />
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="mb-5">
        <h2 className="eyebrow mb-3">Scudo Serie</h2>
        <StreakShieldButton shields={profile.streak_shields ?? 0} xp={profile.xp} />
      </section>

      <section className="mb-5">
        <h2 className="eyebrow mb-3">Heatmap</h2>
        <div className="panel">
          <ActivityCalendar completedDates={activityDates} />
        </div>
      </section>

      <section className="mb-5">
        <h2 className="eyebrow mb-3">Progressione Percorsi</h2>
        <div className="flex flex-col gap-2">
          {pathStats.map((path) => (
            <div key={path.id} className="rounded-[1.5rem] border border-white/10 bg-[linear-gradient(180deg,rgba(255,255,255,0.06),rgba(255,255,255,0.02))] p-4">
              <div className="mb-2 flex items-center gap-3">
                <span className="text-lg">{path.icon}</span>
                <div className="min-w-0 flex-1">
                  <div className="truncate text-sm font-medium text-white">{path.title}</div>
                  <div className="text-xs text-slate-400">{path.completedInPath}/{path.totalInPath} missioni · {path.xpInPath} XP</div>
                </div>
                <span className="text-xs text-slate-400">{path.totalInPath > 0 ? Math.round((path.completedInPath / path.totalInPath) * 100) : 0}%</span>
              </div>
              <div className="h-1.5 overflow-hidden rounded-full bg-white/5">
                <div
                  className="h-full rounded-full"
                  style={{
                    width: `${path.totalInPath > 0 ? (path.completedInPath / path.totalInPath) * 100 : 0}%`,
                    background: path.color,
                  }}
                />
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="mb-6">
        <h2 className="eyebrow mb-3">Obiettivi ({earnedIds.size}/{(allAchievements || []).length})</h2>
        <div className="flex flex-col gap-2">
          {(allAchievements || []).map((achievement) => {
            const earned = earnedIds.has(achievement.id)
            return (
              <div
                key={achievement.id}
                className={`flex items-center gap-3 rounded-xl border p-3 transition-all ${
                  earned ? 'border-[#f6a63b]/30 bg-[#f6a63b]/10' : 'border-white/10 bg-white/5 opacity-40'
                }`}
              >
                <span className={`text-2xl ${!earned ? 'grayscale' : ''}`}>{achievement.icon}</span>
                <div className="flex-1">
                  <div className={`text-sm font-medium ${earned ? 'text-white' : 'text-slate-500'}`}>{achievement.title}</div>
                  <div className="text-xs text-slate-400">{achievement.description}</div>
                </div>
                <div className="text-xs font-semibold text-[#f6a63b]">+{achievement.xp_reward}</div>
              </div>
            )
          })}
        </div>
      </section>

      <section>
        <form action={signOut}>
          <button type="submit" className="w-full rounded-2xl border border-white/10 bg-white/5 py-3 text-sm font-medium text-slate-300 transition-colors hover:text-white">
            Esci
          </button>
        </form>
      </section>

      <BottomNav active="/profile" learnPath={learnPath} />
    </div>
  )
}
