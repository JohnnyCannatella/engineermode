'use client'

import { useState, useTransition } from 'react'
import { purchaseStreakShield } from '@/app/actions'

interface Props {
  shields: number
  xp: number
}

export default function StreakShieldButton({ shields, xp }: Props) {
  const [currentShields, setCurrentShields] = useState(shields)
  const [currentXp, setCurrentXp] = useState(xp)
  const [message, setMessage] = useState<{ text: string; ok: boolean } | null>(null)
  const [isPending, startTransition] = useTransition()

  function buy() {
    startTransition(async () => {
      const result = await purchaseStreakShield()
      if ('error' in result) {
        setMessage({ text: result.error ?? 'Error', ok: false })
      } else {
        setCurrentShields((s) => s + 1)
        setCurrentXp((x) => x - 100)
        setMessage({ text: 'Scudo acquistato!', ok: true })
      }
      setTimeout(() => setMessage(null), 3000)
    })
  }

  const shieldIcons = Array.from({ length: 3 }, (_, i) => i < currentShields)

  return (
    <div className="bg-surface border border-rim/50 rounded-2xl p-4">
      <div className="flex items-center gap-3 mb-3">
        <div className="flex gap-1.5">
          {shieldIcons.map((active, i) => (
            <span key={i} className={`text-2xl ${active ? '' : 'grayscale opacity-30'}`}>🛡️</span>
          ))}
        </div>
        <div className="flex-1">
          <div className="text-sm font-semibold text-white">{currentShields} / 3 Scudi</div>
          <div className="text-xs text-muted">Protegge la tua serie se salti un giorno</div>
        </div>
      </div>

      {message && (
        <div className={`text-xs px-3 py-2 rounded-lg mb-3 ${message.ok ? 'bg-success/15 text-success' : 'bg-danger/15 text-danger'}`}>
          {message.text}
        </div>
      )}

      <button
        onClick={buy}
        disabled={isPending || currentShields >= 3 || currentXp < 100}
        className="w-full py-2.5 rounded-xl text-sm font-semibold transition-all disabled:opacity-40"
        style={{ background: currentShields >= 3 || currentXp < 100 ? 'transparent' : 'linear-gradient(135deg, #7c3aed, #6d28d9)', border: currentShields >= 3 || currentXp < 100 ? '1px solid rgba(42,42,69,0.5)' : 'none', color: currentShields >= 3 || currentXp < 100 ? '#6b7280' : 'white' }}
      >
        {isPending
          ? 'Acquisto...'
          : currentShields >= 3
          ? 'Scudi al massimo'
          : currentXp < 100
          ? 'Servono 100 XP per acquistare'
          : `Acquista scudo · 100 XP (hai ${currentXp})`}
      </button>
    </div>
  )
}
