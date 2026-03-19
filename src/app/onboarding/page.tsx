'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { updateProfile } from '@/app/actions'
import type { ExperienceLevel, LearningGoal } from '@/lib/profile-preferences'

const goals = [
  { value: 'career' as const, label: 'Avanzare nella carriera', emoji: '🚀' },
  { value: 'curiosity' as const, label: 'Soddisfare la mia curiosità', emoji: '🔍' },
  { value: 'study' as const, label: 'Integrare i miei studi', emoji: '📚' },
  { value: 'build' as const, label: 'Costruire sistemi migliori', emoji: '🔧' },
]

const levels = [
  { value: 'beginner' as const, label: 'Principiante completo', emoji: '🌱', desc: 'Stai iniziando ora con i concetti ingegneristici' },
  { value: 'student' as const, label: 'Studente di ingegneria', emoji: '📐', desc: 'Stai studiando queste materie in modo formale' },
  { value: 'professional' as const, label: 'Professionista', emoji: '⚙️', desc: 'Applichi già questi concetti nella pratica' },
  { value: 'expert' as const, label: 'Esperto di dominio', emoji: '🧠', desc: 'Hai profondità e vuoi ampliare il raggio' },
]

export default function OnboardingPage() {
  const [step, setStep] = useState(1)
  const [name, setName] = useState('')
  const [goal, setGoal] = useState<LearningGoal | ''>('')
  const [level, setLevel] = useState<ExperienceLevel | ''>('')
  const [loading, setLoading] = useState(false)
  const router = useRouter()

  async function finish() {
    setLoading(true)
    await updateProfile({
      display_name: name.trim() || undefined,
      goal: goal || undefined,
      experience_level: level || undefined,
      onboarding_completed: true,
    })
    router.push('/dashboard')
    router.refresh()
  }

  return (
    <main className="min-h-screen bg-bg flex flex-col items-center justify-center px-6 py-12">
      {/* Progress dots */}
      <div className="flex gap-2 mb-12">
        {[1, 2, 3].map((s) => (
          <div
            key={s}
            className={`h-1.5 rounded-full transition-all duration-300 ${
              s <= step ? 'bg-primary w-8' : 'bg-rim w-4'
            }`}
          />
        ))}
      </div>

      <div className="w-full max-w-sm">
        {/* Step 1: Name */}
        {step === 1 && (
          <div className="flex flex-col gap-6">
            <div className="text-center">
              <div className="text-4xl mb-4">👋</div>
              <h1 className="text-2xl font-bold text-white mb-2">Come vuoi essere chiamato?</h1>
              <p className="text-muted text-sm">Comparirà sul tuo profilo da ingegnere.</p>
            </div>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="Il tuo nome o nickname"
              maxLength={30}
              className="w-full px-4 py-3.5 rounded-xl bg-elevated border border-rim/60 text-white placeholder:text-muted/50 focus:outline-none focus:border-primary/60 transition-colors text-sm"
              onKeyDown={(e) => e.key === 'Enter' && name.trim() && setStep(2)}
            />
            <button
              onClick={() => setStep(2)}
              disabled={!name.trim()}
              className="w-full py-3.5 rounded-xl font-semibold text-white disabled:opacity-40 transition-opacity"
              style={{ background: 'linear-gradient(135deg, #7c3aed, #6d28d9)' }}
            >
              Continua →
            </button>
          </div>
        )}

        {/* Step 2: Goal */}
        {step === 2 && (
          <div className="flex flex-col gap-6">
            <div className="text-center">
              <div className="text-4xl mb-4">🎯</div>
              <h1 className="text-2xl font-bold text-white mb-2">Qual è il tuo obiettivo principale?</h1>
              <p className="text-muted text-sm">Lo useremo per consigliarti il miglior punto di partenza.</p>
            </div>
            <div className="flex flex-col gap-3">
              {goals.map((g) => (
                <button
                  key={g.value}
                  onClick={() => setGoal(g.value)}
                  className={`flex items-center gap-4 p-4 rounded-xl border transition-all text-left ${
                    goal === g.value
                      ? 'border-primary bg-primary/10 text-white'
                      : 'border-rim/50 bg-surface text-muted hover:border-rim hover:text-white'
                  }`}
                >
                  <span className="text-2xl">{g.emoji}</span>
                  <span className="font-medium text-sm">{g.label}</span>
                  {goal === g.value && <span className="ml-auto text-primary">✓</span>}
                </button>
              ))}
            </div>
            <button
              onClick={() => setStep(3)}
              disabled={!goal}
              className="w-full py-3.5 rounded-xl font-semibold text-white disabled:opacity-40 transition-opacity"
              style={{ background: 'linear-gradient(135deg, #7c3aed, #6d28d9)' }}
            >
              Continua →
            </button>
          </div>
        )}

        {/* Step 3: Level */}
        {step === 3 && (
          <div className="flex flex-col gap-6">
            <div className="text-center">
              <div className="text-4xl mb-4">📊</div>
              <h1 className="text-2xl font-bold text-white mb-2">Qual è il tuo livello di esperienza?</h1>
              <p className="text-muted text-sm">Lo useremo per proporti un percorso iniziale più adatto.</p>
            </div>
            <div className="flex flex-col gap-3">
              {levels.map((l) => (
                <button
                  key={l.value}
                  onClick={() => setLevel(l.value)}
                  className={`flex items-center gap-4 p-4 rounded-xl border transition-all text-left ${
                    level === l.value
                      ? 'border-primary bg-primary/10'
                      : 'border-rim/50 bg-surface hover:border-rim'
                  }`}
                >
                  <span className="text-2xl">{l.emoji}</span>
                  <div>
                    <div className={`font-medium text-sm ${level === l.value ? 'text-white' : 'text-muted'}`}>
                      {l.label}
                    </div>
                    <div className="text-xs text-muted mt-0.5">{l.desc}</div>
                  </div>
                  {level === l.value && <span className="ml-auto text-primary">✓</span>}
                </button>
              ))}
            </div>
            <button
              onClick={finish}
              disabled={!level || loading}
              className="w-full py-3.5 rounded-xl font-semibold text-white disabled:opacity-40 transition-opacity"
              style={{ background: 'linear-gradient(135deg, #7c3aed, #6d28d9)' }}
            >
              {loading ? 'Configurazione...' : 'Entra in Engineer Mode 🚀'}
            </button>
          </div>
        )}
      </div>
    </main>
  )
}
