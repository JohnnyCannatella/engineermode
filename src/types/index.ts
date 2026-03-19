export type Profile = {
  id: string
  username: string | null
  display_name: string | null
  avatar_color: string
  goal: string | null
  learning_goal?: string | null
  experience_level?: string | null
  recommended_path_slug?: string | null
  xp: number
  level: number
  streak: number
  streak_shields: number
  last_active_date: string | null
  onboarding_completed: boolean
  created_at: string
  updated_at: string
}

export type LearningPath = {
  id: string
  slug: string
  title: string
  description: string | null
  icon: string
  color: string
  area_slug?: string | null
  learning_stage?: 'foundation' | 'builder' | 'inventor' | 'architect' | null
  order_index: number
  mission_count: number
  is_published: boolean
  created_at: string
}

export type LearningArea = {
  slug: string
  title: string
  description: string | null
  icon: string
  color: string
  order_index: number
  created_at: string
}

export type StepFormula = {
  label: string
  expression: string
  note?: string
}

export type StepReference = {
  title: string
  url: string
  type: 'video' | 'article' | 'handbook' | 'interactive'
  source?: string
}

export type StepVisual = {
  kind:
    | 'feedback-loop'
    | 'trade-study'
    | 'verification-stack'
    | 'interface-contract'
    | 'free-body'
    | 'circuit-loop'
    | 'complexity-scale'
    | 'state-machine'
    | 'osi-stack'
    | 'memory-map'
    | 'signal-wave'
    | 'binary-tree'
    | 'pid-controller'
    | 'mosfet-symbol'
    | 'pipeline-stages'
  title: string
  caption: string
}

export type LessonStep = {
  type: 'lesson'
  title: string
  emoji: string
  content: string
  key_points: string[]
  formulas?: StepFormula[]
  references?: StepReference[]
  visuals?: StepVisual[]
}

export type QuizStep = {
  type: 'quiz'
  question: string
  options: string[]
  correct: number
  explanation: string
  formulas?: StepFormula[]
  references?: StepReference[]
  visuals?: StepVisual[]
}

export type ChallengeStep = {
  type: 'challenge'
  title: string
  scenario: string
  question: string
  options: string[]
  correct: number
  explanation: string
  formulas?: StepFormula[]
  references?: StepReference[]
  visuals?: StepVisual[]
}

export type DesignReviewStep = {
  type: 'design'
  title: string
  brief: string
  constraints: string[]
  question: string
  options: string[]
  correct: number
  explanation: string
  tradeoffs: string[]
  formulas?: StepFormula[]
  references?: StepReference[]
  visuals?: StepVisual[]
}

export type SortingStep = {
  type: 'sorting'
  title: string
  emoji: string
  question: string
  items: string[] // correct order; display them shuffled
  explanation: string
  formulas?: StepFormula[]
  references?: StepReference[]
  visuals?: StepVisual[]
}

export type FillBlankStep = {
  type: 'fill-blank'
  emoji: string
  sentence: string // use ___ as placeholder, e.g. "V = I × ___"
  context?: string // optional extra explanation before the blank
  options: string[]
  correct: number
  explanation: string
  formulas?: StepFormula[]
  references?: StepReference[]
  visuals?: StepVisual[]
}

export type EstimationStep = {
  type: 'estimation'
  emoji: string
  question: string
  context: string // extra context / hint
  options: string[] // order-of-magnitude ranges
  correct: number
  explanation: string
  formulas?: StepFormula[]
  references?: StepReference[]
  visuals?: StepVisual[]
}

export type DiagramTapStep = {
  type: 'diagram-tap'
  title: string
  diagram_kind: StepVisual['kind']
  diagram_caption: string
  question: string
  options: string[] // labels corresponding to diagram zones
  correct: number
  explanation: string
  formulas?: StepFormula[]
  references?: StepReference[]
}

export type MissionStep = LessonStep | QuizStep | ChallengeStep | DesignReviewStep | SortingStep | FillBlankStep | EstimationStep | DiagramTapStep

export type Mission = {
  id: string
  path_id: string
  title: string
  description: string | null
  icon: string
  xp_reward: number
  estimated_minutes: number
  order_index: number
  is_published: boolean
  difficulty_level?: 'intro' | 'core' | 'advanced' | null
  learning_objectives?: string[] | null
  review_after_days?: number | null
  steps: MissionStep[]
  created_at: string
}

export type MissionStatus = 'not_started' | 'in_progress' | 'completed'

export type UserMissionProgress = {
  id: string
  user_id: string
  mission_id: string
  status: MissionStatus
  xp_earned: number
  score: number
  max_score: number
  completed_at: string | null
  created_at: string
  updated_at: string
}

export type Achievement = {
  id: string
  slug: string
  title: string
  description: string | null
  icon: string
  xp_reward: number
  created_at: string
}

export type UserAchievement = {
  id: string
  user_id: string
  achievement_id: string
  earned_at: string
  achievements: Achievement
}

export type XpProgress = {
  level: number
  current: number
  needed: number
  totalXp: number
}

export type MissionWithProgress = Mission & {
  progress: UserMissionProgress | null
}

export type MissionPrerequisite = {
  mission_id: string
  prerequisite_mission_id: string
}

export type UserMissionMastery = {
  user_id: string
  mission_id: string
  mastery_level: 'learning' | 'practicing' | 'mastered'
  last_score_pct: number
  completion_count: number
  last_completed_at: string | null
  next_review_at: string | null
  created_at: string
  updated_at: string
}
