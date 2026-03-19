export type LearningGoal = 'career' | 'curiosity' | 'study' | 'build'
export type ExperienceLevel = 'beginner' | 'student' | 'professional' | 'expert'

export type ProfilePreferences = {
  goal: LearningGoal | null
  experienceLevel: ExperienceLevel | null
  recommendedPathSlug?: string | null
}

const GOAL_PREFIX = 'goal:'
const LEVEL_PREFIX = 'level:'

export function parseProfilePreferences(value: string | null | undefined): ProfilePreferences {
  if (!value) {
    return { goal: null, experienceLevel: null }
  }

  let goal: LearningGoal | null = null
  let experienceLevel: ExperienceLevel | null = null

  const parts = value.split('|').map((part) => part.trim()).filter(Boolean)
  for (const part of parts) {
    if (part.startsWith(GOAL_PREFIX)) {
      goal = normalizeGoal(part.slice(GOAL_PREFIX.length))
      continue
    }
    if (part.startsWith(LEVEL_PREFIX)) {
      experienceLevel = normalizeExperienceLevel(part.slice(LEVEL_PREFIX.length))
      continue
    }
    if (!goal) {
      goal = normalizeGoal(part)
    }
  }

  return { goal, experienceLevel }
}

export function serializeProfilePreferences({
  goal,
  experienceLevel,
}: ProfilePreferences): string | null {
  if (!goal && !experienceLevel) return null

  const parts: string[] = []
  if (goal) parts.push(`${GOAL_PREFIX}${goal}`)
  if (experienceLevel) parts.push(`${LEVEL_PREFIX}${experienceLevel}`)
  return parts.join('|')
}

export function recommendLearningPath({
  goal,
  experienceLevel,
}: ProfilePreferences): string {
  if (experienceLevel === 'beginner') return 'systems-foundations'

  switch (goal) {
    case 'career':
      return experienceLevel === 'professional' ? 'ai-simulation' : 'systems-foundations'
    case 'study':
      return experienceLevel === 'expert' ? 'ai-simulation' : 'software-systems'
    case 'build':
      return 'energy-control'
    case 'curiosity':
    default:
      return experienceLevel === 'expert' ? 'materials-fabrication' : 'systems-foundations'
  }
}

export function getProfilePreferences(profile: {
  goal: string | null
  learning_goal?: string | null
  experience_level?: string | null
  recommended_path_slug?: string | null
}): ProfilePreferences {
  const legacy = parseProfilePreferences(profile.goal)
  return {
    goal: normalizeGoal(profile.learning_goal ?? '') ?? legacy.goal,
    experienceLevel: normalizeExperienceLevel(profile.experience_level ?? '') ?? legacy.experienceLevel,
    recommendedPathSlug: profile.recommended_path_slug ?? null,
  }
}

function normalizeGoal(value: string): LearningGoal | null {
  if (value === 'career' || value === 'curiosity' || value === 'study' || value === 'build') {
    return value
  }
  return null
}

function normalizeExperienceLevel(value: string): ExperienceLevel | null {
  if (
    value === 'beginner' ||
    value === 'student' ||
    value === 'professional' ||
    value === 'expert'
  ) {
    return value
  }
  return null
}
