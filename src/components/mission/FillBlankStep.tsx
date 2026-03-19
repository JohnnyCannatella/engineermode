'use client'

import type { FillBlankStep } from '@/types'
import StepReferences from './StepReferences'

interface Props {
  step: FillBlankStep
  selected: number | null
  checked: boolean
  onSelect: (idx: number) => void
}

export default function FillBlankStepView({ step, selected, checked, onSelect }: Props) {
  const parts = step.sentence.split('___')
  const before = parts[0] ?? ''
  const after = parts[1] ?? ''

  const selectedLabel = selected !== null ? step.options[selected] : null
  const isCorrect = checked && selected === step.correct

  const getOptionStyle = (idx: number) => {
    if (!checked) {
      return selected === idx
        ? 'border-[#f472b6]/60 bg-[#f472b6]/15 text-white scale-105'
        : 'border-white/10 bg-white/5 text-white/80 hover:border-[#f472b6]/40 hover:bg-[#f472b6]/10 hover:text-white'
    }
    if (idx === step.correct) return 'border-[#2dd4bf]/50 bg-[#2dd4bf]/10 text-[#81f4e1]'
    if (idx === selected) return 'border-[#ef4444]/40 bg-[#ef4444]/10 text-[#fca5a5]'
    return 'border-white/5 bg-white/5 text-slate-600 opacity-50'
  }

  return (
    <div className="flex flex-col gap-6">
      {/* Header */}
      <div className="text-center">
        <div className="mb-2 text-[11px] font-semibold uppercase tracking-[0.22em] text-[#f472b6]">Completa la Formula</div>
        <div className="text-4xl mb-3">{step.emoji}</div>
      </div>

      {/* Context */}
      {step.context && (
        <div className="rounded-[1.4rem] border border-white/10 bg-white/5 px-4 py-3">
          <p className="text-sm text-slate-300 leading-relaxed">{step.context}</p>
        </div>
      )}

      {/* Sentence with blank */}
      <div className="rounded-[1.6rem] border border-[#f472b6]/20 bg-[linear-gradient(135deg,rgba(244,114,182,0.08),rgba(15,29,50,0.4))] p-5">
        <div className="flex flex-wrap items-center justify-center gap-2 text-xl font-mono font-bold text-white leading-loose text-center">
          {before && <span className="text-white">{before.trim()}</span>}
          <span
            className={`inline-flex min-w-[72px] items-center justify-center rounded-xl border-2 px-3 py-1 text-lg transition-all ${
              checked
                ? isCorrect
                  ? 'border-[#2dd4bf] bg-[#2dd4bf]/15 text-[#81f4e1]'
                  : 'border-[#ef4444] bg-[#ef4444]/15 text-[#fca5a5]'
                : selectedLabel
                ? 'border-[#f472b6] bg-[#f472b6]/15 text-[#f9a8d4]'
                : 'border-dashed border-slate-600 text-slate-600'
            }`}
          >
            {selectedLabel ?? '  ?  '}
          </span>
          {after && <span className="text-white">{after.trim()}</span>}
        </div>
        {!selectedLabel && !checked && (
          <p className="mt-3 text-center text-xs text-slate-500">Scegli l&apos;opzione corretta qui sotto</p>
        )}
      </div>

      {/* Options grid */}
      <div className="grid grid-cols-2 gap-2.5">
        {step.options.map((option, idx) => (
          <button
            key={idx}
            onClick={() => !checked && onSelect(idx)}
            disabled={checked}
            className={`rounded-2xl border p-4 text-center font-mono text-lg font-bold transition-all ${getOptionStyle(idx)}`}
          >
            {option}
            {checked && idx === step.correct && <span className="ml-2 text-sm">✓</span>}
            {checked && idx === selected && idx !== step.correct && <span className="ml-2 text-sm">✗</span>}
          </button>
        ))}
      </div>

      {/* Feedback */}
      {checked && (
        <div className={`rounded-[1.4rem] border p-4 ${isCorrect ? 'border-[#2dd4bf]/30 bg-[#2dd4bf]/10' : 'border-[#f6a63b]/30 bg-[#f6a63b]/10'}`}>
          <div className={`text-sm font-semibold mb-1.5 ${isCorrect ? 'text-[#81f4e1]' : 'text-[#f8c777]'}`}>
            {isCorrect ? '✓ Corretto!' : `✗ La risposta era: ${step.options[step.correct]}`}
          </div>
          <p className="text-sm text-white/80 leading-relaxed">{step.explanation}</p>
        </div>
      )}

      <StepReferences formulas={step.formulas} references={step.references} />
    </div>
  )
}
