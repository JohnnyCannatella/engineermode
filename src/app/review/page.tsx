import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import BottomNav from '@/components/ui/BottomNav'

export default async function ReviewPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) redirect('/auth')

  const { data: paths } = await supabase.from('learning_paths').select('id, slug').eq('is_published', true)
  const pathSlugById = new Map((paths || []).map((p) => [p.id, p.slug]))

  // Missioni in scadenza (next_review_at <= adesso)
  const { data: dueMastery } = await supabase
    .from('user_mission_mastery')
    .select('mission_id, mastery_level, last_score_pct, completion_count, next_review_at, last_completed_at')
    .eq('user_id', user.id)
    .lte('next_review_at', new Date().toISOString())
    .order('next_review_at', { ascending: true })

  // Missioni in apprendimento (non ancora in scadenza ma mastery bassa)
  const { data: learningMastery } = await supabase
    .from('user_mission_mastery')
    .select('mission_id, mastery_level, last_score_pct, completion_count, next_review_at')
    .eq('user_id', user.id)
    .eq('mastery_level', 'learning')
    .gt('next_review_at', new Date().toISOString())
    .order('next_review_at', { ascending: true })
    .limit(5)

  const allMasteryItems = [...(dueMastery || []), ...(learningMastery || [])]
  const missionIds = allMasteryItems.map((m) => m.mission_id)

  const { data: missions } = missionIds.length > 0
    ? await supabase
        .from('missions')
        .select('id, title, description, icon, xp_reward, estimated_minutes, path_id')
        .in('id', missionIds)
    : { data: [] }

  const missionMap = new Map((missions || []).map((m) => [m.id, m]))
  const dueItems = (dueMastery || []).map((m) => ({ ...m, mission: missionMap.get(m.mission_id) })).filter((m) => m.mission)
  const upcomingItems = (learningMastery || []).map((m) => ({ ...m, mission: missionMap.get(m.mission_id) })).filter((m) => m.mission)

  const learnPath = paths?.[0]?.slug ?? 'systems-foundations'

  const masteryColors: Record<string, string> = {
    learning:   'border-[#f472b6]/30 bg-[#f472b6]/10 text-[#f9a8d4]',
    practicing: 'border-[#f6a63b]/30 bg-[#f6a63b]/10 text-[#f8c777]',
    mastered:   'border-[#2dd4bf]/30 bg-[#2dd4bf]/10 text-[#81f4e1]',
  }
  const masteryLabels: Record<string, string> = {
    learning:   'Apprendimento',
    practicing: 'Consolidamento',
    mastered:   'Padronanza',
  }

  return (
    <div className="min-h-screen max-w-lg mx-auto px-5 pb-28 pt-8 text-white">
      <header className="mb-6">
        <Link href="/dashboard" className="mb-5 block text-sm text-slate-400 transition-colors hover:text-white">
          ← Dashboard
        </Link>
        <div className="panel-strong">
          <div className="eyebrow mb-2 text-[10px] text-primary-light">Sistema di Ripasso</div>
          <h1 className="text-3xl font-semibold text-white">Ripasso Attivo</h1>
          <p className="mt-2 text-sm leading-7 text-muted">
            Le missioni vengono riprogrammate in base alla tua mastery. Ripassare consolida la comprensione a lungo termine.
          </p>
          <div className="mt-4 grid grid-cols-3 gap-3">
            <div className="rounded-2xl border border-white/10 bg-white/5 p-3 text-center">
              <div className="text-2xl font-semibold text-white">{dueItems.length}</div>
              <div className="mt-1 text-[10px] uppercase tracking-[0.14em] text-slate-500">In scadenza</div>
            </div>
            <div className="rounded-2xl border border-white/10 bg-white/5 p-3 text-center">
              <div className="text-2xl font-semibold text-white">{upcomingItems.length}</div>
              <div className="mt-1 text-[10px] uppercase tracking-[0.14em] text-slate-500">In arrivo</div>
            </div>
            <div className="rounded-2xl border border-white/10 bg-white/5 p-3 text-center">
              <div className="text-2xl font-semibold text-white">{dueItems.length + upcomingItems.length}</div>
              <div className="mt-1 text-[10px] uppercase tracking-[0.14em] text-slate-500">Totali</div>
            </div>
          </div>
        </div>
      </header>

      {dueItems.length > 0 && (
        <section className="mb-6">
          <h2 className="eyebrow mb-3 text-[10px] text-warning">⚡ Da ripassare ora</h2>
          <div className="flex flex-col gap-3">
            {dueItems.map(({ mission, mastery_level, last_score_pct, completion_count, next_review_at }) => {
              if (!mission) return null
              const overdueDays = next_review_at
                ? Math.max(0, Math.floor((Date.now() - new Date(next_review_at).getTime()) / 86400000))
                : 0
              return (
                <div key={mission.id} className="panel-strong rounded-[1.9rem] p-5">
                  <div className="flex items-start justify-between gap-3">
                    <div className="flex items-center gap-3">
                      <div className="flex h-12 w-12 flex-shrink-0 items-center justify-center rounded-[1.2rem] border border-white/10 bg-white/5 text-2xl">
                        {mission.icon}
                      </div>
                      <div>
                        <div className="text-sm font-semibold text-white">{mission.title}</div>
                        <div className="mt-1 flex flex-wrap items-center gap-2">
                          <span className={`rounded-full border px-2 py-0.5 text-[10px] font-semibold uppercase tracking-[0.12em] ${masteryColors[mastery_level] ?? masteryColors.learning}`}>
                            {masteryLabels[mastery_level] ?? mastery_level}
                          </span>
                          {overdueDays > 0 && (
                            <span className="text-[10px] text-warning">
                              +{overdueDays}g in ritardo
                            </span>
                          )}
                        </div>
                      </div>
                    </div>
                  </div>
                  <div className="mt-4 flex items-center justify-between gap-3 text-xs text-muted">
                    <span>Precisione: {Math.round(last_score_pct)}%</span>
                    <span>{completion_count}× completata</span>
                    <span>⏱ {mission.estimated_minutes} min</span>
                  </div>
                  <div className="mt-4">
                    <div className="mb-1.5 flex items-center justify-between">
                      <span className="text-[10px] uppercase tracking-[0.14em] text-slate-500">Mastery</span>
                      <span className="text-[10px] text-muted">{Math.round(last_score_pct)}%</span>
                    </div>
                    <div className="h-1.5 overflow-hidden rounded-full bg-[#08111f]">
                      <div
                        className="h-full rounded-full"
                        style={{
                          width: `${Math.round(last_score_pct)}%`,
                          background: last_score_pct >= 80 ? '#2dd4bf' : last_score_pct >= 50 ? '#f6a63b' : '#f472b6',
                        }}
                      />
                    </div>
                  </div>
                  <Link
                    href={`/mission/${mission.id}`}
                    className="mt-4 flex w-full items-center justify-center rounded-2xl border border-[#f6a63b]/40 bg-[linear-gradient(135deg,#f6a63b,#d97706)] py-3 text-xs font-semibold uppercase tracking-[0.18em] text-slate-950 shadow-[0_12px_28px_rgba(245,158,11,0.2)]"
                  >
                    Avvia Ripasso → +{mission.xp_reward} XP
                  </Link>
                </div>
              )
            })}
          </div>
        </section>
      )}

      {upcomingItems.length > 0 && (
        <section className="mb-6">
          <h2 className="eyebrow mb-3 text-[10px] text-primary-light">In programma</h2>
          <div className="flex flex-col gap-2">
            {upcomingItems.map(({ mission, mastery_level, last_score_pct, next_review_at }) => {
              if (!mission) return null
              const daysUntil = next_review_at
                ? Math.max(0, Math.ceil((new Date(next_review_at).getTime() - Date.now()) / 86400000))
                : 0
              return (
                <div key={mission.id} className="panel flex items-center gap-3 rounded-[1.4rem] p-4">
                  <div className="flex h-10 w-10 flex-shrink-0 items-center justify-center rounded-[1rem] border border-white/10 bg-white/5 text-xl">
                    {mission.icon}
                  </div>
                  <div className="min-w-0 flex-1">
                    <div className="truncate text-sm font-semibold text-white">{mission.title}</div>
                    <div className="mt-1 flex gap-2 text-[10px] text-muted">
                      <span>{masteryLabels[mastery_level] ?? mastery_level}</span>
                      <span>·</span>
                      <span>{Math.round(last_score_pct)}% precisione</span>
                    </div>
                  </div>
                  <div className="flex-shrink-0 text-right">
                    <div className="text-xs font-semibold text-white">tra {daysUntil}g</div>
                    <div className="text-[10px] text-muted">ripasso</div>
                  </div>
                </div>
              )
            })}
          </div>
        </section>
      )}

      {dueItems.length === 0 && upcomingItems.length === 0 && (
        <div className="panel-strong flex flex-col items-center gap-4 py-12 text-center">
          <div className="text-5xl">🎯</div>
          <h2 className="text-xl font-semibold text-white">Nessun ripasso in scadenza</h2>
          <p className="max-w-xs text-sm leading-7 text-muted">
            Completa più missioni per attivare il sistema di ripasso automatico basato sulla tua mastery.
          </p>
          <Link
            href="/dashboard"
            className="rounded-2xl border border-[#f6a63b]/40 bg-[linear-gradient(135deg,#f6a63b,#d97706)] px-6 py-3 text-xs font-semibold uppercase tracking-[0.18em] text-slate-950"
          >
            Vai alle missioni
          </Link>
        </div>
      )}

      <BottomNav active="/review" learnPath={learnPath} />
    </div>
  )
}
