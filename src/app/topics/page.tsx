import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import BottomNav from '@/components/ui/BottomNav'
import type { Topic, LearningArea, UserTopicStatus } from '@/types'

const DIFFICULTY_COLORS = {
  core:      { chip: 'border-[#7dd3fc]/25 bg-[#7dd3fc]/10 text-[#7dd3fc]', label: 'Core' },
  deep:      { chip: 'border-[#a78bfa]/25 bg-[#a78bfa]/10 text-[#c4b5fd]', label: 'Avanzato' },
  architect: { chip: 'border-[#f472b6]/25 bg-[#f472b6]/10 text-[#f9a8d4]', label: 'Architetto' },
} as const

const STATUS_META: Record<UserTopicStatus, { label: string; dot: string }> = {
  not_started: { label: 'Non iniziato', dot: 'bg-white/20' },
  studying:    { label: 'In studio',    dot: 'bg-[#f6a63b]' },
  understood:  { label: 'Compreso',     dot: 'bg-[#2dd4bf]' },
}

export default async function TopicsPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) redirect('/auth')

  const [{ data: areas }, { data: paths }, { data: topics }, { data: missionTopics }, { data: userProgress }] = await Promise.all([
    supabase.from('learning_areas').select('*').order('order_index'),
    supabase.from('learning_paths').select('id,slug,area_slug').eq('is_published', true),
    supabase.from('topics').select('*').order('title'),
    supabase.from('mission_topics').select('topic_slug,mission_id'),
    supabase.from('user_topic_progress').select('topic_slug,status').eq('user_id', user.id),
  ])

  // Map path → area
  const areaByPathId = new Map((paths || []).map((p) => [p.id, p.area_slug ?? 'systems-thinking']))

  // Group topics by area via mission_topics → missions → paths
  const { data: missions } = await supabase.from('missions').select('id,path_id').eq('is_published', true)
  const areaByMissionId = new Map((missions || []).map((m) => [m.id, areaByPathId.get(m.path_id) ?? 'systems-thinking']))

  const topicAreaMap = new Map<string, string>()
  for (const mt of missionTopics || []) {
    if (!topicAreaMap.has(mt.topic_slug)) {
      topicAreaMap.set(mt.topic_slug, areaByMissionId.get(mt.mission_id) ?? 'systems-thinking')
    }
  }

  const progressMap = new Map<string, UserTopicStatus>((userProgress || []).map((r) => [r.topic_slug, r.status as UserTopicStatus]))
  const typedTopics = (topics || []) as Topic[]
  const typedAreas = (areas || []) as LearningArea[]

  const topicsByArea = new Map<string, Topic[]>()
  for (const topic of typedTopics) {
    const areaSlug = topicAreaMap.get(topic.slug) ?? 'systems-thinking'
    const list = topicsByArea.get(areaSlug) ?? []
    list.push(topic)
    topicsByArea.set(areaSlug, list)
  }

  const understoodCount = (userProgress || []).filter((r) => r.status === 'understood').length
  const studyingCount = (userProgress || []).filter((r) => r.status === 'studying').length
  const learnPath = paths?.[0]?.slug ?? 'systems-foundations'

  return (
    <div className="min-h-screen max-w-lg mx-auto px-5 pb-28 pt-8 text-white">
      <header className="mb-6">
        <Link href="/dashboard" className="mb-5 block text-sm text-slate-400 transition-colors hover:text-white">← Dashboard</Link>
        <div className="panel-strong">
          <div className="eyebrow mb-2 text-[10px] text-primary-light">Knowledge Graph</div>
          <h1 className="text-3xl font-semibold text-white">Biblioteca Tecnica</h1>
          <p className="mt-2 text-sm leading-7 text-muted">
            I fondamenti teorici alla base di ogni missione. Studia un topic per andare in profondita prima di affrontare le missioni collegate.
          </p>
          <div className="mt-4 grid grid-cols-3 gap-3">
            <div className="rounded-2xl border border-white/10 bg-white/5 p-3 text-center">
              <div className="text-2xl font-semibold text-white">{typedTopics.length}</div>
              <div className="mt-1 text-[10px] uppercase tracking-[0.14em] text-slate-500">Totali</div>
            </div>
            <div className="rounded-2xl border border-[#f6a63b]/20 bg-[#f6a63b]/5 p-3 text-center">
              <div className="text-2xl font-semibold text-[#f8c777]">{studyingCount}</div>
              <div className="mt-1 text-[10px] uppercase tracking-[0.14em] text-slate-500">In studio</div>
            </div>
            <div className="rounded-2xl border border-[#2dd4bf]/20 bg-[#2dd4bf]/5 p-3 text-center">
              <div className="text-2xl font-semibold text-[#81f4e1]">{understoodCount}</div>
              <div className="mt-1 text-[10px] uppercase tracking-[0.14em] text-slate-500">Compresi</div>
            </div>
          </div>
        </div>
      </header>

      {typedAreas.map((area) => {
        const areaTopics = topicsByArea.get(area.slug) ?? []
        if (areaTopics.length === 0) return null
        const areaUnderstood = areaTopics.filter((t) => progressMap.get(t.slug) === 'understood').length
        return (
          <section key={area.slug} className="mb-6">
            <div className="mb-3 flex items-center justify-between">
              <div className="flex items-center gap-2">
                <span className="text-lg" style={{ color: area.color }}>{area.icon}</span>
                <h2 className="eyebrow text-[10px]" style={{ color: area.color }}>{area.title}</h2>
              </div>
              <span className="text-[10px] text-muted">{areaUnderstood}/{areaTopics.length} compresi</span>
            </div>
            <div className="flex flex-col gap-2">
              {areaTopics.map((topic) => {
                const status = progressMap.get(topic.slug) ?? 'not_started'
                const statusMeta = STATUS_META[status]
                const diffMeta = DIFFICULTY_COLORS[topic.difficulty_level] ?? DIFFICULTY_COLORS.core
                return (
                  <Link
                    key={topic.slug}
                    href={`/topic/${topic.slug}`}
                    className="panel flex items-center gap-3 rounded-[1.4rem] p-4 transition-all hover:-translate-y-0.5"
                  >
                    <div className="flex-shrink-0">
                      <div className={`h-2.5 w-2.5 rounded-full ${statusMeta.dot}`} />
                    </div>
                    <div className="min-w-0 flex-1">
                      <div className="truncate text-sm font-semibold text-white">{topic.title}</div>
                      <div className="mt-0.5 text-xs text-muted">{statusMeta.label} · {topic.estimated_minutes} min</div>
                    </div>
                    <span className={`flex-shrink-0 rounded-full border px-2 py-0.5 text-[10px] font-semibold uppercase tracking-[0.1em] ${diffMeta.chip}`}>
                      {diffMeta.label}
                    </span>
                  </Link>
                )
              })}
            </div>
          </section>
        )
      })}

      <BottomNav active="/topics" learnPath={learnPath} />
    </div>
  )
}
