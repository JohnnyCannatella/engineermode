'use client'

import type { QuizStep } from '@/types'
import TechnicalVisual from './TechnicalVisual'
import StepReferences from './StepReferences'

interface Props {
  step: QuizStep
  selected: number | null
  checked: boolean
  onSelect: (idx: number) => void
}

export default function QuizStepView({ step, selected, checked, onSelect }: Props) {
  const getOptionStyle = (idx: number) => {
    if (!checked) {
      return selected === idx
        ? 'border-primary bg-primary/10 text-white'
        : 'border-rim/50 bg-surface text-white/80 hover:border-rim hover:text-white'
    }
    if (idx === step.correct) return 'border-success bg-success/10 text-white'
    if (idx === selected) return 'border-danger bg-danger/10 text-white'
    return 'border-rim/30 bg-surface text-muted opacity-50'
  }

  const getOptionIcon = (idx: number) => {
    if (!checked) return selected === idx ? '●' : '○'
    if (idx === step.correct) return '✓'
    if (idx === selected) return '✗'
    return '○'
  }

  const getOptionIconColor = (idx: number) => {
    if (!checked) return selected === idx ? 'text-primary' : 'text-muted'
    if (idx === step.correct) return 'text-success'
    if (idx === selected) return 'text-danger'
    return 'text-muted'
  }

  const isCorrect = checked && selected === step.correct

  return (
    <div className="flex flex-col gap-5">
      <div className="text-center">
        <div className="mb-2 text-[11px] font-semibold uppercase tracking-[0.22em] text-[#7dd3fc]">Checkpoint</div>
        <div className="text-3xl mb-4">🤔</div>
        <h2 className="text-lg font-bold text-white leading-snug">{step.question}</h2>
      </div>

      <div className="flex flex-col gap-2.5">
        {step.options.map((option, idx) => (
          <button
            key={idx}
            onClick={() => !checked && onSelect(idx)}
            disabled={checked}
            className={`flex items-start gap-3 p-4 rounded-xl border text-left transition-all ${getOptionStyle(idx)}`}
          >
            <span className={`text-sm font-bold flex-shrink-0 mt-0.5 ${getOptionIconColor(idx)}`}>
              {getOptionIcon(idx)}
            </span>
            <span className="text-sm leading-relaxed">{option}</span>
          </button>
        ))}
      </div>

      {step.visuals?.length ? (
        <div className="grid gap-3">
          {step.visuals.map((visual, index) => (
            <TechnicalVisual key={`${visual.kind}-${index}`} visual={visual} />
          ))}
        </div>
      ) : null}

      {checked && (
        <div
          className={`rounded-[1.4rem] border p-4 ${
            isCorrect
              ? 'border-success/30 bg-success/10'
              : 'border-warning/30 bg-warning/10'
          }`}
        >
          <div className={`text-sm font-semibold mb-1.5 ${isCorrect ? 'text-success' : 'text-warning'}`}>
            {isCorrect ? '✓ Risposta corretta' : '✗ Rivedi il concetto'}
          </div>
          <p className="text-sm text-white/80 leading-relaxed">{step.explanation}</p>
        </div>
      )}

      <StepReferences formulas={step.formulas} references={step.references} />
    </div>
  )
}
