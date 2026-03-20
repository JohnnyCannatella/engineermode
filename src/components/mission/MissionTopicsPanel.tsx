'use client'

import Link from 'next/link'
import type { MissionTopicLink } from '@/types'

interface Props {
  topics: MissionTopicLink[]
  missionTitle: string
}

const DIFFICULTY_LABELS = {
  core: 'Core',
  deep: 'Deep Dive',
  architect: 'Architect',
} as const

export default function MissionTopicsPanel({ topics, missionTitle }: Props) {
  if (topics.length === 0) return null

  const primaryTopics = topics.filter((topic) => topic.is_primary)
  const secondaryTopics = topics.filter((topic) => !topic.is_primary)
  const prerequisiteTopics = Array.from(
    new Map(
      topics
        .flatMap((topic) => topic.prerequisites ?? [])
        .map((topic) => [topic.slug, topic])
    ).values()
  )

  return (
    <section className="rounded-[1.7rem] border border-[#7dd3fc]/20 bg-[linear-gradient(180deg,rgba(125,211,252,0.10),rgba(8,17,31,0.82))] p-4">
      <div className="flex items-start justify-between gap-3">
        <div>
          <div className="text-[11px] font-semibold uppercase tracking-[0.18em] text-[#7dd3fc]">Approfondisci Ora</div>
          <h3 className="mt-2 text-lg font-semibold text-white">Teoria collegata a {missionTitle}</h3>
          <p className="mt-2 text-sm leading-7 text-slate-300">
            Quando una missione ti sembra corta o ti manca base, entra qui: trovi teoria estesa, formule e riferimenti ordinati.
          </p>
        </div>
        <div className="rounded-full border border-white/10 bg-white/5 px-3 py-1 text-[11px] font-semibold uppercase tracking-[0.16em] text-slate-300">
          {topics.length} topic
        </div>
      </div>

      <div className="mt-4 grid gap-3">
        {prerequisiteTopics.length > 0 && (
          <div className="rounded-[1.35rem] border border-[#f6a63b]/20 bg-[#f6a63b]/8 p-4">
            <div className="text-[11px] font-semibold uppercase tracking-[0.18em] text-[#f8c777]">Studia Prima</div>
            <div className="mt-3 flex flex-wrap gap-2">
              {prerequisiteTopics.map((topic) => (
                <Link
                  key={topic.slug}
                  href={`/topic/${topic.slug}`}
                  className="rounded-full border border-[#f6a63b]/25 bg-[#f6a63b]/10 px-3 py-1.5 text-xs font-medium text-[#f8c777] transition-colors hover:border-[#f6a63b]/40"
                >
                  {topic.title}
                </Link>
              ))}
            </div>
          </div>
        )}

        {primaryTopics.map((topicLink) => (
          <Link
            key={topicLink.topic.slug}
            href={`/topic/${topicLink.topic.slug}`}
            className="rounded-[1.35rem] border border-white/10 bg-white/5 p-4 transition-all hover:-translate-y-0.5 hover:border-white/20"
          >
            <div className="flex items-center justify-between gap-3">
              <div className="text-base font-semibold text-white">{topicLink.topic.title}</div>
              <span className="rounded-full border border-[#f6a63b]/25 bg-[#f6a63b]/10 px-2.5 py-1 text-[10px] font-semibold uppercase tracking-[0.16em] text-[#f8c777]">
                {DIFFICULTY_LABELS[topicLink.topic.difficulty_level]}
              </span>
            </div>
            <div className="mt-2 text-[11px] font-semibold uppercase tracking-[0.18em] text-[#7dd3fc]">Topic Principale</div>
            <p className="mt-2 text-sm leading-7 text-slate-300">{topicLink.topic.summary}</p>
            <div className="mt-3 flex flex-wrap gap-2">
              <span className="hud-chip">⏱ {topicLink.topic.estimated_minutes} min</span>
              <span className="hud-chip">🧠 {topicLink.topic.key_takeaways.length} takeaways</span>
            </div>
          </Link>
        ))}

        {secondaryTopics.length > 0 && (
          <div className="rounded-[1.35rem] border border-white/10 bg-white/5 p-4">
            <div className="text-[11px] font-semibold uppercase tracking-[0.18em] text-slate-400">Poi Approfondisci</div>
            <div className="mt-3 grid gap-2">
              {secondaryTopics.map((topicLink) => (
                <Link
                  key={topicLink.topic.slug}
                  href={`/topic/${topicLink.topic.slug}`}
                  className="rounded-xl border border-white/10 bg-[#08111f]/70 px-3 py-3 transition-colors hover:border-white/20"
                >
                  <div className="flex items-center justify-between gap-3">
                    <div>
                      <div className="text-sm font-medium text-white">{topicLink.topic.title}</div>
                      <div className="mt-1 text-xs text-slate-400">{topicLink.topic.summary}</div>
                    </div>
                    <span className="rounded-full border border-white/10 bg-white/5 px-2 py-1 text-[10px] font-semibold uppercase tracking-[0.16em] text-slate-300">
                      {DIFFICULTY_LABELS[topicLink.topic.difficulty_level]}
                    </span>
                  </div>
                </Link>
              ))}
            </div>
          </div>
        )}
      </div>
    </section>
  )
}
