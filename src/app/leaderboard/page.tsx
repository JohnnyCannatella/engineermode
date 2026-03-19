import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import BottomNav from '@/components/ui/BottomNav'

export default async function LeaderboardPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) redirect('/auth')

  const { data: players } = await supabase
    .from('profiles')
    .select('id, display_name, avatar_color, xp, level, streak')
    .order('xp', { ascending: false })
    .limit(50)

  const currentUserRank = (players || []).findIndex((player) => player.id === user.id) + 1

  const rankBadge = (index: number) => {
    if (index === 0) return '🥇'
    if (index === 1) return '🥈'
    if (index === 2) return '🥉'
    return `${index + 1}`
  }

  return (
    <div className="min-h-screen max-w-lg mx-auto px-5 pb-28 pt-8 text-white">
      <header className="pb-6">
        <Link href="/dashboard" className="mb-5 block text-sm text-slate-400 transition-colors hover:text-white">
          ← Dashboard
        </Link>
        <div className="panel-strong flex items-center justify-between">
          <div>
            <div className="eyebrow mb-3">Ranking</div>
            <h1 className="text-3xl font-semibold text-white">Classifica</h1>
            <p className="mt-2 text-sm text-slate-300">Migliori ingegneri operativi per XP e consistenza.</p>
          </div>
          {currentUserRank > 0 && (
            <div className="text-right">
              <div className="text-xs uppercase tracking-[0.16em] text-slate-500">Il tuo posto</div>
              <div className="text-2xl font-semibold text-[#7dd3fc]">#{currentUserRank}</div>
            </div>
          )}
        </div>
      </header>

      {(players || []).length >= 3 && (
        <section className="mb-5">
          <div className="grid grid-cols-3 items-end gap-2">
            {[1, 0, 2].map((position) => {
              const player = (players || [])[position]
              if (!player) return null
              const isMe = player.id === user.id
              const heights = ['h-24', 'h-32', 'h-20']
              return (
                <div key={player.id} className="flex flex-col items-center rounded-[1.6rem] border border-white/10 bg-[linear-gradient(180deg,rgba(255,255,255,0.05),rgba(255,255,255,0.02))] px-2 pt-4">
                  <div
                    className="mb-2 flex h-10 w-10 items-center justify-center rounded-full text-sm font-bold text-white"
                    style={{ background: player.avatar_color || '#f6a63b' }}
                  >
                    {(player.display_name || 'E').charAt(0).toUpperCase()}
                  </div>
                  <div className="w-full truncate px-1 text-center text-xs font-semibold text-white">
                    {isMe ? 'Tu' : (player.display_name || 'Ingegnere').split(' ')[0]}
                  </div>
                  <div className="mb-2 text-[10px] text-[#f6a63b]">
                    {player.xp >= 1000 ? `${(player.xp / 1000).toFixed(1)}k` : player.xp} XP
                  </div>
                  <div
                    className={`flex w-full items-start justify-center rounded-t-xl pt-2 text-xl ${heights[position === 0 ? 1 : position === 1 ? 0 : 2]} ${
                      isMe ? 'border-2 border-[#7dd3fc]/60' : ''
                    }`}
                    style={{
                      background:
                        position === 0
                          ? 'linear-gradient(180deg, #fbbf24, #d97706)'
                          : position === 1
                            ? 'linear-gradient(180deg, #9ca3af, #6b7280)'
                            : 'linear-gradient(180deg, #f97316, #ea580c)',
                    }}
                  >
                    {rankBadge(position)}
                  </div>
                </div>
              )
            })}
          </div>
        </section>
      )}

      <section>
        <h2 className="eyebrow mb-3">Classifica Completa</h2>
        <div className="flex flex-col gap-2">
          {(players || []).map((player, index) => {
            const isMe = player.id === user.id
            const name = player.display_name || 'Ingegnere'
            return (
              <div
                key={player.id}
                className={`flex items-center gap-3 rounded-xl border p-3 transition-all ${
                  isMe ? 'border-[#7dd3fc]/30 bg-[#7dd3fc]/10' : 'border-white/10 bg-white/5'
                }`}
              >
                <span className={`w-7 flex-shrink-0 text-center text-sm font-bold ${
                  index < 3 ? 'text-2xl' : 'text-slate-500'
                }`}>
                  {rankBadge(index)}
                </span>
                <div
                  className="flex h-9 w-9 flex-shrink-0 items-center justify-center rounded-full text-sm font-bold text-white"
                  style={{ background: player.avatar_color || '#f6a63b' }}
                >
                  {name.charAt(0).toUpperCase()}
                </div>
                <div className="min-w-0 flex-1">
                  <div className={`truncate text-sm font-semibold ${isMe ? 'text-[#7dd3fc]' : 'text-white'}`}>
                    {name}{isMe ? ' (tu)' : ''}
                  </div>
                  <div className="text-xs text-slate-400">Livello {player.level} · {player.streak}🔥</div>
                </div>
                <div className="flex-shrink-0 text-sm font-bold text-[#f6a63b]">
                  {player.xp >= 1000 ? `${(player.xp / 1000).toFixed(1)}k` : player.xp} XP
                </div>
              </div>
            )
          })}
        </div>
      </section>

      <BottomNav active="/leaderboard" />
    </div>
  )
}
