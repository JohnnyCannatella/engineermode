'use client'

import type { DiagramTapStep, StepVisual } from '@/types'
import TechnicalVisual from './TechnicalVisual'
import StepReferences from './StepReferences'

interface Props {
  step: DiagramTapStep
  selected: number | null
  checked: boolean
  onSelect: (idx: number) => void
}

export default function DiagramTapStepView({ step, selected, checked, onSelect }: Props) {
  const isCorrect = checked && selected === step.correct

  const getOptionStyle = (idx: number) => {
    if (!checked) {
      return selected === idx
        ? 'border-[#818cf8]/60 bg-[#818cf8]/15 text-white'
        : 'border-white/10 bg-white/5 text-white/80 hover:border-[#818cf8]/40 hover:bg-[#818cf8]/8 hover:text-white'
    }
    if (idx === step.correct) return 'border-[#2dd4bf]/50 bg-[#2dd4bf]/10 text-[#81f4e1]'
    if (idx === selected) return 'border-[#ef4444]/40 bg-[#ef4444]/10 text-[#fca5a5]'
    return 'border-white/5 bg-white/5 text-slate-600 opacity-40'
  }

  // Build a StepVisual from the step data to pass to TechnicalVisual
  const visual: StepVisual = {
    kind: step.diagram_kind,
    title: step.title,
    caption: step.diagram_caption,
  }

  return (
    <div className="flex flex-col gap-5">
      {/* Header */}
      <div className="text-center">
        <div className="mb-2 text-[11px] font-semibold uppercase tracking-[0.22em] text-[#818cf8]">Analisi Diagramma</div>
        <h2 className="text-lg font-bold text-white leading-snug">{step.question}</h2>
      </div>

      {/* Diagram — full width, prominent */}
      <TechnicalVisual visual={visual} />

      {/* Hint */}
      {!checked && (
        <div className="flex items-center gap-2 rounded-xl border border-[#818cf8]/20 bg-[#818cf8]/8 px-3 py-2.5">
          <span className="text-[#818cf8]">🔍</span>
          <span className="text-xs text-slate-400">Osserva il diagramma e identifica la risposta corretta</span>
        </div>
      )}

      {/* Options */}
      <div className="flex flex-col gap-2.5">
        {step.options.map((option, idx) => (
          <button
            key={idx}
            onClick={() => !checked && onSelect(idx)}
            disabled={checked}
            className={`flex items-center gap-3 rounded-2xl border px-4 py-3.5 text-left transition-all ${getOptionStyle(idx)}`}
          >
            <span className="flex-shrink-0 font-mono text-xs font-bold text-slate-500">
              {String.fromCharCode(65 + idx)}
            </span>
            <span className="text-sm leading-relaxed">{option}</span>
            {checked && idx === step.correct && <span className="ml-auto text-[#81f4e1]">✓</span>}
            {checked && idx === selected && idx !== step.correct && <span className="ml-auto text-[#fca5a5]">✗</span>}
          </button>
        ))}
      </div>

      {/* Feedback */}
      {checked && (
        <div className={`rounded-[1.4rem] border p-4 ${isCorrect ? 'border-[#2dd4bf]/30 bg-[#2dd4bf]/10' : 'border-[#f6a63b]/30 bg-[#f6a63b]/10'}`}>
          <div className={`text-sm font-semibold mb-1.5 ${isCorrect ? 'text-[#81f4e1]' : 'text-[#f8c777]'}`}>
            {isCorrect ? '✓ Lettura del diagramma corretta!' : '✗ Rivedi il diagramma'}
          </div>
          <p className="text-sm text-white/80 leading-relaxed">{step.explanation}</p>
        </div>
      )}

      <StepReferences formulas={step.formulas} references={step.references} />
    </div>
  )
}
