'use client'

import { useState, useTransition, useEffect, useRef, useCallback } from 'react'
import { useRouter } from 'next/navigation'
import type { Mission, UserMissionProgress, Achievement } from '@/types'
import { completeMission, type CompleteMissionResult } from '@/app/actions'
import LessonStepView from './LessonStep'
import QuizStepView from './QuizStep'
import ChallengeStepView from './ChallengeStep'
import DesignStepView from './DesignStep'
import SortingStepView from './SortingStep'
import FillBlankStepView from './FillBlankStep'
import EstimationStepView from './EstimationStep'
import DiagramTapStepView from './DiagramTapStep'
import Confetti from './Confetti'
import LevelUpModal from './LevelUpModal'
import Toast, { type ToastItem } from '@/components/ui/Toast'

interface Props {
  mission: Mission
  alreadyCompleted: boolean
  pathSlug: string
  previousProgress?: UserMissionProgress | null
  isDaily?: boolean
}

type StepState = {
  selected: number | null
  checked: boolean
  sortedOrder?: number[] // only used for 'sorting' steps
  hintUsed?: boolean
}

type CompletionData = {
  xpEarned: number
  newXp: number
  newLevel: number
  previousLevel: number
  streakBonus: number
  newStreak: number
  newAchievements: Achievement[]
}

