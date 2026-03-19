import { redirect, notFound } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import type { MissionPrerequisite, UserMissionProgress } from '@/types'
import BottomNav from '@/components/ui/BottomNav'

const STAGE_LABELS = {
  foundation: 'Fondamenta',
  builder: 'Costruttore',
  inventor: 'Inventore',
  architect: 'Architetto',
} as const

export default async function PathPage(props: PageProps<'/path/[slug]'>) {
  const { slug } = await props.params
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()
  if (!user) redirect('/auth')

  const [{ data: path }, { data: missions }, { data: progress }] = await Promise.all([
    supabase.from('learning_paths').select('*').eq('slug', slug).single(),
    supabase
      .from('missions')
      .select('*')
      .eq('path_id', (await supabase.from('learning_paths').select('id').eq('slug', slug).single()).data?.id ?? '')
      .order('order_index'),
    supabase.from('user_mission_progress').select('*').eq('user_id', user.id),
  ])

  if (!path) notFound()

  const { data: area } = path.area_slug
    ? await supabase.from('learning_areas').select('title,color,icon').eq('slug', path.area_slug).maybeSingle()
    : { data: null }

  const progressMap = new Map<string, UserMissionProgress>((progress || []).map((p) => [p.mission_id, p]))
  const missionIds = (missions || []).map((mission) => mission.id)
  const { data: prerequisiteRows } = missionIds.length > 0
    ? await supabase.from('mission_prerequisites').select('mission_id, prerequisite_mission_id').in('mission_id', missionIds)
    : { data: [] as MissionPrerequisite[] }

  const prerequisiteMap = new Map<string, string[]>()
  for (const row of (prerequisiteRows || []) as MissionPrerequisite[]) {
    const existing = prerequisiteMap.get(row.mission_id) ?? []
    existing.push(row.prerequisite_mission_id)
    prerequisiteMap.set(row.mission_id, existing)
  }

  const completed = (missions || []).filter((m) => progressMap.get(m.id)?.status === 'completed').length
  const totalXp = (missions || []).reduce((sum, mission) => sum + (progressMap.get(mission.id)?.xp_earned ?? 0), 0)
  const pct = path.mission_count > 0 ? Math.round((completed / path.mission_count) * 100) : 0
  const nextUnlockedMission = (missions || []).find((mission, index) => {
    const missionProgress = progressMap.get(mission.id)
    if (missionProgress?.status === 'completed') return false
    const prerequisites = prerequisiteMap.get(mission.id) ?? []
    const sequentialFallback = index > 0 ? [(missions || [])[index - 1]?.id].filter(Boolean) as string[] : []
    const requiredMissionIds = prerequisites.length > 0 ? prerequisites : sequentialFallback
    return requiredMissionIds.every((requiredId) => progressMap.get(requiredId)?.status === 'completed')
  })

  return (
    <div className="mx-auto min-h-screen max-w-5xl px-4 pb-32 pt-6 text-white sm:px-6 lg:px-8">
      <header className="panel-strong rounded-[2rem] p-5 sm:p-7">
        <Link href="/dashboard" className="inline-flex items-center gap-2 text-sm text-muted transition-colors hover:text-white">
          ← Torna al mission control
        </Link>

        <div className="mt-6 flex flex-col gap-6 lg:flex-row lg:items-start lg:justify-between">
          <div className="max-w-3xl">
            {area && (
              <div className="hud-chip mb-4" style={{ borderColor: `${area.color}45`, color: area.color }}>
                <span>{area.icon}</span>
                <span className="eyebrow text-[10px]">{area.title}</span>
              </div>
            )}
            {path.learning_stage && (
              <div className="hud-chip mb-4">
                <span>◌</span>
                <span className="eyebrow text-[10px]">
                  {STAGE_LABELS[path.learning_stage as keyof typeof STAGE_LABELS] ?? path.learning_stage}
                </span>
              </div>
            )}
            <div className="flex items-center gap-4">
              <div className="flex h-16 w-16 items-center justify-center rounded-[1.5rem] border border-rim/80 bg-surface/70 text-3xl">
                {path.icon}
              </div>
              <div>
                <h1 className="text-3xl font-bold tracking-[-0.05em] text-white sm:text-4xl">{path.title}</h1>
                <div className="mt-2 text-sm text-muted">{completed} / {path.mission_count} missioni completate · {totalXp} XP guadagnati</div>
              </div>
            </div>
            {path.description && (
              <p className="mt-5 max-w-2xl text-sm leading-7 text-muted sm:text-base">{path.description}</p>
            )}
          </div>

          <div className="panel rounded-[1.5rem] p-4 lg:min-w-64">
            <div className="eyebrow text-[10px] text-primary-light">Avanzamento</div>
            <div className="mt-3 text-3xl font-semibold text-white">{pct}%</div>
            <div className="mt-1 text-xs text-muted">del percorso completato</div>
            <div className="mt-4 h-3 overflow-hidden rounded-full bg-bg/80">
              <div className="h-full rounded-full" style={{ width: `${pct}%`, background: `linear-gradient(90deg, ${path.color}, #5eead4)` }} />
            </div>
            <div className="mt-4 rounded-2xl border border-white/10 bg-white/5 p-4">
              <div className="text-[11px] uppercase tracking-[0.18em] text-slate-500">Prossimo nodo</div>
              <div className="mt-2 text-sm font-semibold text-white">{nextUnlockedMission?.title ?? 'Percorso completato'}</div>
              <div className="mt-1 text-xs text-slate-400">
                {nextUnlockedMission ? 'Missione già sbloccata e pronta da eseguire.' : 'Hai chiuso tutte le missioni di questo percorso.'}
              </div>
            </div>
          </div>
        </div>
      </header>

      <section className="mt-6 grid gap-4 md:grid-cols-3">
        <div className="panel rounded-[1.6rem] p-4">
          <div className="text-[11px] uppercase tracking-[0.18em] text-slate-500">Focus del path</div>
          <div className="mt-2 text-lg font-semibold text-white">{path.learning_stage ? STAGE_LABELS[path.learning_stage as keyof typeof STAGE_LABELS] : 'Percorso'}</div>
          <div className="mt-2 text-sm leading-7 text-muted">Questa traccia porta teoria, casi e vocabulary tecnico dentro una progressione unica.</div>
        </div>
        <div className="panel rounded-[1.6rem] p-4">
          <div className="text-[11px] uppercase tracking-[0.18em] text-slate-500">Missioni completate</div>
          <div className="mt-2 text-lg font-semibold text-white">{completed}/{path.mission_count}</div>
          <div className="mt-2 text-sm leading-7 text-muted">Ogni completamento aggiorna XP, review e mastery nel percorso.</div>
        </div>
        <div className="panel rounded-[1.6rem] p-4">
          <div className="text-[11px] uppercase tracking-[0.18em] text-slate-500">XP guadagnati</div>
          <div className="mt-2 text-lg font-semibold text-white">{totalXp}</div>
          <div className="mt-2 text-sm leading-7 text-muted">Misura utile per leggere intensità e continuità del lavoro sul path.</div>
        </div>
      </section>

      <section className="mt-6">
        <div className="mb-4 flex items-center justify-between">
          <div>
            <div className="eyebrow text-[10px] text-primary-light">Coda Missioni</div>
            <h2 className="mt-2 text-2xl font-semibold tracking-[-0.03em] text-white">Sequenza operativa del percorso</h2>
          </div>
        </div>

        <div className="grid gap-3">
          {(missions || []).map((mission, index) => {
            const missionProgress = progressMap.get(mission.id)
            const status = missionProgress?.status ?? 'not_started'
            const isCompleted = status === 'completed'
            const prerequisites = prerequisiteMap.get(mission.id) ?? []
            const sequentialFallback = index > 0 ? [(missions || [])[index - 1]?.id].filter(Boolean) as string[] : []
            const requiredMissionIds = prerequisites.length > 0 ? prerequisites : sequentialFallback
            const isLocked = !isCompleted && requiredMissionIds.some((requiredId) => progressMap.get(requiredId)?.status !== 'completed')

            return (
              <Link key={mission.id} href={isLocked ? '#' : `/mission/${mission.id}`} className={isLocked ? 'pointer-events-none' : ''}>
                <div className={`rounded-[1.6rem] border p-4 transition-all sm:p-5 ${
                  isCompleted
                    ? 'border-success/30 bg-success/5'
                    : isLocked
                    ? 'border-rim/40 bg-surface/40 opacity-45'
                    : 'panel hover:-translate-y-0.5 hover:border-primary/40'
                }`}>
                  <div className="flex items-start gap-4">
                    <div className={`flex h-14 w-14 items-center justify-center rounded-[1.3rem] text-2xl ${
                      isCompleted ? 'bg-success/15' : 'bg-surface'
                    }`}>
                      {isCompleted ? '✓' : isLocked ? '⌁' : mission.icon}
                    </div>
                    <div className="flex-1">
                      <div className="flex flex-wrap items-center gap-2">
                        <span className="font-mono text-[11px] uppercase tracking-[0.18em] text-primary-light">M-{String(mission.order_index).padStart(2, '0')}</span>
                        {mission.difficulty_level && (
                          <span className="rounded-full border border-rim/70 bg-bg/60 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-[0.16em] text-white/75">
                            {mission.difficulty_level}
                          </span>
                        )}
                        {isCompleted && (missionProgress?.max_score ?? 0) > 0 && (
                          <span className="rounded-full border border-success/25 bg-success/10 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-[0.16em] text-success">
                            {missionProgress?.score ?? 0}/{missionProgress?.max_score ?? 0} corretti
                          </span>
                        )}
                      </div>
                      <h3 className={`mt-2 text-lg font-semibold ${isLocked ? 'text-muted' : 'text-white'}`}>{mission.title}</h3>
                      <p className="mt-2 text-sm leading-7 text-muted">{mission.description}</p>
                      <div className="mt-4 flex flex-wrap gap-2">
                        <span className="hud-chip">⏱ {mission.estimated_minutes} min</span>
                        <span className="hud-chip">💎 {mission.xp_reward} XP</span>
                        {mission.learning_objectives?.[0] && (
                          <span className="hud-chip">⌁ {mission.learning_objectives[0]}</span>
                        )}
                      </div>
                      {isLocked && requiredMissionIds.length > 0 && (
                        <div className="mt-3 text-xs text-muted">
                          Sblocco vincolato ai prerequisiti completati.
                        </div>
                      )}
                    </div>
                    {!isLocked && (
                      <div className="font-mono text-lg text-white/35">{isCompleted ? '↺' : '→'}</div>
                    )}
                  </div>
                </div>
              </Link>
            )
          })}
        </div>
      </section>

      <BottomNav active={`/path/${slug}`} learnPath={slug} />
    </div>
  )
}
