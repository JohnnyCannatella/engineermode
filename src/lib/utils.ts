import { clsx, type ClassValue } from 'clsx'
import type { XpProgress } from '@/types'

export function cn(...inputs: ClassValue[]) {
  return clsx(inputs)
}

export function xpForLevel(level: number): number {
  return Math.floor(100 * Math.pow(level, 1.5))
}

export function levelFromXp(totalXp: number): number {
  let level = 1
  while (xpForLevel(level + 1) <= totalXp) level++
  return level
}

export function xpProgress(totalXp: number): XpProgress {
  const level = levelFromXp(totalXp)
  const levelStart = xpForLevel(level)
  const levelEnd = xpForLevel(level + 1)
  return {
    level,
    current: totalXp - levelStart,
    needed: levelEnd - levelStart,
    totalXp,
  }
}

export function formatStreak(streak: number): string {
  if (streak === 0) return 'No streak'
  if (streak === 1) return '1 day'
  return `${streak} days`
}

export function getInitials(name: string | null): string {
  if (!name) return '?'
  return name
    .split(' ')
    .map((w) => w[0])
    .join('')
    .toUpperCase()
    .slice(0, 2)
}

export function isStreakActive(lastActiveDate: string | null): boolean {
  if (!lastActiveDate) return false
  const last = new Date(lastActiveDate)
  const now = new Date()
  const diffDays = Math.floor(
    (now.getTime() - last.getTime()) / (1000 * 60 * 60 * 24)
  )
  return diffDays <= 1
}
