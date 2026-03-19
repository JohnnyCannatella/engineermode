import { redirect, notFound } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import MissionPlayer from '@/components/mission/MissionPlayer'

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
      alreadyCompleted={alreadyCompleted}
      pathSlug={path?.slug ?? 'systems-foundations'}
      previousProgress={progress}
      isDaily={isDaily}
    />
  )
}
