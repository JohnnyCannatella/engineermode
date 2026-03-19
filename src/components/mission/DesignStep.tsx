'use client'

import type { DesignReviewStep } from '@/types'
import TechnicalVisual from './TechnicalVisual'
import StepReferences from './StepReferences'

interface Props {
  step: DesignReviewStep
  selected: number | null
  checked: boolean
  onSelect: (idx: number) => void
}

export default function DesignStepView({ step, selected, checked, onSelect }: Props) {
  const getOptionStyle = (idx: number) => {
    if (!checked) {
      return selected === idx
        ? 'border-[#f6a63b]/40 bg-[#f6a63b]/10 text-white'
        : 'border-white/10 bg-white/5 text-white/80 hover:border-white/20 hover:text-white'
    }
    if (idx === step.correct) return 'border-[#2dd4bf]/40 bg-[#2dd4bf]/10 text-white'
    if (idx === selected) return 'border-[#ef4444]/40 bg-[#ef4444]/10 text-white'
    return 'border-white/10 bg-white/5 text-slate-500 opacity-50'
  }

  const isCorrect = checked && selected === step.correct

  return (
    <div className="flex flex-col gap-5">
      <div className="text-center">
        <div className="mb-2 text-[11px] font-semibold uppercase tracking-[0.22em] text-[#f8c777]">Design Review</div>
        <div className="mb-3 text-3xl">🛠️</div>
        <h2 className="text-xl font-semibold leading-tight text-white">{step.title}</h2>
      </div>

      <div className="rounded-[1.6rem] border border-[#7dd3fc]/20 bg-[linear-gradient(180deg,rgba(125,211,252,0.12),rgba(15,29,50,0.35))] p-4">
        <div className="text-xs font-semibold uppercase tracking-[0.18em] text-[#7dd3fc]">Brief Tecnico</div>
        <p className="mt-3 text-sm leading-7 text-white/85">{step.brief}</p>
      </div>

      <div className="rounded-[1.6rem] border border-white/10 bg-white/5 p-4">
        <div className="text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">Vincoli di Progetto</div>
        <div className="mt-3 grid gap-2">
          {step.constraints.map((constraint, index) => (
            <div key={index} className="rounded-xl border border-white/10 bg-[#08111f]/60 px-3 py-2 text-sm text-slate-300">
              {constraint}
            </div>
          ))}
        </div>
      </div>

      {step.visuals?.length ? (
        <div className="grid gap-3">
          {step.visuals.map((visual, index) => (
            <TechnicalVisual key={`${visual.kind}-${index}`} visual={visual} />
          ))}
        </div>
      ) : null}

      <p className="text-base font-semibold text-white text-center leading-7">{step.question}</p>

      <div className="flex flex-col gap-2.5">
        {step.options.map((option, idx) => (
          <button
            key={idx}
            onClick={() => !checked && onSelect(idx)}
            disabled={checked}
            className={`flex items-start gap-3 rounded-2xl border p-4 text-left transition-all ${getOptionStyle(idx)}`}
          >
            <span className="mt-0.5 flex-shrink-0 font-mono text-xs text-slate-400">
              {String.fromCharCode(65 + idx)}
            </span>
            <span className="text-sm leading-relaxed">{option}</span>
          </button>
        ))}
      </div>

      {checked && (
        <div className={`rounded-[1.6rem] border p-4 ${
          isCorrect ? 'border-[#2dd4bf]/30 bg-[#2dd4bf]/10' : 'border-[#f6a63b]/30 bg-[#f6a63b]/10'
        }`}>
          <div className={`text-sm font-semibold ${isCorrect ? 'text-[#81f4e1]' : 'text-[#f8c777]'}`}>
            {isCorrect ? '✓ Design reasoning solido' : '✗ Rivedi i tradeoff'}
          </div>
          <p className="mt-2 text-sm leading-7 text-white/85">{step.explanation}</p>
          <div className="mt-4 text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">Tradeoff da Tenere a Mente</div>
          <div className="mt-3 grid gap-2">
            {step.tradeoffs.map((tradeoff, index) => (
              <div key={index} className="rounded-xl border border-white/10 bg-[#08111f]/60 px-3 py-2 text-sm text-slate-300">
                {tradeoff}
              </div>
            ))}
          </div>
        </div>
      )}

      <StepReferences formulas={step.formulas} references={step.references} />
    </div>
  )
}
