import type { LessonStep } from '@/types'
import TechnicalVisual from './TechnicalVisual'
import StepReferences from './StepReferences'

interface Props {
  step: LessonStep
}

export default function LessonStepView({ step }: Props) {
  // Convert simple markdown-like syntax to styled text
  const formatContent = (text: string) => {
    return text.split('\n\n').map((para, i) => (
      <p key={i} className="text-white/85 text-base leading-relaxed mb-0">
        {para.split(/\*\*(.*?)\*\*/g).map((part, j) =>
          j % 2 === 1 ? (
            <strong key={j} className="text-white font-semibold">
              {part}
            </strong>
          ) : (
            part
          )
        )}
      </p>
    ))
  }

  return (
    <div className="flex flex-col gap-6">
      <div className="text-center">
        <div className="mb-2 text-[11px] font-semibold uppercase tracking-[0.22em] text-[#7dd3fc]">Concetto Chiave</div>
        <div className="text-5xl mb-4">{step.emoji}</div>
        <h2 className="text-xl font-bold text-white leading-tight">{step.title}</h2>
      </div>

      <div className="rounded-[1.6rem] border border-white/10 bg-[linear-gradient(180deg,rgba(255,255,255,0.06),rgba(255,255,255,0.02))] p-5 flex flex-col gap-4">
        {formatContent(step.content)}
      </div>

      {step.key_points?.length > 0 && (
        <div className="flex flex-col gap-2">
          <div className="text-xs font-semibold text-slate-500 uppercase tracking-[0.18em]">
            Da Portare Via
          </div>
          {step.key_points.map((point, i) => (
            <div
              key={i}
              className="flex items-start gap-3 rounded-xl border border-[#7dd3fc]/20 bg-[#7dd3fc]/10 p-3"
            >
              <span className="mt-0.5 flex-shrink-0 text-[#7dd3fc]">◆</span>
              <span className="text-sm text-white/90 leading-relaxed">{point}</span>
            </div>
          ))}
        </div>
      )}

      {step.visuals?.length ? (
        <div className="grid gap-3">
          {step.visuals.map((visual, index) => (
            <TechnicalVisual key={`${visual.kind}-${index}`} visual={visual} />
          ))}
        </div>
      ) : null}

      <StepReferences formulas={step.formulas} references={step.references} />
    </div>
  )
}
