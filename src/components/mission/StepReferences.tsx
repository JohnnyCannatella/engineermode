import type { StepFormula, StepReference } from '@/types'

interface Props {
  formulas?: StepFormula[]
  references?: StepReference[]
}

const REFERENCE_LABELS = {
  video: 'Video',
  article: 'Articolo',
  handbook: 'Manuale',
  interactive: 'Interattivo',
} as const

export default function StepReferences({ formulas, references }: Props) {
  if ((!formulas || formulas.length === 0) && (!references || references.length === 0)) {
    return null
  }

  return (
    <div className="flex flex-col gap-4">
      {formulas && formulas.length > 0 && (
        <div className="rounded-[1.6rem] border border-white/10 bg-white/5 p-4">
          <div className="text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">Formule Utili</div>
          <div className="mt-3 grid gap-3">
            {formulas.map((formula, index) => (
              <div key={`${formula.label}-${index}`} className="rounded-xl border border-white/10 bg-[#08111f]/70 p-3">
                <div className="text-[11px] uppercase tracking-[0.18em] text-[#7dd3fc]">{formula.label}</div>
                <div className="mt-2 font-mono text-base text-white">{formula.expression}</div>
                {formula.note && <div className="mt-2 text-sm leading-6 text-slate-400">{formula.note}</div>}
              </div>
            ))}
          </div>
        </div>
      )}

      {references && references.length > 0 && (
        <div className="rounded-[1.6rem] border border-white/10 bg-white/5 p-4">
          <div className="text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">Approfondisci</div>
          <div className="mt-3 flex flex-col gap-2">
            {references.map((reference, index) => (
              <a
                key={`${reference.url}-${index}`}
                href={reference.url}
                target="_blank"
                rel="noreferrer"
                className="rounded-xl border border-white/10 bg-[#08111f]/70 px-3 py-3 transition-colors hover:border-white/20"
              >
                <div className="flex items-center justify-between gap-3">
                  <div>
                    <div className="text-sm font-medium text-white">{reference.title}</div>
                    <div className="mt-1 text-xs text-slate-400">{reference.source ?? reference.url}</div>
                  </div>
                  <span className="rounded-full border border-[#f6a63b]/30 bg-[#f6a63b]/10 px-2 py-1 text-[10px] font-semibold uppercase tracking-[0.16em] text-[#f8c777]">
                    {REFERENCE_LABELS[reference.type]}
                  </span>
                </div>
              </a>
            ))}
          </div>
        </div>
      )}
    </div>
  )
}
