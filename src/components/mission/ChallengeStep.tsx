'use client'

import type { ChallengeStep } from '@/types'
import TechnicalVisual from './TechnicalVisual'
import StepReferences from './StepReferences'

interface Props {
  step: ChallengeStep
  selected: number | null
  checked: boolean
  onSelect: (idx: number) => void
}

export default function ChallengeStepView({ step, selected, checked, onSelect }: Props) {
  const getOptionStyle = (idx: number) => {
    if (!checked) {
      return selected === idx
        ? 'border-secondary bg-secondary/10 text-white'
        : 'border-rim/50 bg-surface text-white/80 hover:border-rim hover:text-white'
    }
    if (idx === step.correct) return 'border-success bg-success/10 text-white'
    if (idx === selected) return 'border-danger bg-danger/10 text-white'
    return 'border-rim/30 bg-surface text-muted opacity-50'
  }

  const isCorrect = checked && selected === step.correct

  return (
    <div className="flex flex-col gap-5">
      <div className="text-center">
        <div className="mb-2 text-[11px] font-semibold uppercase tracking-[0.22em] text-[#f8c777]">Scenario</div>
        <div className="text-3xl mb-3">🧠</div>
        <h2 className="text-lg font-bold text-white leading-snug">{step.title}</h2>
      </div>

      <div className="rounded-[1.5rem] border border-secondary/30 bg-secondary/8 p-4">
        <div className="mb-2 text-xs font-semibold uppercase tracking-[0.18em] text-secondary">
          Contesto Operativo
        </div>
        <p className="text-sm text-white/85 leading-relaxed">{step.scenario}</p>
      </div>

      <p className="text-base font-semibold text-white text-center">{step.question}</p>

      {step.visuals?.length ? (
        <div className="grid gap-3">
          {step.visuals.map((visual, index) => (
            <TechnicalVisual key={`${visual.kind}-${index}`} visual={visual} />
          ))}
        </div>
      ) : null}

      <div className="flex flex-col gap-2.5">
        {step.options.map((option, idx) => (
          <button
            key={idx}
            onClick={() => !checked && onSelect(idx)}
            disabled={checked}
            className={`flex items-start gap-3 p-4 rounded-xl border text-left transition-all ${getOptionStyle(idx)}`}
          >
            <span className="text-xs font-bold flex-shrink-0 mt-0.5 text-muted">
              {String.fromCharCode(65 + idx)}
            </span>
            <span className="text-sm leading-relaxed">{option}</span>
          </button>
        ))}
      </div>

      {checked && (
        <div
          className={`rounded-[1.4rem] border p-4 ${
            isCorrect ? 'bg-success/10 border-success/30' : 'bg-warning/10 border-warning/30'
          }`}
        >
          <div className={`text-sm font-semibold mb-1.5 ${isCorrect ? 'text-success' : 'text-warning'}`}>
            {isCorrect ? '✓ Buon ragionamento ingegneristico' : '✗ Ecco il tradeoff corretto'}
          </div>
          <p className="text-sm text-white/80 leading-relaxed">{step.explanation}</p>
        </div>
      )}

      <StepReferences formulas={step.formulas} references={step.references} />
    </div>
  )
}
