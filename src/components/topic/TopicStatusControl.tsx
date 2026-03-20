'use client'

import { useState, useTransition } from 'react'
import { updateTopicStatus } from '@/app/actions'
import type { UserTopicStatus } from '@/types'

interface Props {
  topicSlug: string
  initialStatus: UserTopicStatus
}

const STATUS_LABELS: Record<UserTopicStatus, string> = {
  not_started: 'Non Studiato',
  studying: 'In Studio',
  understood: 'Compreso',
}

export default function TopicStatusControl({ topicSlug, initialStatus }: Props) {
  const [status, setStatus] = useState<UserTopicStatus>(initialStatus)
  const [isPending, startTransition] = useTransition()

  function handleChange(nextStatus: UserTopicStatus) {
    if (nextStatus === status || isPending) return
    setStatus(nextStatus)
    startTransition(async () => {
      const result = await updateTopicStatus(topicSlug, nextStatus)
      if (result?.error) {
        setStatus(initialStatus)
      }
    })
  }

  return (
    <div className="panel rounded-[1.8rem] p-5 sm:p-6">
      <div className="eyebrow text-[10px] text-primary-light">Stato Studio</div>
      <div className="mt-3 text-lg font-semibold text-white">{STATUS_LABELS[status]}</div>
      <div className="mt-2 text-sm leading-7 text-slate-300">
        Usa questo stato per tracciare se il topic è ancora da affrontare, lo stai studiando o lo consideri compreso.
      </div>
      <div className="mt-4 flex flex-wrap gap-2">
        {(['not_started', 'studying', 'understood'] as const).map((item) => (
          <button
            key={item}
            type="button"
            onClick={() => handleChange(item)}
            disabled={isPending}
            className={`rounded-full border px-3 py-2 text-xs font-semibold uppercase tracking-[0.16em] transition-colors ${
              status === item
                ? 'border-[#2dd4bf]/30 bg-[#2dd4bf]/10 text-[#81f4e1]'
                : 'border-white/10 bg-white/5 text-slate-300 hover:border-white/20 hover:text-white'
            }`}
          >
            {STATUS_LABELS[item]}
          </button>
        ))}
      </div>
    </div>
  )
}
