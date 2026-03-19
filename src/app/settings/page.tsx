'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'
import { updateProfile } from '@/app/actions'
import BottomNav from '@/components/ui/BottomNav'
import {
  getProfilePreferences,
  recommendLearningPath,
  type ExperienceLevel,
  type LearningGoal,
} from '@/lib/profile-preferences'

const AVATAR_COLORS = [
  { label: 'Violet', value: '#7C3AED' },
  { label: 'Cyan', value: '#06B6D4' },
  { label: 'Emerald', value: '#10B981' },
  { label: 'Amber', value: '#F59E0B' },
  { label: 'Rose', value: '#F43F5E' },
  { label: 'Blue', value: '#3B82F6' },
  { label: 'Pink', value: '#EC4899' },
  { label: 'Indigo', value: '#6366F1' },
]

const GOALS = [
  { value: 'career' as const, label: 'Avanzare nella carriera', emoji: '🚀' },
  { value: 'curiosity' as const, label: 'Soddisfare la mia curiosità', emoji: '🔍' },
  { value: 'study' as const, label: 'Integrare i miei studi', emoji: '📚' },
  { value: 'build' as const, label: 'Costruire sistemi migliori', emoji: '🔧' },
]

const EXPERIENCE_LEVELS = [
  { value: 'beginner' as const, label: 'Principiante', emoji: '🌱' },
  { value: 'student' as const, label: 'Studente', emoji: '📐' },
  { value: 'professional' as const, label: 'Professionista', emoji: '⚙️' },
  { value: 'expert' as const, label: 'Esperto', emoji: '🧠' },
]

