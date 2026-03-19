'use client'

import { useMemo } from 'react'
import type { SortingStep } from '@/types'
import StepReferences from './StepReferences'

interface Props {
  step: SortingStep
  sortedOrder: number[]
  checked: boolean
  onReorder: (order: number[]) => void
}

export default function SortingStepView({ step, sortedOrder, checked, onReorder }: Props) {
  // Stable shuffle deterministic on step title
  const shuffledIndices = useMemo(() => {
    const indices = step.items.map((_, i) => i)
    let seed = step.title.split('').reduce((acc, c) => acc + c.charCodeAt(0), 42)
    for (let i = indices.length - 1; i > 0; i--) {
      seed = (seed * 1103515245 + 12345) & 0x7fffffff
      const j = seed % (i + 1)
      ;[indices[i], indices[j]] = [indices[j], indices[i]]
    }
    return indices
  }, [step.title, step.items])

  const placedSet = new Set(sortedOrder)
  const allPlaced = sortedOrder.length === step.items.length

  const isCorrect = checked && sortedOrder.join(',') === step.items.map((_, i) => i).join(',')

  function tapAvailable(originalIndex: number) {
    if (checked || placedSet.has(originalIndex)) return
    onReorder([...sortedOrder, originalIndex])
  }

  function tapPlaced(positionIdx: number) {
    if (checked) return
    const next = [...sortedOrder]
    next.splice(positionIdx, 1)
    onReorder(next)
  }

  return (
    <div className="flex flex-col gap-5">
      {/* Header */}
      <div className="text-center">
        <div className="mb-2 text-[11px] font-semibold uppercase tracking-[0.22em] text-[#a78bfa]">Ordine Corretto</div>
        <div className="text-4xl mb-3">{step.emoji}</div>
        <h2 className="text-lg font-bold text-white leading-snug">{step.question}</h2>
      </div>

      {/* Sequence slots */}
      <div className="flex flex-col gap-2">
        <div className="text-[11px] font-semibold uppercase tracking-[0.18em] text-slate-500 mb-1">
          La tua sequenza {sortedOrder.length}/{step.items.length}
        </div>
        {step.items.map((_, slotIdx) => {
          const placedOriginalIdx = sortedOrder[slotIdx]
          const hasItem = placedOriginalIdx !== undefined
          const isCorrectPos = checked && hasItem && placedOriginalIdx === slotIdx

          return (
            <button
              key={slotIdx}
              onClick={() => hasItem && tapPlaced(slotIdx)}
              disabled={checked || !hasItem}
              className={`flex items-center gap-3 rounded-xl border px-4 py-3 text-left transition-all ${
                checked && hasItem
                  ? isCorrectPos
                    ? 'border-[#2dd4bf]/50 bg-[#2dd4bf]/10 text-[#81f4e1]'
                    : 'border-[#ef4444]/40 bg-[#ef4444]/10 text-[#fca5a5]'
                  : hasItem
                  ? 'border-[#a78bfa]/40 bg-[#a78bfa]/10 text-white cursor-pointer hover:border-[#a78bfa]/60'
                  : 'border-white/10 bg-white/5 text-slate-600 cursor-default'
              }`}
            >
              <span className="flex-shrink-0 font-mono text-xs text-slate-500">{slotIdx + 1}.</span>
              <span className="text-sm leading-relaxed">
                {hasItem ? step.items[placedOriginalIdx] : '— tap un elemento qui sotto —'}
              </span>
              {hasItem && !checked && (
                <span className="ml-auto text-xs text-slate-500">↩</span>
              )}
              {checked && hasItem && (
                <span className="ml-auto">{isCorrectPos ? '✓' : '✗'}</span>
              )}
            </button>
          )
        })}
      </div>

      {/* Available items pool */}
      {!allPlaced || !checked ? (
        <div className="flex flex-col gap-2">
          <div className="text-[11px] font-semibold uppercase tracking-[0.18em] text-slate-500 mb-1">
            Elementi disponibili
          </div>
          <div className="flex flex-wrap gap-2">
            {shuffledIndices.map((originalIdx) => {
              const isPlaced = placedSet.has(originalIdx)
              return (
                <button
                  key={originalIdx}
                  onClick={() => tapAvailable(originalIdx)}
                  disabled={isPlaced || checked}
                  className={`rounded-xl border px-4 py-2.5 text-sm text-left transition-all ${
                    isPlaced
                      ? 'border-white/5 bg-white/5 text-slate-700 cursor-default opacity-40'
                      : 'border-[#a78bfa]/30 bg-[#a78bfa]/8 text-white hover:border-[#a78bfa]/60 hover:bg-[#a78bfa]/15 cursor-pointer'
                  }`}
                >
                  {step.items[originalIdx]}
                </button>
              )
            })}
          </div>
        </div>
      ) : null}

      {/* Feedback */}
      {checked && (
        <div className={`rounded-[1.4rem] border p-4 ${isCorrect ? 'border-[#2dd4bf]/30 bg-[#2dd4bf]/10' : 'border-[#f6a63b]/30 bg-[#f6a63b]/10'}`}>
          <div className={`text-sm font-semibold mb-1.5 ${isCorrect ? 'text-[#81f4e1]' : 'text-[#f8c777]'}`}>
            {isCorrect ? '✓ Sequenza corretta!' : '✗ Ordine non corretto'}
          </div>
          <p className="text-sm text-white/80 leading-relaxed">{step.explanation}</p>
          {!isCorrect && (
            <div className="mt-3 flex flex-col gap-1.5">
              <div className="text-[10px] uppercase tracking-[0.18em] text-slate-500">Ordine corretto</div>
              {step.items.map((item, i) => (
                <div key={i} className="flex items-center gap-2 text-sm text-slate-300">
                  <span className="font-mono text-xs text-[#2dd4bf]">{i + 1}.</span>
                  <span>{item}</span>
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      <StepReferences formulas={step.formulas} references={step.references} />
    </div>
  )
}
