import type { Metadata, Viewport } from 'next'
import { IBM_Plex_Mono, Space_Grotesk } from 'next/font/google'
import './globals.css'

const spaceGrotesk = Space_Grotesk({ variable: '--font-space-grotesk', subsets: ['latin'] })
const ibmPlexMono = IBM_Plex_Mono({ variable: '--font-ibm-plex-mono', subsets: ['latin'], weight: ['400', '500', '600'] })

export const metadata: Metadata = {
  title: 'Engineer Mode',
  description: 'Mission control personale per costruire una mente da inventor-engineer: sistemi, software, energia, controllo, AI e prototipazione.',
  keywords: ['engineering', 'learning', 'systems', 'gamified', 'education'],
  manifest: '/manifest.json',
  appleWebApp: {
    capable: true,
    statusBarStyle: 'black-translucent',
    title: 'Engineer Mode',
  },
}

export const viewport: Viewport = {
  width: 'device-width',
  initialScale: 1,
  maximumScale: 1,
  themeColor: '#08111f',
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html
      lang="it"
      className={`${spaceGrotesk.variable} ${ibmPlexMono.variable} h-full`}
    >
      <body className="min-h-full antialiased">
        <div className="app-shell">
          <div className="app-shell__grid" />
          <div className="app-shell__glow app-shell__glow--a" />
          <div className="app-shell__glow app-shell__glow--b" />
          <div className="app-shell__content">{children}</div>
        </div>
      </body>
    </html>
  )
}
