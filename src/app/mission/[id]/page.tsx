import { redirect, notFound } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import MissionPlayer from '@/components/mission/MissionPlayer'
import type { MissionReadiness, MissionTopicLink, Topic, UserTopicStatus } from '@/types'

export default async function MissionPage(props: PageProps<'/mission/[id]'>) {
  const { id } = await props.params
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()
  if (!user) redirect('/auth')

  const [{ data: mission }, { data: progress }] = await Promise.all([
    supabase.from('missions').select('*').eq('id', id).single(),
    supabase
      .from('user_mission_progress')
      .select('*')
      .eq('user_id', user.id)
      .eq('mission_id', id)
      .maybeSingle(),
  ])

  if (!mission) notFound()

  const { data: missionTopicRows } = await supabase
    .from('mission_topics')
    .select('topic_slug, sort_order, is_primary')
    .eq('mission_id', id)
    .order('sort_order')

  let topics: MissionTopicLink[] = []
  let readiness: MissionReadiness = 'ready'
  if ((missionTopicRows || []).length > 0) {
    const orderedSlugs = (missionTopicRows || []).map((row) => row.topic_slug)
    const [{ data: topicRows }, { data: prerequisiteRows }] = await Promise.all([
      supabase
        .from('topics')
        .select('*')
        .in('slug', orderedSlugs),
      supabase
        .from('topic_prerequisites')
        .select('topic_slug, prerequisite_topic_slug, sort_order')
        .in('topic_slug', orderedSlugs)
        .order('sort_order'),
    ])
    const progressTargetSlugs = Array.from(new Set([
      ...orderedSlugs,
      ...(prerequisiteRows || []).map((row) => row.prerequisite_topic_slug),
    ]))
    const { data: topicProgressRows } = progressTargetSlugs.length > 0
      ? await supabase
          .from('user_topic_progress')
          .select('topic_slug,status')
          .eq('user_id', user.id)
          .in('topic_slug', progressTargetSlugs)
      : { data: [] as { topic_slug: string; status: UserTopicStatus }[] }

    const prerequisiteSlugs = Array.from(new Set((prerequisiteRows || []).map((row) => row.prerequisite_topic_slug)))
    const prerequisiteTopics = prerequisiteSlugs.length > 0
      ? await supabase.from('topics').select('*').in('slug', prerequisiteSlugs)
      : { data: [] as Topic[] }

    const topicMap = new Map<string, Topic>((topicRows || []).map((topic) => [topic.slug, topic as Topic]))
    const prerequisiteTopicMap = new Map<string, Topic>(((prerequisiteTopics.data || []) as Topic[]).map((topic) => [topic.slug, topic]))
    const topicStatusMap = new Map<string, UserTopicStatus>((topicProgressRows || []).map((row) => [row.topic_slug, row.status as UserTopicStatus]))
    const prerequisitesByTopic = new Map<string, Topic[]>()

    for (const row of prerequisiteRows || []) {
      const list = prerequisitesByTopic.get(row.topic_slug) ?? []
      const prerequisiteTopic = prerequisiteTopicMap.get(row.prerequisite_topic_slug)
      if (prerequisiteTopic) list.push(prerequisiteTopic)
      prerequisitesByTopic.set(row.topic_slug, list)
    }

    topics = (missionTopicRows || [])
      .map((row): MissionTopicLink | null => {
        const topic = topicMap.get(row.topic_slug)
        if (!topic) return null
        return {
          topic,
          sort_order: row.sort_order,
          is_primary: row.is_primary,
          prerequisites: prerequisitesByTopic.get(row.topic_slug) ?? [],
          status: topicStatusMap.get(row.topic_slug) ?? 'not_started',
        }
      })
      .filter((topic): topic is MissionTopicLink => !!topic)

    const hasMissingPrerequisite = topics.some((topic) =>
      (topic.prerequisites ?? []).some((prerequisite) => topicStatusMap.get(prerequisite.slug) !== 'understood')
    )
    const hasStudyingTopic = topics.some((topic) => topic.status === 'studying')
    const hasUnderstoodPrimary = topics.some((topic) => topic.is_primary && topic.status === 'understood')

    readiness = hasMissingPrerequisite
      ? 'study-first'
      : hasUnderstoodPrimary
      ? 'ready'
      : hasStudyingTopic
      ? 'stretch'
      : 'study-first'
  }

  const { data: prerequisites } = await supabase
    .from('mission_prerequisites')
    .select('prerequisite_mission_id')
    .eq('mission_id', id)

  if ((prerequisites || []).length > 0) {
    const prerequisiteIds = (prerequisites ?? []).map((row) => row.prerequisite_mission_id)
    const { data: prerequisiteProgress } = await supabase
      .from('user_mission_progress')
      .select('mission_id,status')
      .eq('user_id', user.id)
      .in('mission_id', prerequisiteIds)
      .eq('status', 'completed')

    const completedPrerequisiteIds = new Set((prerequisiteProgress || []).map((row) => row.mission_id))
    const missingPrerequisite = prerequisiteIds.some((prerequisiteId) => !completedPrerequisiteIds.has(prerequisiteId))
    if (missingPrerequisite) {
      redirect('/dashboard')
    }
  }

  // Fetch path slug for post-completion navigation
  const { data: path } = await supabase
    .from('learning_paths')
    .select('slug')
    .eq('id', mission.path_id)
    .single()

  // Determine if this is today's daily mission
  const { data: allMissions } = await supabase
    .from('missions')
    .select('id')
    .order('created_at')

  const today = new Date().toISOString().split('T')[0]
  const dayHash = today.split('-').reduce((acc: number, n: string) => acc + parseInt(n), 0)
  const dailyMissionId = allMissions?.[dayHash % (allMissions?.length || 1)]?.id
  const isDaily = id === dailyMissionId

  const alreadyCompleted = progress?.status === 'completed'

  return (
    <MissionPlayer
      mission={mission}
      topics={topics}
      readiness={readiness}
      alreadyCompleted={alreadyCompleted}
      pathSlug={path?.slug ?? 'systems-foundations'}
      previousProgress={progress}
      isDaily={isDaily}
    />
  )
}
