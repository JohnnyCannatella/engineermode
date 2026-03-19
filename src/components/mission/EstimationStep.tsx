'use client'

import type { EstimationStep } from '@/types'
import StepReferences from './StepReferences'

interface Props {
  step: EstimationStep
  selected: number | null
  checked: boolean
  onSelect: (idx: number) => void
}

export default function EstimationStepView({ step, selected, checked, onSelect }: Props) {
  const isCorrect = checked && selected === step.correct

  const getOptionStyle = (idx: number) => {
    if (!checked) {
      return selected === idx
        ? 'border-[#34d399]/50 bg-[#34d399]/10 text-white ring-1 ring-[#34d399]/40'
        : 'border-white/10 bg-white/5 text-white/80 hover:border-[#34d399]/30 hover:text-white'
    }
    if (idx === step.correct) return 'border-[#2dd4bf]/50 bg-[#2dd4bf]/10 text-[#81f4e1]'
    if (idx === selected) return 'border-[#ef4444]/40 bg-[#ef4444]/10 text-[#fca5a5]'
    return 'border-white/5 bg-white/5 text-slate-600 opacity-40'
  }

  // Visual scale indicator
  const labels = ['Minuscolo', 'Piccolo', 'Medio', 'Grande', 'Enorme']

  return (
    <div className="flex flex-col gap-5">
      {/* Header */}
      <div className="text-center">
        <div className="mb-2 text-[11px] font-semibold uppercase tracking-[0.22em] text-[#34d399]">Stima dell&apos;Ingegnere</div>
        <div className="text-4xl mb-3">{step.emoji}</div>
        <h2 className="text-xl font-bold text-white leading-tight">{step.question}</h2>
      </div>

      {/* Context box */}
      <div className="rounded-[1.5rem] border border-[#34d399]/20 bg-[linear-gradient(135deg,rgba(52,211,153,0.08),rgba(15,29,50,0.4))] p-4">
        <div className="text-[10px] font-semibold uppercase tracking-[0.18em] text-[#34d399] mb-2">Contesto</div>
        <p className="text-sm text-white/85 leading-relaxed">{step.context}</p>
      </div>

      {/* Visual scale bar */}
      <div className="px-1">
        <div className="flex justify-between mb-1">
          {labels.map((l) => (
            <span key={l} className="text-[9px] text-slate-600">{l}</span>
          ))}
        </div>
        <div className="h-1.5 rounded-full bg-gradient-to-r from-[#2dd4bf] via-[#34d399] via-[#f6a63b] to-[#ef4444] opacity-40" />
      </div>

      {/* Options */}
      <div className="flex flex-col gap-2.5">
        {step.options.map((option, idx) => (
          <button
            key={idx}
            onClick={() => !checked && onSelect(idx)}
            disabled={checked}
            className={`flex items-center gap-4 rounded-2xl border px-5 py-3.5 text-left transition-all ${getOptionStyle(idx)}`}
          >
            {/* Scale indicator dot */}
            <span
              className="flex-shrink-0 h-3 w-3 rounded-full"
              style={{
                background: `hsl(${(idx / (step.options.length - 1)) * 120 + 0}, 70%, 60%)`,
                opacity: checked && idx !== step.correct && idx !== selected ? 0.3 : 0.9,
              }}
            />
            <span className="font-mono text-sm font-semibold flex-1">{option}</span>
            {checked && idx === step.correct && <span className="text-[#81f4e1] text-sm">✓ corretto</span>}
            {checked && idx === selected && idx !== step.correct && <span className="text-[#fca5a5] text-sm">✗ selezionato</span>}
          </button>
        ))}
      </div>

      {/* Feedback */}
      {checked && (
        <div className={`rounded-[1.4rem] border p-4 ${isCorrect ? 'border-[#2dd4bf]/30 bg-[#2dd4bf]/10' : 'border-[#f6a63b]/30 bg-[#f6a63b]/10'}`}>
          <div className={`text-sm font-semibold mb-1.5 ${isCorrect ? 'text-[#81f4e1]' : 'text-[#f8c777]'}`}>
            {isCorrect ? '✓ Stima ingegneristica corretta!' : `✗ La stima corretta era: ${step.options[step.correct]}`}
          </div>
          <p className="text-sm text-white/80 leading-relaxed">{step.explanation}</p>
        </div>
      )}

      <StepReferences formulas={step.formulas} references={step.references} />
    </div>
  )
}
