import Link from 'next/link'

export default function NotFound() {
  return (
    <main className="min-h-screen bg-bg flex flex-col items-center justify-center px-6 text-center">
      <div className="text-6xl mb-6">🔩</div>
      <h1 className="text-2xl font-bold text-white mb-2">Page not found</h1>
      <p className="text-muted mb-8 max-w-xs">
        This page does not exist or may have been moved. Let us get you back on track.
      </p>
      <Link
        href="/dashboard"
        className="px-6 py-3 rounded-xl font-medium text-white"
        style={{ background: 'linear-gradient(135deg, #7c3aed, #6d28d9)' }}
      >
        Back to Dashboard
      </Link>
    </main>
  )
}
