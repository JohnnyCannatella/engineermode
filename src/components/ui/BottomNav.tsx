import Link from 'next/link'

interface Props {
  active: string
  learnPath?: string
}

export default function BottomNav({ active, learnPath = 'systems-foundations' }: Props) {
  const navItems = [
    { href: '/dashboard', icon: '⌂', label: 'Base' },
    { href: `/path/${learnPath}`, icon: '◎', label: 'Roadmap' },
    { href: '/leaderboard', icon: '△', label: 'Rank' },
    { href: '/profile', icon: '◌', label: 'Dossier' },
    { href: '/settings', icon: '⋯', label: 'Assetto' },
  ]

  return (
    <nav className="touch-pan-y fixed bottom-3 left-1/2 z-50 flex w-[calc(100%-1rem)] max-w-xl -translate-x-1/2 items-center justify-around rounded-[1.75rem] border border-rim/70 bg-[#091423]/86 px-1.5 py-2 shadow-[0_24px_70px_rgba(0,0,0,0.45)] backdrop-blur-xl sm:bottom-4 sm:w-[calc(100%-1.5rem)] sm:px-2 sm:py-2.5">
      {navItems.map((item) => {
        const isActive =
          active === item.href ||
          (active.startsWith('/path/') && item.href.startsWith('/path/')) ||
          active === item.label.toLowerCase()
        return (
          <Link
            key={item.href}
            href={item.href}
            className={`flex min-w-0 flex-1 flex-col items-center gap-1 rounded-2xl px-1.5 py-2 transition-all sm:min-w-14 sm:flex-none sm:px-3 ${
              isActive ? 'bg-primary/12 text-white shadow-[inset_0_1px_0_rgba(255,255,255,0.03)]' : 'text-muted hover:text-white'
            }`}
          >
            <span className={`font-mono text-base leading-none ${isActive ? 'text-primary-light' : ''}`}>{item.icon}</span>
            <span className={`text-[9px] font-semibold uppercase tracking-[0.14em] sm:text-[10px] sm:tracking-[0.18em] ${isActive ? 'text-primary-light' : 'text-muted'}`}>
              {item.label}
            </span>
          </Link>
        )
      })}
    </nav>
  )
}
