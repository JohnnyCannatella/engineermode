import Link from 'next/link'
import { notFound, redirect } from 'next/navigation'
import TechnicalVisual from '@/components/mission/TechnicalVisual'
import StepReferences from '@/components/mission/StepReferences'
import BottomNav from '@/components/ui/BottomNav'
import TopicStatusControl from '@/components/topic/TopicStatusControl'
import { createClient } from '@/lib/supabase/server'
import type { Mission, Topic, UserTopicStatus } from '@/types'

const DIFFICULTY_LABELS = {
  core: 'Core',
  deep: 'Deep Dive',
  architect: 'Architect',
} as const

function formatParagraphs(text: string) {
  return text.split('\n\n').map((paragraph, index) => (
    <p key={index} className="text-sm leading-7 text-slate-300 sm:text-base">
      {paragraph}
    </p>
  ))
}

export default async function TopicPage(props: PageProps<'/topic/[slug]'>) {
  const { slug } = await props.params
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()
  if (!user) redirect('/auth')

  const { data: topic } = await supabase
    .from('topics')
    .select('*')
    .eq('slug', slug)
    .maybeSingle()

  if (!topic) notFound()

  const [{ data: prerequisiteRows }, { data: dependentRows }] = await Promise.all([
    supabase
      .from('topic_prerequisites')
      .select('prerequisite_topic_slug, sort_order')
      .eq('topic_slug', slug)
      .order('sort_order'),
    supabase
      .from('topic_prerequisites')
      .select('topic_slug, sort_order')
      .eq('prerequisite_topic_slug', slug)
      .order('sort_order'),
  ])

  const prerequisiteSlugs = (prerequisiteRows || []).map((row) => row.prerequisite_topic_slug)
  const dependentSlugs = (dependentRows || []).map((row) => row.topic_slug)
  const relatedTopicSlugs = Array.from(new Set([...prerequisiteSlugs, ...dependentSlugs]))
  const { data: relatedTopics } = relatedTopicSlugs.length > 0
    ? await supabase.from('topics').select('*').in('slug', relatedTopicSlugs)
    : { data: [] as Topic[] }

  const relatedTopicMap = new Map<string, Topic>(((relatedTopics || []) as Topic[]).map((item) => [item.slug, item]))
  const prerequisiteTopics = prerequisiteSlugs
    .map((item) => relatedTopicMap.get(item))
    .filter((item): item is Topic => !!item)
  const dependentTopics = dependentSlugs
    .map((item) => relatedTopicMap.get(item))
    .filter((item): item is Topic => !!item)

  const { data: missionTopics } = await supabase
    .from('mission_topics')
    .select('mission_id, sort_order')
    .eq('topic_slug', slug)
    .order('sort_order')

  const { data: userTopicProgress } = await supabase
    .from('user_topic_progress')
    .select('status')
    .eq('user_id', user.id)
    .eq('topic_slug', slug)
    .maybeSingle()

  let relatedMissions: Mission[] = []
  if ((missionTopics || []).length > 0) {
    const missionIds = (missionTopics || []).map((row) => row.mission_id)
    const { data: missions } = await supabase
      .from('missions')
      .select('*')
      .in('id', missionIds)

    const missionMap = new Map<string, Mission>(((missions || []) as Mission[]).map((mission) => [mission.id, mission]))
    relatedMissions = missionIds
      .map((missionId) => missionMap.get(missionId))
      .filter((mission): mission is Mission => !!mission)
  }

  const typedTopic = topic as Topic

  return (
    <div className="mx-auto min-h-screen max-w-5xl px-4 pb-32 pt-6 text-white sm:px-6 lg:px-8">
      <header className="panel-strong rounded-[2rem] p-5 sm:p-7">
        <div className="flex flex-col gap-6 lg:flex-row lg:items-start lg:justify-between">
          <div className="max-w-3xl">
            <div className="eyebrow text-[10px] text-primary-light">Knowledge Base</div>
            <h1 className="mt-3 text-3xl font-bold tracking-[-0.05em] text-white sm:text-5xl">
              {typedTopic.title}
            </h1>
            <p className="mt-4 max-w-2xl text-sm leading-7 text-slate-300 sm:text-base">
              {typedTopic.summary}
            </p>
            <div className="mt-5 flex flex-wrap gap-2">
              <span className="hud-chip">⏱ {typedTopic.estimated_minutes} min studio</span>
              <span className="hud-chip">🧠 {DIFFICULTY_LABELS[typedTopic.difficulty_level]}</span>
              <span className="hud-chip">◆ {typedTopic.key_takeaways.length} takeaways</span>
            </div>
          </div>
          <Link
            href="/dashboard"
            className="rounded-2xl border border-white/10 bg-white/5 px-4 py-3 text-sm font-medium text-slate-300 transition-colors hover:text-white"
          >
            Torna alla dashboard
          </Link>
        </div>
      </header>

      <section className="mt-6 grid gap-4 xl:grid-cols-[1.2fr_0.8fr]">
        <div className="panel rounded-[1.8rem] p-5 sm:p-6">
          <div className="eyebrow text-[10px] text-primary-light">Quadro teorico</div>
          <div className="mt-4 flex flex-col gap-4">
            {formatParagraphs(typedTopic.overview)}
          </div>
        </div>

        <div className="panel rounded-[1.8rem] p-5 sm:p-6">
          <div className="eyebrow text-[10px] text-primary-light">Da portare via</div>
          <div className="mt-4 grid gap-3">
            {typedTopic.key_takeaways.map((item, index) => (
              <div key={index} className="rounded-[1.25rem] border border-[#7dd3fc]/20 bg-[#7dd3fc]/10 p-4 text-sm leading-7 text-white/90">
                {item}
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="mt-6">
        <TopicStatusControl
          topicSlug={slug}
          initialStatus={(userTopicProgress?.status as UserTopicStatus | undefined) ?? 'not_started'}
        />
      </section>

      {(prerequisiteTopics.length > 0 || dependentTopics.length > 0) && (
        <section className="mt-6 grid gap-4 lg:grid-cols-2">
          {prerequisiteTopics.length > 0 && (
            <div className="panel rounded-[1.8rem] p-5 sm:p-6">
              <div className="eyebrow text-[10px] text-warning">Studia Prima</div>
              <div className="mt-4 grid gap-3">
                {prerequisiteTopics.map((item) => (
                  <Link
                    key={item.slug}
                    href={`/topic/${item.slug}`}
                    className="rounded-[1.35rem] border border-white/10 bg-white/5 p-4 transition-colors hover:border-white/20"
                  >
                    <div className="text-sm font-semibold text-white">{item.title}</div>
                    <div className="mt-2 text-sm leading-7 text-slate-300">{item.summary}</div>
                  </Link>
                ))}
              </div>
            </div>
          )}

          {dependentTopics.length > 0 && (
            <div className="panel rounded-[1.8rem] p-5 sm:p-6">
              <div className="eyebrow text-[10px] text-primary-light">Sblocca Dopo</div>
              <div className="mt-4 grid gap-3">
                {dependentTopics.map((item) => (
                  <Link
                    key={item.slug}
                    href={`/topic/${item.slug}`}
                    className="rounded-[1.35rem] border border-white/10 bg-white/5 p-4 transition-colors hover:border-white/20"
                  >
                    <div className="text-sm font-semibold text-white">{item.title}</div>
                    <div className="mt-2 text-sm leading-7 text-slate-300">{item.summary}</div>
                  </Link>
                ))}
              </div>
            </div>
          )}
        </section>
      )}

      {typedTopic.study_blocks?.length ? (
        <section className="mt-6 panel rounded-[1.8rem] p-5 sm:p-6">
          <div className="eyebrow text-[10px] text-primary-light">Deep Study</div>
          <div className="mt-5 grid gap-4 lg:grid-cols-2">
            {typedTopic.study_blocks.map((block, index) => (
              <article key={`${block.title}-${index}`} className="rounded-[1.4rem] border border-white/10 bg-white/5 p-4">
                <h2 className="text-lg font-semibold text-white">{block.title}</h2>
                <div className="mt-3 flex flex-col gap-3">
                  {formatParagraphs(block.content)}
                </div>
              </article>
            ))}
          </div>
        </section>
      ) : null}

      {typedTopic.visuals?.length ? (
        <section className="mt-6 grid gap-4 lg:grid-cols-2">
          {typedTopic.visuals.map((visual, index) => (
            <TechnicalVisual key={`${visual.kind}-${index}`} visual={visual} />
          ))}
        </section>
      ) : null}

      <section className="mt-6">
        <StepReferences formulas={typedTopic.formulas ?? undefined} references={typedTopic.references ?? undefined} />
      </section>

      {relatedMissions.length > 0 && (
        <section className="mt-6 panel rounded-[1.8rem] p-5 sm:p-6">
          <div className="eyebrow text-[10px] text-primary-light">Missioni collegate</div>
          <div className="mt-4 grid gap-3">
            {relatedMissions.map((mission) => (
              <Link
                key={mission.id}
                href={`/mission/${mission.id}`}
                className="rounded-[1.4rem] border border-white/10 bg-white/5 p-4 transition-all hover:-translate-y-0.5 hover:border-white/20"
              >
                <div className="flex items-start gap-4">
                  <div className="flex h-12 w-12 items-center justify-center rounded-[1rem] bg-primary/10 text-2xl text-primary-light">
                    {mission.icon}
                  </div>
                  <div className="flex-1">
                    <div className="text-base font-semibold text-white">{mission.title}</div>
                    <div className="mt-2 text-sm leading-7 text-slate-300">{mission.description}</div>
                    <div className="mt-3 flex flex-wrap gap-2">
                      <span className="hud-chip">⏱ {mission.estimated_minutes} min</span>
                      <span className="hud-chip">⚡ {mission.xp_reward} XP</span>
                    </div>
                  </div>
                </div>
              </Link>
            ))}
          </div>
        </section>
      )}

      <BottomNav />
    </div>
  )
}
