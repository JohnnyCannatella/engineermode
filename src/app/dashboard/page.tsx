import { redirect } from 'next/navigation'
import Link from 'next/link'
import { getProfilePreferences, recommendLearningPath } from '@/lib/profile-preferences'
import { createClient } from '@/lib/supabase/server'
import { xpProgress } from '@/lib/utils'
import BottomNav from '@/components/ui/BottomNav'
import type { LearningArea, UserMissionProgress } from '@/types'

const STAGE_LABELS = {
  foundation: 'Fondamenta',
  builder: 'Costruttore',
  inventor: 'Inventore',
  architect: 'Architetto',
} as const

export default async function DashboardPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) redirect('/auth')

  const [
    { data: profile },
    { data: areas },
    { data: paths },
    { data: missions },
    { data: progress },
    { data: recentAchievements },
    { data: dueReviews },
    { data: masteryRows },
  ] = await Promise.all([
    supabase.from('profiles').select('*').eq('id', user.id).single(),
    supabase.from('learning_areas').select('*').order('order_index'),
    supabase.from('learning_paths').select('*').order('order_index'),
    supabase.from('missions').select('id,path_id,title,description,icon,xp_reward,estimated_minutes,order_index').order('created_at'),
    supabase.from('user_mission_progress').select('*').eq('user_id', user.id),
    supabase.from('user_achievements').select('*, achievements(*)').eq('user_id', user.id).order('earned_at', { ascending: false }).limit(3),
    supabase
      .from('user_mission_mastery')
      .select('mission_id,next_review_at')
      .eq('user_id', user.id)
      .lte('next_review_at', new Date().toISOString()),
    supabase
      .from('user_mission_mastery')
      .select('mission_id,mastery_level')
      .eq('user_id', user.id),
  ])

  if (!profile) redirect('/auth')
  if (!profile.onboarding_completed) redirect('/onboarding')

  const preferences = getProfilePreferences(profile)
  const xp = xpProgress(profile.xp)
  const progressMap = new Map<string, UserMissionProgress>((progress || []).map((p) => [p.mission_id, p]))

  const pathsWithStats = (paths || []).map((path) => {
    const pathMissions = (missions || []).filter((m) => m.path_id === path.id)
    const completed = pathMissions.filter((m) => progressMap.get(m.id)?.status === 'completed').length
    return { ...path, missions: pathMissions, completed }
  })

  const recommendedPath = preferences.recommendedPathSlug ?? recommendLearningPath(preferences)
  const nextIncompletePath = pathsWithStats.find((p) => p.completed < p.mission_count)
  const learnPath = nextIncompletePath?.slug ?? recommendedPath

  const pathIdBySlug = new Map((paths || []).map((path) => [path.slug, path.id]))
  const recommendedPathId = pathIdBySlug.get(recommendedPath)
  const nextMission = ((missions || []).find((mission) => {
    const p = progressMap.get(mission.id)
    return recommendedPathId != null && mission.path_id === recommendedPathId && (!p || p.status !== 'completed')
  })) ?? (missions || []).find((mission) => {
    const p = progressMap.get(mission.id)
    return !p || p.status !== 'completed'
  })

  const today = new Date().toISOString().split('T')[0]
  const dayHash = today.split('-').reduce((acc: number, n: string) => acc + parseInt(n), 0)
  const allMissionsList = missions || []
  const dailyMission = allMissionsList.length > 0 ? allMissionsList[dayHash % allMissionsList.length] : null
  const dailyProgress = dailyMission ? progressMap.get(dailyMission.id) : null
  const dailyDoneToday = dailyProgress?.completed_at?.startsWith(today)
  const isDailyNextMission = dailyMission?.id === nextMission?.id

  const completedCount = (progress || []).filter((p) => p.status === 'completed').length
  const displayName = profile.display_name || user.email?.split('@')[0] || 'Ingegnere'
  const dueReviewCount = dueReviews?.length ?? 0
  const dueReviewIds = new Set((dueReviews || []).map((row) => row.mission_id))
  const dueReviewMissions = (missions || []).filter((mission) => dueReviewIds.has(mission.id)).slice(0, 3)
  const masteredCount = (masteryRows || []).filter((row) => row.mastery_level === 'mastered').length

  const pathLockMap = new Map<string, boolean>(
    pathsWithStats.map((path, index) => {
      const isLocked = index > 0 && pathsWithStats[index - 1].completed < pathsWithStats[index - 1].mission_count
      return [path.id, isLocked]
    })
  )

  const pathsByArea = new Map<string, typeof pathsWithStats>()
  for (const path of pathsWithStats) {
    const areaSlug = path.area_slug ?? 'systems-thinking'
    const existing = pathsByArea.get(areaSlug) ?? []
    existing.push(path)
    pathsByArea.set(areaSlug, existing)
  }

  const orderedAreas = (areas || []) as LearningArea[]
  const recommendedPathTitle = (paths || []).find((path) => path.slug === recommendedPath)?.title ?? 'Fondamenti di Sistemi'
  const stageSummaries = (['foundation', 'builder', 'inventor', 'architect'] as const)
    .map((stage) => {
      const stagePaths = pathsWithStats.filter((path) => (path.learning_stage ?? 'foundation') === stage)
      return {
        stage,
        label: STAGE_LABELS[stage],
        total: stagePaths.length,
        completed: stagePaths.filter((path) => path.completed >= path.mission_count).length,
      }
    })
    .filter((stage) => stage.total > 0)

  return (
    <div className="mx-auto min-h-screen max-w-6xl px-4 pb-32 pt-6 text-white sm:px-6 lg:px-8">
      <header className="panel-strong rounded-[2rem] p-5 sm:p-7">
        <div className="flex flex-col gap-6 lg:flex-row lg:items-end lg:justify-between">
          <div className="max-w-2xl">
            <div className="eyebrow text-[10px] text-primary-light">Mission Control</div>
            <h1 className="mt-3 text-3xl font-bold tracking-[-0.05em] text-white sm:text-5xl">
              {displayName}, il laboratorio è operativo.
            </h1>
            <p className="mt-4 max-w-xl text-sm leading-7 text-muted sm:text-base">
              Stai costruendo un profilo da inventor-engineer. Ogni missione allena un sottosistema diverso:
              pensiero, software, energia, controllo, AI e prototipazione.
            </p>
            <div className="mt-5 flex flex-wrap gap-2">
              <span className="hud-chip"><span className="font-mono text-primary-light">LVL</span> {xp.level}</span>
              <span className="hud-chip"><span className="font-mono text-primary-light">PERCORSO</span> {recommendedPathTitle}</span>
              <span className="hud-chip"><span className="font-mono text-primary-light">REVIEW</span> {dueReviewCount} in scadenza</span>
            </div>
          </div>
          <Link href="/profile" className="self-start lg:self-auto">
            <div
              className="flex h-16 w-16 items-center justify-center rounded-[1.5rem] border border-rim/80 bg-surface font-bold text-xl text-white shadow-[0_12px_40px_rgba(0,0,0,0.3)]"
              style={{ boxShadow: `0 12px 40px ${profile.avatar_color ?? '#ff7a18'}30`, borderColor: `${profile.avatar_color ?? '#ff7a18'}50` }}
            >
              {displayName.charAt(0).toUpperCase()}
            </div>
          </Link>
        </div>

        <div className="mt-6 grid grid-cols-2 gap-3 md:grid-cols-4">
          {[
            { label: 'Missioni completate', value: completedCount, icon: '01' },
            { label: 'Serie attuale', value: `${profile.streak}d`, icon: '02' },
            { label: 'XP totali', value: profile.xp >= 1000 ? `${(profile.xp / 1000).toFixed(1)}k` : profile.xp, icon: '03' },
            { label: 'Review in scadenza', value: dueReviewCount, icon: '04' },
          ].map((item) => (
            <div key={item.label} className="panel rounded-[1.4rem] p-4">
              <div className="font-mono text-xs text-primary-light">{item.icon}</div>
              <div className="mt-3 text-2xl font-semibold text-white">{item.value}</div>
              <div className="mt-1 text-xs text-muted">{item.label}</div>
            </div>
          ))}
        </div>

        <div className="mt-6 panel rounded-[1.6rem] p-4 sm:p-5">
          <div className="flex items-center justify-between gap-4">
            <div>
              <div className="eyebrow text-[10px] text-primary-light">Motore di Avanzamento</div>
              <div className="mt-2 text-lg font-semibold text-white">Livello {xp.level} → {xp.level + 1}</div>
            </div>
            <div className="font-mono text-xs text-muted">{xp.current} / {xp.needed} XP</div>
          </div>
          <div className="mt-4 h-3 overflow-hidden rounded-full bg-[#08111f]">
            <div
              className="h-full rounded-full transition-all duration-700"
              style={{ width: `${Math.min(100, (xp.current / xp.needed) * 100)}%`, background: 'linear-gradient(90deg, #ff7a18, #5eead4)' }}
            />
          </div>
          <div className="mt-2 text-xs text-muted">{xp.needed - xp.current} XP al prossimo livello</div>
        </div>
      </header>

      <section className="mt-6 grid gap-4 xl:grid-cols-[1.1fr_0.9fr]">
        {dailyMission && (
          <Link href={`/mission/${dailyMission.id}`} className="block">
            <div className={`panel-strong rounded-[1.9rem] p-5 transition-all hover:-translate-y-0.5 ${
              dailyDoneToday ? 'opacity-70' : ''
            }`}>
              <div className="flex items-center justify-between">
                <div className="eyebrow text-[10px] text-warning">Sfida del giorno</div>
                <div className="rounded-full border border-warning/30 bg-warning/10 px-3 py-1 text-[11px] font-semibold text-warning">
                  {dailyDoneToday ? 'Completata' : 'Bonus 2× XP'}
                </div>
              </div>
              <div className="mt-5 flex items-start gap-4">
                <div className="flex h-16 w-16 items-center justify-center rounded-[1.4rem] bg-warning/10 text-3xl">
                  {dailyDoneToday ? '✓' : dailyMission.icon}
                </div>
                <div className="flex-1">
                  <div className="text-xl font-semibold text-white">{dailyMission.title}</div>
                  <div className="mt-2 text-sm leading-7 text-muted">{dailyMission.description}</div>
                  <div className="mt-4 flex flex-wrap gap-2">
                    <span className="hud-chip">⏱ {dailyMission.estimated_minutes} min</span>
                    <span className="hud-chip">⚡ {dailyMission.xp_reward * 2} XP</span>
                  </div>
                </div>
              </div>
            </div>
          </Link>
        )}

        {nextMission && !isDailyNextMission && (
          <Link href={`/mission/${nextMission.id}`} className="block">
            <div className="panel rounded-[1.9rem] p-5 transition-all hover:-translate-y-0.5">
              <div className="eyebrow text-[10px] text-primary-light">Next Best Action</div>
              <div className="mt-4 flex items-start gap-4">
                <div className="flex h-16 w-16 items-center justify-center rounded-[1.4rem] bg-primary/10 text-3xl text-primary-light">
                  {nextMission.icon}
                </div>
                <div className="flex-1">
                  <div className="text-xl font-semibold text-white">{nextMission.title}</div>
                  <div className="mt-2 text-sm leading-7 text-muted">{nextMission.description}</div>
                  <div className="mt-4 flex flex-wrap gap-2">
                    <span className="hud-chip">⏱ {nextMission.estimated_minutes} min</span>
                    <span className="hud-chip">💎 {nextMission.xp_reward} XP</span>
                  </div>
                </div>
              </div>
            </div>
          </Link>
        )}
      </section>

      {recentAchievements && recentAchievements.length > 0 && (
        <section className="mt-6">
          <div className="mb-3 flex items-center justify-between">
            <div className="eyebrow text-[10px] text-primary-light">Recent Unlocks</div>
          </div>
          <div className="grid gap-3 sm:grid-cols-3">
            {recentAchievements.map((ua) => {
              const achievement = ua.achievements as { icon: string; title: string; xp_reward: number } | null
              if (!achievement) return null
              return (
                <div key={ua.id} className="panel rounded-[1.4rem] p-4">
                  <div className="text-2xl">{achievement.icon}</div>
                  <div className="mt-3 text-sm font-semibold text-white">{achievement.title}</div>
                  <div className="mt-1 text-xs text-warning">+{achievement.xp_reward} XP</div>
                </div>
              )
            })}
          </div>
        </section>
      )}

      <section className="mt-6 grid gap-4 xl:grid-cols-[0.95fr_1.05fr]">
        <div className="panel rounded-[1.8rem] p-5">
          <div className="eyebrow text-[10px] text-primary-light">Review in scadenza</div>
          <h2 className="mt-2 text-xl font-semibold text-white">Coda di consolidamento</h2>
          <p className="mt-2 text-sm leading-7 text-muted">
            Le missioni già studiate tornano qui quando è il momento giusto per consolidarle.
          </p>
          <div className="mt-4 grid grid-cols-2 gap-3">
            <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
              <div className="text-[11px] uppercase tracking-[0.2em] text-slate-500">Due oggi</div>
              <div className="mt-2 text-2xl font-semibold text-white">{dueReviewCount}</div>
            </div>
            <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
              <div className="text-[11px] uppercase tracking-[0.2em] text-slate-500">Mastery</div>
              <div className="mt-2 text-2xl font-semibold text-white">{masteredCount}</div>
            </div>
          </div>
          <div className="mt-4 flex flex-col gap-2">
            {dueReviewMissions.length > 0 ? (
              dueReviewMissions.map((mission) => (
                <Link key={mission.id} href={`/mission/${mission.id}`} className="rounded-2xl border border-white/10 bg-white/5 px-4 py-3 transition-colors hover:border-white/20">
                  <div className="flex items-center gap-3">
                    <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-[#2dd4bf]/10 text-xl text-[#81f4e1]">
                      {mission.icon}
                    </div>
                    <div className="min-w-0 flex-1">
                      <div className="truncate text-sm font-semibold text-white">{mission.title}</div>
                      <div className="text-xs text-slate-400">Ripasso consigliato</div>
                    </div>
                    <div className="text-sm text-slate-500">→</div>
                  </div>
                </Link>
              ))
            ) : (
              <div className="rounded-2xl border border-white/10 bg-white/5 px-4 py-4 text-sm text-slate-400">
                Nessuna review urgente. Continua con nuove missioni.
              </div>
            )}
          </div>
        </div>

        <div className="panel rounded-[1.8rem] p-5">
          <div className="eyebrow text-[10px] text-primary-light">Segnali di crescita</div>
          <h2 className="mt-2 text-xl font-semibold text-white">Dove stai salendo davvero</h2>
          <div className="mt-4 grid gap-3 sm:grid-cols-3">
            {pathsWithStats
              .filter((path) => path.completed > 0)
              .sort((a, b) => (b.completed / Math.max(1, b.mission_count)) - (a.completed / Math.max(1, a.mission_count)))
              .slice(0, 3)
              .map((path) => {
                const pct = Math.round((path.completed / Math.max(1, path.mission_count)) * 100)
                return (
                  <Link key={path.id} href={`/path/${path.slug}`} className="rounded-[1.5rem] border border-white/10 bg-white/5 p-4 transition-colors hover:border-white/20">
                    <div className="flex items-center gap-3">
                      <div className="flex h-11 w-11 items-center justify-center rounded-xl text-xl" style={{ background: `${path.color}20` }}>
                        {path.icon}
                      </div>
                      <div className="min-w-0 flex-1">
                        <div className="truncate text-sm font-semibold text-white">{path.title}</div>
                        <div className="text-xs text-slate-400">{path.completed}/{path.mission_count} missioni</div>
                      </div>
                    </div>
                    <div className="mt-4 h-2 overflow-hidden rounded-full bg-[#08111f]">
                      <div className="h-full rounded-full" style={{ width: `${pct}%`, background: `linear-gradient(90deg, ${path.color}, #5eead4)` }} />
                    </div>
                  </Link>
                )
              })}
          </div>
        </div>
      </section>

      <section className="mt-6">
        <div className="mb-4">
          <div className="eyebrow text-[10px] text-primary-light">Stark Progression</div>
          <h2 className="mt-2 text-2xl font-semibold tracking-[-0.03em] text-white">Livelli di maturità del curriculum</h2>
        </div>
        <div className="grid gap-3 md:grid-cols-4">
          {stageSummaries.map((stage, index) => (
            <div key={stage.stage} className="panel rounded-[1.6rem] p-4">
              <div className="font-mono text-xs text-primary-light">0{index + 1}</div>
              <div className="mt-3 text-lg font-semibold text-white">{stage.label}</div>
              <div className="mt-2 text-sm text-muted">{stage.completed}/{stage.total} percorsi completati</div>
              <div className="mt-4 h-2 overflow-hidden rounded-full bg-[#08111f]">
                <div
                  className="h-full rounded-full"
                  style={{
                    width: `${stage.total > 0 ? (stage.completed / stage.total) * 100 : 0}%`,
                    background: 'linear-gradient(90deg, #ff7a18, #5eead4)',
                  }}
                />
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="mt-8">
        <div className="mb-4">
          <div className="eyebrow text-[10px] text-primary-light">Programma Stark</div>
          <h2 className="mt-2 text-2xl font-semibold tracking-[-0.03em] text-white">Roadmap per macro aree</h2>
        </div>
        <div className="flex flex-col gap-6">
          {orderedAreas.map((area) => {
            const areaPaths = pathsByArea.get(area.slug) ?? []
            if (areaPaths.length === 0) return null
            return (
              <div key={area.slug} className="panel rounded-[1.8rem] p-4 sm:p-5">
                <div className="flex items-start gap-4">
                  <div className="flex h-12 w-12 items-center justify-center rounded-2xl text-xl" style={{ background: `${area.color}20`, color: area.color }}>
                    {area.icon}
                  </div>
                  <div>
                    <div className="text-lg font-semibold text-white">{area.title}</div>
                    <div className="mt-1 max-w-2xl text-sm leading-7 text-muted">{area.description}</div>
                  </div>
                </div>
                <div className="mt-4 grid gap-3 lg:grid-cols-2">
                  {areaPaths.map((path) => {
                    const isLocked = pathLockMap.get(path.id) ?? false
                    const pct = path.mission_count > 0 ? Math.round((path.completed / path.mission_count) * 100) : 0
                    return (
                      <Link key={path.id} href={isLocked ? '#' : `/path/${path.slug}`} className={isLocked ? 'pointer-events-none' : ''}>
                        <div className={`rounded-[1.5rem] border p-4 transition-all ${
                          isLocked
                            ? 'border-rim/40 bg-bg/40 opacity-45'
                            : 'border-rim/70 bg-surface/60 hover:-translate-y-0.5 hover:border-primary/40'
                        }`}>
                          <div className="flex items-center gap-3">
                            <div className="flex h-12 w-12 items-center justify-center rounded-2xl text-xl" style={{ background: `${path.color}20` }}>
                              {isLocked ? '⌁' : path.icon}
                            </div>
                            <div className="flex-1">
                              <div className="flex flex-wrap items-center gap-2">
                                <div className="text-sm font-semibold text-white">{path.title}</div>
                                {path.learning_stage && (
                                  <span className="rounded-full border border-rim/70 bg-bg/60 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-[0.16em] text-white/75">
                                    {STAGE_LABELS[path.learning_stage as keyof typeof STAGE_LABELS] ?? path.learning_stage}
                                  </span>
                                )}
                                {pct === 100 && (
                                  <span className="rounded-full border border-success/30 bg-success/10 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-[0.18em] text-success">
                                    Complete
                                  </span>
                                )}
                              </div>
                              <div className="mt-1 text-xs text-muted">{path.completed} / {path.mission_count} missioni</div>
                            </div>
                          </div>
                          <div className="mt-4 h-2 overflow-hidden rounded-full bg-bg/80">
                            <div className="h-full rounded-full" style={{ width: `${pct}%`, background: `linear-gradient(90deg, ${path.color}, #5eead4)` }} />
                          </div>
                        </div>
                      </Link>
                    )
                  })}
                </div>
              </div>
            )
          })}
        </div>
      </section>

      <BottomNav active="/dashboard" learnPath={learnPath} />
    </div>
  )
}
