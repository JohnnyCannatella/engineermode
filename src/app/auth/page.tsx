'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import Link from 'next/link'

export default function AuthPage() {
  const [mode, setMode] = useState<'signin' | 'signup'>('signin')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [message, setMessage] = useState<string | null>(null)
  const router = useRouter()
  const supabase = createClient()

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setLoading(true)
    setError(null)
    setMessage(null)

    if (mode === 'signup') {
      const { error } = await supabase.auth.signUp({
        email,
        password,
        options: { emailRedirectTo: `${window.location.origin}/auth/callback` },
      })
      if (error) {
        setError(error.message)
      } else {
        setMessage('Controlla la tua email per confermare l\'account, poi accedi.')
      }
    } else {
      const { error } = await supabase.auth.signInWithPassword({ email, password })
      if (error) {
        setError(error.message)
      } else {
        router.push('/dashboard')
        router.refresh()
      }
    }

    setLoading(false)
  }

  return (
    <main className="min-h-screen px-6 py-10 text-white">
      <div className="mx-auto flex min-h-[calc(100vh-5rem)] w-full max-w-sm flex-col justify-center">
        <Link href="/" className="mb-8 flex items-center gap-3">
          <span className="flex h-12 w-12 items-center justify-center rounded-2xl border border-white/10 bg-white/5 text-2xl shadow-[0_16px_36px_rgba(8,17,31,0.35)]">⚙️</span>
          <div>
            <div className="eyebrow">Engineer Mode</div>
            <div className="text-sm text-slate-400">Accesso al Mission Control</div>
          </div>
        </Link>

        <div className="panel-strong">
          <div className="eyebrow mb-3">Authentication</div>
          <h1 className="text-3xl font-semibold leading-tight text-white">
            Entra nel tuo laboratorio operativo.
          </h1>
          <p className="mt-3 text-sm leading-7 text-slate-300">
            Accedi per riprendere roadmap, missioni, ripassi e progressione del tuo dossier tecnico.
          </p>

          <div className="mt-6 flex rounded-2xl border border-white/10 bg-white/5 p-1">
          {(['signin', 'signup'] as const).map((m) => (
            <button
              key={m}
              onClick={() => { setMode(m); setError(null); setMessage(null) }}
              className={`flex-1 py-2.5 rounded-lg text-sm font-medium transition-all ${
                mode === m
                  ? 'bg-[linear-gradient(135deg,#f6a63b,#d97706)] text-slate-950 shadow-[0_12px_28px_rgba(245,158,11,0.2)]'
                  : 'text-slate-400 hover:text-white'
              }`}
            >
              {m === 'signin' ? 'Accedi' : 'Registrati'}
            </button>
          ))}
          </div>

        <form onSubmit={handleSubmit} className="mt-6 flex flex-col gap-4">
          <div className="flex flex-col gap-1.5">
            <label className="text-xs font-medium uppercase tracking-[0.24em] text-slate-500">
              Email
            </label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="you@example.com"
              required
              className="w-full rounded-2xl border border-white/10 bg-white/5 px-4 py-3 text-sm text-white placeholder:text-slate-500 focus:border-[#2dd4bf]/50 focus:outline-none transition-colors"
            />
          </div>

          <div className="flex flex-col gap-1.5">
            <label className="text-xs font-medium uppercase tracking-[0.24em] text-slate-500">
              Password
            </label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="••••••••"
              required
              minLength={6}
              className="w-full rounded-2xl border border-white/10 bg-white/5 px-4 py-3 text-sm text-white placeholder:text-slate-500 focus:border-[#2dd4bf]/50 focus:outline-none transition-colors"
            />
          </div>

          {error && (
            <div className="rounded-2xl border border-[#ef4444]/30 bg-[#ef4444]/10 px-4 py-3 text-sm text-[#fca5a5]">
              {error}
            </div>
          )}

          {message && (
            <div className="rounded-2xl border border-[#2dd4bf]/30 bg-[#2dd4bf]/10 px-4 py-3 text-sm text-[#81f4e1]">
              {message}
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            className="mt-1 w-full rounded-2xl border border-[#f6a63b]/40 bg-[linear-gradient(135deg,#f6a63b,#d97706)] py-3.5 text-sm font-semibold uppercase tracking-[0.18em] text-slate-950 transition-opacity disabled:opacity-60"
          >
            {loading ? '...' : mode === 'signin' ? 'Accedi' : 'Crea account'}
          </button>
        </form>

        {mode === 'signin' && (
          <div className="mt-6 flex flex-col items-center gap-2">
            <p className="text-center text-sm text-slate-400">
              Non hai un account?{' '}
              <button
                onClick={() => setMode('signup')}
                className="text-[#7dd3fc] hover:text-white transition-colors"
              >
                Registrati gratis
              </button>
            </p>
            <Link href="/auth/reset" className="text-xs text-slate-500 hover:text-white transition-colors">
              Password dimenticata?
            </Link>
          </div>
        )}
        </div>
      </div>
    </main>
  )
}
