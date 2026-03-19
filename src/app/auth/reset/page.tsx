'use client'

import { useState } from 'react'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'

export default function ResetPage() {
  const [email, setEmail] = useState('')
  const [loading, setLoading] = useState(false)
  const [sent, setSent] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const supabase = createClient()

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setLoading(true)
    setError(null)

    const { error } = await supabase.auth.resetPasswordForEmail(email, {
      redirectTo: `${window.location.origin}/auth/update-password`,
    })

    if (error) {
      setError(error.message)
    } else {
      setSent(true)
    }
    setLoading(false)
  }

  return (
    <main className="min-h-screen bg-bg flex flex-col items-center justify-center px-6 py-12">
      <Link href="/" className="flex items-center gap-2 mb-12">
        <span className="text-2xl">⚙️</span>
        <span className="font-semibold text-white tracking-tight">Engineer Mode</span>
      </Link>

      <div className="w-full max-w-sm">
        <h1 className="text-2xl font-bold text-white mb-2">Reimposta password</h1>
        <p className="text-muted text-sm mb-8">
          Inserisci la tua email e ti invieremo un link di reset.
        </p>

        {sent ? (
          <div className="flex flex-col items-center gap-4 text-center">
            <div className="text-4xl">📬</div>
            <p className="text-success font-medium">Controlla la tua email</p>
            <p className="text-muted text-sm">
              Un link di reset è stato inviato a <span className="text-white">{email}</span>.
            </p>
            <Link href="/auth" className="text-sm text-primary-light hover:text-white transition-colors mt-2">
              Torna all&apos;accesso
            </Link>
          </div>
        ) : (
          <form onSubmit={handleSubmit} className="flex flex-col gap-4">
            <div className="flex flex-col gap-1.5">
              <label className="text-xs font-medium text-muted uppercase tracking-wider">
                Email
              </label>
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="you@example.com"
                required
                className="w-full px-4 py-3 rounded-xl bg-elevated border border-rim/60 text-white placeholder:text-muted/50 focus:outline-none focus:border-primary/60 transition-colors text-sm"
              />
            </div>

            {error && (
              <div className="px-4 py-3 rounded-xl bg-danger/10 border border-danger/30 text-danger text-sm">
                {error}
              </div>
            )}

            <button
              type="submit"
              disabled={loading}
              className="w-full py-3.5 rounded-xl font-semibold text-white disabled:opacity-60 transition-opacity mt-1"
              style={{ background: 'linear-gradient(135deg, #7c3aed, #6d28d9)' }}
            >
              {loading ? '...' : 'Invia link di reset'}
            </button>

            <Link
              href="/auth"
              className="text-center text-sm text-muted hover:text-white transition-colors"
            >
              Torna all&apos;accesso
            </Link>
          </form>
        )}
      </div>
    </main>
  )
}