export default function MissionPlayer({ mission, alreadyCompleted, pathSlug, previousProgress, isDaily }: Props) {
  const [currentStep, setCurrentStep] = useState(0)
  const [stepStates, setStepStates] = useState<StepState[]>(
    mission.steps.map(() => ({ selected: null, checked: false, sortedOrder: [] }))
  )
  const [phase, setPhase] = useState<'intro' | 'playing' | 'complete'>(
    alreadyCompleted ? 'complete' : 'intro'
  )
  const [completionData, setCompletionData] = useState<CompletionData | null>(null)
  const [showLevelUp, setShowLevelUp] = useState(false)
  const [toasts, setToasts] = useState<ToastItem[]>([])
  const [scorePopKey, setScorePopKey] = useState(0)
  const [consecutiveCorrect, setConsecutiveCorrect] = useState(0)
  const [isPending, startTransition] = useTransition()
  const stepKey = useRef(0)
  const router = useRouter()

  const step = mission.steps[currentStep]
  const state = stepStates[currentStep]
  const totalSteps = mission.steps.length

  const stepTypeMeta: Record<string, { label: string; accent: string; chip: string }> = {
    lesson:      { label: 'Concetto',       accent: 'text-[#7dd3fc]', chip: 'border-[#7dd3fc]/25 bg-[#7dd3fc]/10 text-[#7dd3fc]' },
    quiz:        { label: 'Verifica',        accent: 'text-[#2dd4bf]', chip: 'border-[#2dd4bf]/25 bg-[#2dd4bf]/10 text-[#81f4e1]' },
    challenge:   { label: 'Scenario',        accent: 'text-[#f8c777]', chip: 'border-[#f6a63b]/25 bg-[#f6a63b]/10 text-[#f8c777]' },
    design:      { label: 'Design Review',   accent: 'text-[#f8c777]', chip: 'border-[#f6a63b]/25 bg-[#f6a63b]/10 text-[#f8c777]' },
    sorting:     { label: 'Ordina',          accent: 'text-[#a78bfa]', chip: 'border-[#a78bfa]/25 bg-[#a78bfa]/10 text-[#c4b5fd]' },
    'fill-blank':{ label: 'Completa',        accent: 'text-[#f472b6]', chip: 'border-[#f472b6]/25 bg-[#f472b6]/10 text-[#f9a8d4]' },
    estimation:  { label: 'Stima',           accent: 'text-[#34d399]', chip: 'border-[#34d399]/25 bg-[#34d399]/10 text-[#6ee7b7]' },
    'diagram-tap':{ label: 'Diagramma',      accent: 'text-[#818cf8]', chip: 'border-[#818cf8]/25 bg-[#818cf8]/10 text-[#a5b4fc]' },
  }

  const currentMeta = stepTypeMeta[step.type] ?? stepTypeMeta['lesson']

  // Score: count correct answers across all interactive steps
  const score = stepStates.filter((s, i) => {
    const st = mission.steps[i]
    if (!s.checked || st.type === 'lesson') return false
    if (st.type === 'sorting') {
      return s.selected === 0 // 0 = all in correct order
    }
    return s.selected === st.correct
  }).length

  const maxScore = mission.steps.filter((s) => s.type !== 'lesson').length

  const submittedAnswers = mission.steps.reduce<number[]>((answers, st, index) => {
    if (st.type === 'lesson') return answers
    answers.push(stepStates[index].selected ?? -1)
    return answers
  }, [])

  // ── Navigation helpers ──

  const canAdvance = () => {
    if (step.type === 'lesson') return true
    return state.checked
  }

  const needsCheck = () => {
    if (step.type === 'lesson') return false
    if (step.type === 'sorting') {
      const order = state.sortedOrder ?? []
      return !state.checked && order.length === (step as { items: string[] }).items.length
    }
    return !state.checked && state.selected !== null
  }

  const buttonLabel = () => {
    if (step.type !== 'lesson' && !state.checked) return null
    return currentStep === totalSteps - 1 ? 'Completa missione 🎉' : 'Avanti →'
  }

  const placeholderLabel = () => {
    if (step.type === 'sorting') return 'Ordina tutti gli elementi per continuare'
    if (step.type === 'fill-blank' || step.type === 'estimation' || step.type === 'quiz' || step.type === 'challenge' || step.type === 'design' || step.type === 'diagram-tap') {
      return 'Seleziona una risposta per continuare'
    }
    return ''
  }

  // ── State updaters ──

  function selectOption(idx: number) {
    if (state.checked) return
    setStepStates((prev) => {
      const next = [...prev]
      next[currentStep] = { ...next[currentStep], selected: idx }
      return next
    })
  }

  function useHint() {
    if (state.hintUsed || state.checked) return
    setStepStates((prev) => {
      const next = [...prev]
      next[currentStep] = { ...next[currentStep], hintUsed: true }
      return next
    })
  }

  function setSortedOrder(order: number[]) {
    setStepStates((prev) => {
      const next = [...prev]
      next[currentStep] = { ...next[currentStep], sortedOrder: order }
      return next
    })
  }

  function checkAnswer() {
    let isCorrect = false

    if (step.type === 'sorting') {
      const sortedItems = (step as { items: string[] }).items
      const order = state.sortedOrder ?? []
      isCorrect = order.join(',') === sortedItems.map((_, i) => i).join(',')
      setStepStates((prev) => {
        const next = [...prev]
        next[currentStep] = { ...next[currentStep], checked: true, selected: isCorrect ? 0 : -1 }
        return next
      })
    } else {
      isCorrect = step.type !== 'lesson' && state.selected === (step as { correct: number }).correct
      setStepStates((prev) => {
        const next = [...prev]
        next[currentStep] = { ...next[currentStep], checked: true }
        return next
      })
    }

    if (isCorrect) {
      setScorePopKey((k) => k + 1)
      const next = consecutiveCorrect + 1
      setConsecutiveCorrect(next)
      if (next === 3) addToast({ message: '3 risposte corrette di fila!', icon: '🔥', color: 'success' })
      else if (next === 5) addToast({ message: '5 perfette! Sei in stato di flow!', icon: '⚡', color: 'achievement' })
    } else {
      setConsecutiveCorrect(0)
    }
  }

  const addToast = useCallback((item: Omit<ToastItem, 'id'>) => {
    const id = Math.random().toString(36).slice(2)
    setToasts((prev) => [...prev, { ...item, id }])
  }, [])

  const dismissToast = useCallback((id: string) => {
    setToasts((prev) => prev.filter((t) => t.id !== id))
  }, [])

  function advance() {
    if (currentStep < totalSteps - 1) {
      stepKey.current += 1
      setCurrentStep((c) => c + 1)
    } else {
      startTransition(async () => {
        const result: CompleteMissionResult = await completeMission(mission.id, submittedAnswers, isDaily)
        if ('error' in result) return
        setCompletionData(result)
        if (result.newLevel > result.previousLevel) {
          setShowLevelUp(true)
        } else {
          setPhase('complete')
        }
      })
    }
  }

  // Achievement toasts
  useEffect(() => {
    if (phase !== 'complete' || !completionData) return
    completionData.newAchievements.forEach((a, i) => {
      setTimeout(() => {
        addToast({ message: `Obiettivo: ${a.title}`, icon: a.icon, color: 'achievement' })
      }, i * 600)
    })
  }, [phase, completionData, addToast])

  // Streak bonus toast
  useEffect(() => {
    if (phase !== 'complete' || !completionData || completionData.streakBonus === 0) return
    setTimeout(() => {
      addToast({ message: `Bonus serie ${completionData.streakBonus}% applicato!`, icon: '🔥', color: 'success' })
    }, 300)
  }, [phase, completionData, addToast])

  // Keyboard navigation
  useEffect(() => {
    if (phase !== 'playing') return
    function onKey(e: KeyboardEvent) {
      if (e.target instanceof HTMLInputElement || e.target instanceof HTMLTextAreaElement) return
      if (e.key === ' ' || e.key === 'Enter') {
        e.preventDefault()
        if (needsCheck()) { checkAnswer(); return }
        if (canAdvance() && buttonLabel()) advance()
      }
      const num = parseInt(e.key)
      if (!isNaN(num) && num >= 1 && num <= 4) {
        if (step.type === 'quiz' || step.type === 'challenge' || step.type === 'design' || step.type === 'fill-blank' || step.type === 'estimation' || step.type === 'diagram-tap') {
          const opts = (step as { options: string[] }).options
          if (opts && num <= opts.length && !state.checked) selectOption(num - 1)
        }
      }
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [phase, currentStep, state, step])

  // ── Level-up overlay ──
  if (showLevelUp && completionData) {
    return (
      <LevelUpModal
        level={completionData.newLevel}
        onContinue={() => { setShowLevelUp(false); setPhase('complete') }}
      />
    )
  }

  // ── Intro screen ──
  if (phase === 'intro') {
    return (
      <div className="min-h-screen text-white max-w-lg mx-auto px-5 py-8 flex flex-col justify-center">
        {isDaily && (
          <div className="hud-chip mb-4 animate-fade-up">
            <span className="text-sm text-warning">⚡</span>
            <span>Sfida del Giorno · 2× XP</span>
          </div>
        )}
        <div className="panel-strong animate-fade-up">
          <div className="flex items-start justify-between gap-4">
            <div>
              <div className="eyebrow mb-3">Mission Brief</div>
              <h1 className="text-3xl font-semibold leading-tight text-white">{mission.title}</h1>
              <p className="mt-3 text-sm leading-7 text-slate-300">{mission.description}</p>
            </div>
            <div className="flex h-16 w-16 items-center justify-center rounded-[1.6rem] border border-white/10 bg-white/5 text-3xl shadow-[0_20px_40px_rgba(8,17,31,0.35)]">
              {mission.icon}
            </div>
          </div>

          <div className="hud-divider my-5" />

          <div className="grid grid-cols-3 gap-3">
            <div className="rounded-2xl border border-white/10 bg-white/5 px-3 py-4">
              <div className="text-[11px] uppercase tracking-[0.24em] text-slate-500">Step</div>
              <div className="mt-2 text-2xl font-semibold text-white">{totalSteps}</div>
              <div className="text-xs text-slate-400">sequenze</div>
            </div>
            <div className="rounded-2xl border border-white/10 bg-white/5 px-3 py-4">
              <div className="text-[11px] uppercase tracking-[0.24em] text-slate-500">Durata</div>
              <div className="mt-2 text-2xl font-semibold text-white">{mission.estimated_minutes}</div>
              <div className="text-xs text-slate-400">minuti</div>
            </div>
            <div className="rounded-2xl border border-white/10 bg-white/5 px-3 py-4">
              <div className="text-[11px] uppercase tracking-[0.24em] text-slate-500">Reward</div>
              <div className="mt-2 text-2xl font-semibold text-[#f6a63b]">
                +{isDaily ? mission.xp_reward * 2 : mission.xp_reward}
              </div>
              <div className="text-xs text-slate-400">XP{isDaily ? ' 2x' : ''}</div>
            </div>
          </div>

          {/* Step type breakdown */}
          <div className="mt-4 flex flex-wrap gap-2">
            {Array.from(new Set(mission.steps.map((s) => s.type))).map((type) => {
              const meta = stepTypeMeta[type]
              const count = mission.steps.filter((s) => s.type === type).length
              return (
                <span key={type} className={`rounded-full border px-2.5 py-1 text-[10px] font-semibold uppercase tracking-[0.14em] ${meta?.chip ?? ''}`}>
                  {count}× {meta?.label ?? type}
                </span>
              )
            })}
          </div>

          <div className="mt-4 rounded-2xl border border-[#2dd4bf]/20 bg-[linear-gradient(135deg,rgba(45,212,191,0.1),rgba(16,24,40,0.08))] px-4 py-3 text-sm text-slate-300">
            Sistema di apprendimento: le risposte corrette aumentano la mastery e programmano il prossimo ripasso.
          </div>
        </div>
        <div className="mt-5 grid gap-3 animate-fade-up" style={{ animationDelay: '120ms' }}>
          <button
            onClick={() => setPhase('playing')}
            className="w-full rounded-2xl border border-[#f6a63b]/40 bg-[linear-gradient(135deg,#f6a63b,#d97706)] px-5 py-4 text-sm font-semibold uppercase tracking-[0.18em] text-slate-950 shadow-[0_18px_38px_rgba(245,158,11,0.22)]"
          >
            Avvia Missione
          </button>
          <button
            onClick={() => router.back()}
            className="w-full rounded-2xl border border-white/10 bg-white/5 px-5 py-3 text-sm font-medium text-slate-300 transition-colors hover:text-white"
          >
            Torna al percorso
          </button>
        </div>
      </div>
    )
  }

  // ── Completion screen ──
  if (phase === 'complete') {
    const data = completionData
    const prevScore = previousProgress?.score ?? 0
    const prevMax = previousProgress?.max_score ?? 0
    const displayScore = data ? score : prevScore
    const displayMax = data ? maxScore : prevMax
    const pct = displayMax > 0 ? Math.round((displayScore / displayMax) * 100) : 100
    const isPerfect = pct === 100

    const wrongAnswers = mission.steps
      .map((st, i) => ({ step: st, state: stepStates[i], idx: i }))
      .filter(({ step: st, state: s }) => {
        if (st.type === 'lesson' || !s.checked) return false
        if (st.type === 'sorting') return s.selected !== 0
        return s.selected !== (st as { correct: number }).correct
      })

    return (
      <div className="min-h-screen flex flex-col max-w-lg mx-auto px-5 pb-12 pt-8 text-white">
        <Toast items={toasts} onDismiss={dismissToast} />
        {isPerfect && data && <Confetti />}

        <div className="panel-strong animate-fade-up">
          <div className="eyebrow mb-3">Rapporto Missione</div>
          <div className="flex flex-col items-center text-center pb-2">
            <div className="text-6xl mb-4">{isPerfect ? '🎯' : pct >= 60 ? '⭐' : '📚'}</div>
            <h1 className="text-3xl font-semibold text-white mb-2">
              {alreadyCompleted && !data ? 'Già completata' : 'Missione completata!'}
            </h1>
            <p className="text-sm leading-7 text-slate-300 mb-6">
              {isPerfect ? 'Punteggio perfetto — eccellente!' : displayMax > 0 ? `${displayScore} di ${displayMax} corretti` : 'Ben fatto!'}
            </p>
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
              <div className="text-[11px] uppercase tracking-[0.24em] text-slate-500">Precisione</div>
              <div className="mt-2 text-3xl font-semibold text-white">{pct}%</div>
              <div className="text-xs text-slate-400">{displayScore}/{displayMax || 0} risposte corrette</div>
            </div>
            <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
              <div className="text-[11px] uppercase tracking-[0.24em] text-slate-500">Serie</div>
              <div className="mt-2 text-3xl font-semibold text-white">{data?.newStreak ?? 0}</div>
              <div className="text-xs text-slate-400">giorni operativi</div>
            </div>
          </div>

          <div className="mt-4 flex flex-col gap-3 rounded-[1.75rem] border border-white/10 bg-[linear-gradient(180deg,rgba(255,255,255,0.06),rgba(255,255,255,0.02))] p-5">
            {data && (
              <>
                <div className="flex items-center justify-between">
                  <span className="text-sm text-slate-400">XP guadagnati</span>
                  <div className="flex items-center gap-2">
                    {data.streakBonus > 0 && (
                      <span className="rounded-full border border-[#2dd4bf]/30 bg-[#2dd4bf]/10 px-2 py-0.5 text-[11px] font-semibold uppercase tracking-[0.16em] text-[#81f4e1]">
                        +{data.streakBonus}% serie
                      </span>
                    )}
                    <span className="font-bold text-[#f6a63b]">+{data.xpEarned}</span>
                  </div>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-sm text-slate-400">Livello</span>
                  <span className="font-bold text-[#7dd3fc]">{data.previousLevel} → {data.newLevel}</span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-sm text-slate-400">Serie</span>
                  <span className="font-bold text-white">{data.newStreak} 🔥</span>
                </div>
              </>
            )}
            {displayMax > 0 && (
              <div className="flex items-center justify-between">
                <span className="text-sm text-slate-400">Punteggio</span>
                <span className="font-bold text-white">{displayScore}/{displayMax} ({pct}%)</span>
              </div>
            )}
            {alreadyCompleted && !data && previousProgress?.xp_earned != null && (
              <div className="flex items-center justify-between">
                <span className="text-sm text-slate-400">XP guadagnati</span>
                <span className="font-bold text-[#f6a63b]">+{previousProgress.xp_earned}</span>
              </div>
            )}
          </div>

          <div className="mt-5 flex flex-col gap-3">
            <button
              onClick={() => { router.push(`/path/${pathSlug}`); router.refresh() }}
              className="w-full rounded-2xl border border-[#f6a63b]/40 bg-[linear-gradient(135deg,#f6a63b,#d97706)] px-5 py-4 text-sm font-semibold uppercase tracking-[0.18em] text-slate-950 shadow-[0_18px_38px_rgba(245,158,11,0.22)]"
            >
              Continua Percorso
            </button>
            <button
              onClick={() => router.push('/dashboard')}
              className="w-full rounded-2xl border border-white/10 bg-white/5 px-5 py-3 text-sm font-medium text-slate-300 transition-colors hover:text-white"
            >
              Torna alla dashboard
            </button>
          </div>
        </div>

        {wrongAnswers.length > 0 && (
          <section className="mt-5 animate-fade-up" style={{ animationDelay: '280ms' }}>
            <div className="panel">
              <h2 className="eyebrow mb-3">Revisione Errori</h2>
              <div className="flex flex-col gap-3">
                {wrongAnswers.map(({ step: st, state: s, idx }) => {
                  if (st.type === 'lesson') return null
                  if (st.type === 'sorting') {
                    return (
                      <div key={idx} className="rounded-[1.5rem] border border-[#f6a63b]/30 bg-[linear-gradient(180deg,rgba(246,166,59,0.10),rgba(15,29,50,0.45))] p-4">
                        <p className="mb-2 text-sm font-medium text-white">{st.question}</p>
                        <div className="text-[10px] uppercase tracking-[0.14em] text-slate-500 mb-1.5">Ordine corretto:</div>
                        {st.items.map((item, i) => (
                          <div key={i} className="mb-1 flex gap-2 text-sm text-[#81f4e1]">
                            <span className="font-mono text-xs">{i + 1}.</span><span>{item}</span>
                          </div>
                        ))}
                      </div>
                    )
                  }
                  const stTyped = st as { question?: string; title?: string; options: string[]; correct: number; explanation: string }
                  return (
                    <div key={idx} className="rounded-[1.5rem] border border-[#ef4444]/30 bg-[linear-gradient(180deg,rgba(239,68,68,0.12),rgba(15,29,50,0.45))] p-4">
                      <p className="mb-3 text-sm font-medium leading-7 text-white">{stTyped.question ?? stTyped.title}</p>
                      {stTyped.options.map((opt, oi) => (
                        <div
                          key={oi}
                          className={`mb-1.5 flex items-center gap-2 rounded-xl px-3 py-2 text-sm ${
                            oi === stTyped.correct
                              ? 'border border-[#2dd4bf]/40 bg-[#2dd4bf]/15 text-[#81f4e1]'
                              : oi === s.selected
                              ? 'border border-[#ef4444]/40 bg-[#ef4444]/15 text-[#fca5a5]'
                              : 'text-slate-400'
                          }`}
                        >
                          <span>{oi === stTyped.correct ? '✓' : oi === s.selected ? '✗' : '○'}</span>
                          <span>{opt}</span>
                        </div>
                      ))}
                      <p className="mt-3 border-t border-white/10 pt-3 text-xs leading-6 text-slate-400">{stTyped.explanation}</p>
                    </div>
                  )
                })}
              </div>
            </div>
          </section>
        )}
      </div>
    )
  }

  // ── Playing screen ──
  const isInteractive = step.type !== 'lesson'

  return (
    <div className="min-h-screen flex flex-col max-w-lg mx-auto px-5 pt-6 pb-8 text-white">
      <Toast items={toasts} onDismiss={dismissToast} />

      <div className="panel-strong flex-shrink-0">
        {isDaily && (
          <div className="mb-4 flex items-center justify-center gap-1.5 text-xs font-semibold uppercase tracking-[0.18em] text-[#f6a63b]">
            <span>⚡</span><span>Sfida del Giorno · 2× XP</span>
          </div>
        )}
        <div className="mb-4 flex items-start justify-between gap-3">
          <div>
            <div className="eyebrow mb-2">Mission Control</div>
            <div className="text-xl font-semibold text-white">{mission.title}</div>
            <div className="mt-2 flex flex-wrap items-center gap-2">
              <span className={`rounded-full border px-2.5 py-1 text-[10px] font-semibold uppercase tracking-[0.16em] ${currentMeta.chip}`}>
                {currentMeta.label}
              </span>
              <span className="text-xs uppercase tracking-[0.2em] text-slate-500">
                Step {currentStep + 1} / {totalSteps}
              </span>
              {isInteractive && !state.checked && (
                <button
                  onClick={useHint}
                  disabled={state.hintUsed}
                  className={`ml-auto rounded-lg border px-2 py-1 text-[10px] font-semibold uppercase tracking-[0.14em] transition-all ${
                    state.hintUsed
                      ? 'border-white/10 text-slate-600 cursor-default'
                      : 'border-[#f6a63b]/30 bg-[#f6a63b]/8 text-[#f6a63b] hover:bg-[#f6a63b]/15'
                  }`}
                >
                  {state.hintUsed ? '💡 usato' : '💡 suggerimento'}
                </button>
              )}
            </div>
          </div>
          <button onClick={() => router.back()} className="rounded-xl border border-white/10 bg-white/5 px-3 py-2 text-sm text-slate-300 transition-colors hover:text-white">
            Uscita
          </button>
        </div>

        <div className="mb-4 grid grid-cols-2 gap-3">
          <div className="rounded-2xl border border-white/10 bg-white/5 px-3 py-3">
            <div className="text-[11px] uppercase tracking-[0.2em] text-slate-500">Modalità</div>
            <div className={`mt-2 text-sm font-semibold ${currentMeta.accent}`}>{currentMeta.label}</div>
          </div>
          <div className="rounded-2xl border border-white/10 bg-white/5 px-3 py-3">
            <div className="text-[11px] uppercase tracking-[0.2em] text-slate-500">Obiettivo</div>
            <div className="mt-2 text-sm font-semibold text-white">
              {step.type === 'lesson'       ? 'Comprendere il modello'
               : step.type === 'quiz'        ? 'Verificare il concetto'
               : step.type === 'challenge'   ? 'Ragionare sullo scenario'
               : step.type === 'design'      ? 'Scegliere il tradeoff'
               : step.type === 'sorting'     ? 'Riordinare la sequenza'
               : step.type === 'fill-blank'  ? 'Completare la formula'
               : step.type === 'estimation'  ? 'Stimare il valore'
               :                              'Leggere il diagramma'}
            </div>
          </div>
        </div>

        <div className="flex items-center gap-3">
          <div className="flex-1 h-2 rounded-full bg-white/5 overflow-hidden">
            <div
              className="h-full rounded-full transition-all duration-500 shadow-[0_0_24px_rgba(45,212,191,0.45)]"
              style={{ width: `${((currentStep + 1) / totalSteps) * 100}%`, background: 'linear-gradient(90deg, #2dd4bf, #7dd3fc)' }}
            />
          </div>
          {maxScore > 0 && (
            <div
              key={scorePopKey}
              className={`flex-shrink-0 rounded-xl border px-3 py-1.5 text-xs font-semibold ${
                scorePopKey > 0 ? 'animate-score-pop' : ''
              } border-white/10 bg-white/5 text-slate-300`}
            >
              SCORE {score}/{maxScore}
            </div>
          )}
        </div>
      </div>

      <div className="flex-1 overflow-y-auto py-5">
        <div key={stepKey.current} className="animate-slide-in flex flex-col gap-4">
          {/* Hint panel */}
          {state.hintUsed && !state.checked && step.type !== 'lesson' && (
            <div className="rounded-[1.4rem] border border-[#f6a63b]/30 bg-[linear-gradient(135deg,rgba(246,166,59,0.08),rgba(15,29,50,0.3))] px-4 py-3">
              <div className="mb-1 text-[10px] font-semibold uppercase tracking-[0.18em] text-[#f6a63b]">💡 Suggerimento</div>
              <p className="text-sm leading-relaxed text-slate-300">
                {((step as { explanation?: string }).explanation ?? '').split('.')[0] + '.'}
              </p>
            </div>
          )}
          {step.type === 'lesson' && <LessonStepView step={step} />}
          {step.type === 'quiz' && (
            <QuizStepView step={step} selected={state.selected} checked={state.checked} onSelect={selectOption} />
          )}
          {step.type === 'challenge' && (
            <ChallengeStepView step={step} selected={state.selected} checked={state.checked} onSelect={selectOption} />
          )}
          {step.type === 'design' && (
            <DesignStepView step={step} selected={state.selected} checked={state.checked} onSelect={selectOption} />
          )}
          {step.type === 'sorting' && (
            <SortingStepView
              step={step}
              sortedOrder={state.sortedOrder ?? []}
              checked={state.checked}
              onReorder={setSortedOrder}
            />
          )}
          {step.type === 'fill-blank' && (
            <FillBlankStepView step={step} selected={state.selected} checked={state.checked} onSelect={selectOption} />
          )}
          {step.type === 'estimation' && (
            <EstimationStepView step={step} selected={state.selected} checked={state.checked} onSelect={selectOption} />
          )}
          {step.type === 'diagram-tap' && (
            <DiagramTapStepView step={step} selected={state.selected} checked={state.checked} onSelect={selectOption} />
          )}
        </div> {/* end animate-slide-in */}
      </div>

      <div className="flex-shrink-0 pb-2 text-center">
        <span className="text-[10px] uppercase tracking-[0.16em] text-slate-500">
          {isInteractive && !state.checked && state.selected === null && step.type !== 'sorting'
            ? 'Premi 1–4 per selezionare · Spazio per confermare'
            : step.type === 'sorting' && !state.checked
            ? 'Tocca gli elementi per ordinarli · Tocca un posizionato per rimuoverlo'
            : 'Premi Spazio o Invio per continuare'}
        </span>
      </div>

      <div className="flex-shrink-0 border-t border-white/10 pt-4">
        {needsCheck() ? (
          <button
            onClick={checkAnswer}
            className="w-full rounded-2xl border border-[#2dd4bf]/30 bg-[linear-gradient(135deg,#2dd4bf,#0f766e)] px-5 py-4 text-sm font-semibold uppercase tracking-[0.18em] text-slate-950 shadow-[0_18px_38px_rgba(45,212,191,0.22)]"
          >
            Controlla risposta
          </button>
        ) : canAdvance() && buttonLabel() ? (
          <button
            onClick={advance}
            disabled={isPending}
            className="w-full rounded-2xl border border-[#f6a63b]/40 bg-[linear-gradient(135deg,#f6a63b,#d97706)] px-5 py-4 text-sm font-semibold uppercase tracking-[0.18em] text-slate-950 shadow-[0_18px_38px_rgba(245,158,11,0.22)] disabled:opacity-60"
          >
            {isPending ? 'Salvataggio...' : buttonLabel()}
          </button>
        ) : (
          <div className="w-full rounded-2xl border border-white/10 bg-white/5 py-4 text-center text-sm text-slate-400">
            {placeholderLabel()}
          </div>
        )}
      </div>
    </div>
  )
}