export default function SettingsPage() {
  const [displayName, setDisplayName] = useState('')
  const [avatarColor, setAvatarColor] = useState('#7C3AED')
  const [goal, setGoal] = useState<LearningGoal | ''>('')
  const [experienceLevel, setExperienceLevel] = useState<ExperienceLevel | ''>('')
  const [email, setEmail] = useState('')
  const [loading, setLoading] = useState(false)
  const [saved, setSaved] = useState(false)
  const [initialLoading, setInitialLoading] = useState(true)
  const [learnPath, setLearnPath] = useState('systems-foundations')
  const router = useRouter()
  const supabase = createClient()

  useEffect(() => {
    async function load() {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) { router.push('/auth'); return }
      setEmail(user.email ?? '')
      let recommendedPath = 'systems-foundations'
      const { data } = await supabase.from('profiles').select('*').eq('id', user.id).single()
      if (data) {
        const preferences = getProfilePreferences(data)
        setDisplayName(data.display_name ?? '')
        setAvatarColor(data.avatar_color ?? '#7C3AED')
        setGoal(preferences.goal ?? '')
        setExperienceLevel(preferences.experienceLevel ?? '')
        recommendedPath = preferences.recommendedPathSlug ?? recommendLearningPath(preferences)
      }
      const [{ data: paths }, { data: allMissions }, { data: progress }] = await Promise.all([
        supabase.from('learning_paths').select('id,slug,mission_count').order('order_index'),
        supabase.from('missions').select('id,path_id'),
        supabase.from('user_mission_progress').select('mission_id,status').eq('user_id', user.id),
      ])
      if (paths && allMissions && progress) {
        const completedSet = new Set(progress.filter((p) => p.status === 'completed').map((p) => p.mission_id))
        const first = paths.find((path) => {
          const pathMissionIds = allMissions.filter((m) => m.path_id === path.id).map((m) => m.id)
          const completedInPath = pathMissionIds.filter((id) => completedSet.has(id)).length
          return completedInPath < path.mission_count
        })
        if (first) {
          setLearnPath(first.slug)
        } else {
          setLearnPath(recommendedPath)
        }
      }
      setInitialLoading(false)
    }
    load()
  }, [router, supabase])

  async function save() {
    setLoading(true)
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) return
    await supabase.from('profiles').update({
      avatar_color: avatarColor,
    }).eq('id', user.id)
    await updateProfile({
      display_name: displayName.trim() || undefined,
      goal: goal || undefined,
      experience_level: experienceLevel || undefined,
    })
    setSaved(true)
    setTimeout(() => setSaved(false), 2000)
    setLoading(false)
  }

  const initials = displayName ? displayName.charAt(0).toUpperCase() : '?'

  if (initialLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-2 border-[#2dd4bf] border-t-transparent" />
      </div>
    )
  }

  return (
    <div className="min-h-screen max-w-lg mx-auto px-5 pb-28 pt-8 text-white">
      <header className="pb-5">
        <Link href="/profile" className="mb-5 flex items-center gap-2 text-sm text-slate-400 transition-colors hover:text-white">
          ← Indietro
        </Link>
        <div className="panel-strong">
          <div className="eyebrow mb-3">Profile Config</div>
          <h1 className="text-3xl font-semibold text-white">Assetto operativo</h1>
          <p className="mt-3 text-sm leading-7 text-slate-300">Aggiorna identità, livello di esperienza e direzione della tua roadmap Stark.</p>
        </div>
      </header>

      <div className="flex flex-col gap-6">
        <div className="panel flex items-center gap-4">
          <div
            className="flex h-16 w-16 flex-shrink-0 items-center justify-center rounded-[1.35rem] border border-white/10 text-2xl font-bold text-white transition-colors duration-300"
            style={{ background: avatarColor }}
          >
            {initials}
          </div>
          <div>
            <div className="font-semibold text-white">{displayName || 'Il tuo nome'}</div>
            <div className="text-sm text-slate-400">{email}</div>
          </div>
        </div>

        <div>
          <label className="mb-2 block text-xs font-semibold uppercase tracking-[0.24em] text-slate-500">
            Nome visualizzato
          </label>
          <input
            type="text"
            value={displayName}
            onChange={(e) => setDisplayName(e.target.value)}
            placeholder="Il tuo nome o soprannome"
            maxLength={30}
            className="w-full rounded-2xl border border-white/10 bg-white/5 px-4 py-3 text-sm text-white placeholder:text-slate-500 transition-colors focus:border-[#2dd4bf]/50 focus:outline-none"
          />
        </div>

        <div>
          <label className="mb-3 block text-xs font-semibold uppercase tracking-[0.24em] text-slate-500">
            Colore avatar
          </label>
          <div className="grid grid-cols-4 gap-3">
            {AVATAR_COLORS.map((color) => (
              <button
                key={color.value}
                onClick={() => setAvatarColor(color.value)}
                className={`aspect-square rounded-xl border-2 transition-all ${
                  avatarColor === color.value ? 'scale-110 border-white shadow-lg' : 'scale-100 border-white/10'
                }`}
                style={{ background: color.value }}
                title={color.label}
              />
            ))}
          </div>
        </div>

        <div>
          <label className="mb-3 block text-xs font-semibold uppercase tracking-[0.24em] text-slate-500">
            Livello di esperienza
          </label>
          <div className="grid grid-cols-2 gap-2">
            {EXPERIENCE_LEVELS.map((level) => (
              <button
                key={level.value}
                onClick={() => setExperienceLevel(level.value)}
                className={`flex items-center gap-2 rounded-xl border p-3 text-left transition-all ${
                  experienceLevel === level.value
                    ? 'border-[#2dd4bf]/40 bg-[#2dd4bf]/10 text-white'
                    : 'border-white/10 bg-white/5 text-slate-400 hover:border-white/20 hover:text-white'
                }`}
              >
                <span className="text-lg">{level.emoji}</span>
                <span className="text-xs font-medium leading-tight">{level.label}</span>
              </button>
            ))}
          </div>
        </div>

        <div>
          <label className="mb-3 block text-xs font-semibold uppercase tracking-[0.24em] text-slate-500">
            Obiettivo
          </label>
          <div className="grid grid-cols-2 gap-2">
            {GOALS.map((currentGoal) => (
              <button
                key={currentGoal.value}
                onClick={() => setGoal(currentGoal.value)}
                className={`flex items-center gap-2 rounded-xl border p-3 text-left transition-all ${
                  goal === currentGoal.value
                    ? 'border-[#f6a63b]/40 bg-[#f6a63b]/10 text-white'
                    : 'border-white/10 bg-white/5 text-slate-400 hover:border-white/20 hover:text-white'
                }`}
              >
                <span className="text-lg">{currentGoal.emoji}</span>
                <span className="text-xs font-medium leading-tight">{currentGoal.label}</span>
              </button>
            ))}
          </div>
        </div>

        <div>
          <label className="mb-2 block text-xs font-semibold uppercase tracking-[0.24em] text-slate-500">
            Email
          </label>
          <div className="rounded-2xl border border-white/10 bg-white/5 px-4 py-3 text-sm text-slate-400">
            {email}
          </div>
          <p className="mt-1.5 text-xs text-slate-500">L&apos;email non può essere cambiata qui.</p>
        </div>

        <button
          onClick={save}
          disabled={loading}
          className={`w-full rounded-2xl border px-5 py-3.5 text-sm font-semibold uppercase tracking-[0.18em] transition-all ${
            saved ? 'border-[#2dd4bf]/40 bg-[#2dd4bf]/20 text-[#81f4e1]' : 'border-[#f6a63b]/40 bg-[linear-gradient(135deg,#f6a63b,#d97706)] text-slate-950'
          }`}
        >
          {loading ? 'Salvataggio...' : saved ? 'Salvato' : 'Salva'}
        </button>
      </div>

      <BottomNav active="/settings" learnPath={learnPath} />
    </div>
  )
}
