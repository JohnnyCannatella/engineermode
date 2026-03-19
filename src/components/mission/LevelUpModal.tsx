'use client'

interface Props {
  level: number
  onContinue: () => void
}

export default function LevelUpModal({ level, onContinue }: Props) {
  return (
    <div className="fixed inset-0 z-[90] flex items-center justify-center bg-bg/85 backdrop-blur-md">
      <div className="bg-surface border border-primary/50 rounded-3xl p-8 mx-6 text-center max-w-xs w-full animate-fade-up shadow-2xl">
        {/* Glow */}
        <div
          className="absolute inset-0 rounded-3xl opacity-20 blur-2xl"
          style={{ background: 'radial-gradient(circle, #7c3aed, transparent 70%)' }}
        />

        <div className="relative">
          <div className="text-6xl mb-3 animate-score-pop">⭐</div>
          <div className="text-xs font-bold text-primary-light uppercase tracking-widest mb-2">Livello superiore!</div>
          <div
            className="text-5xl font-black mb-3"
            style={{ background: 'linear-gradient(135deg, #7c3aed, #06b6d4)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}
          >
            {level}
          </div>
          <p className="text-muted text-sm mb-6 leading-relaxed">
            Hai raggiunto il <span className="text-white font-semibold">Livello {level}</span>. Continua a costruire la tua intuizione da ingegnere.
          </p>
          <button
            onClick={onContinue}
            className="w-full py-3.5 rounded-xl font-semibold text-white text-base"
            style={{ background: 'linear-gradient(135deg, #7c3aed, #6d28d9)' }}
          >
            Continua così →
          </button>
        </div>
      </div>
    </div>
  )
}
