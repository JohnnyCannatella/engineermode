import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'

const features = [
  { icon: '◈', title: 'Pensiero Sistemico', desc: 'Confini, feedback, failure modes e architettura dei sistemi complessi.' },
  { icon: '◎', title: 'AI e Decisione', desc: 'Modelli, simulazione, stima, pianificazione e sistemi intelligenti credibili.' },
  { icon: '△', title: 'Energia e Controllo', desc: 'Potenza, attuatori, sensori e loop di controllo per macchine reali.' },
  { icon: '▣', title: 'Materiali e Prototipi', desc: 'Processi, tolleranze, DFM e iterazione rapida per costruire davvero.' },
  { icon: '◇', title: 'Architettura dei Sistemi', desc: 'Budget, interfacce, verification e integrazione per pensare da chief engineer.' },
]

export default async function LandingPage() {
  const supabase = await createClient()

  const [{ count: missionCount }, { count: pathCount }, { count: areaCount }] = await Promise.all([
    supabase.from('missions').select('*', { count: 'exact', head: true }).eq('is_published', true),
    supabase.from('learning_paths').select('*', { count: 'exact', head: true }).eq('is_published', true),
    supabase.from('learning_areas').select('*', { count: 'exact', head: true }),
  ])

  const totalMissions = missionCount ?? 40
  const totalPaths = pathCount ?? 7
  const totalAreas = areaCount ?? 5

  return (
    <main className="min-h-screen text-white">
      <nav className="mx-auto flex w-full max-w-6xl items-center justify-between px-6 py-6">
        <div className="flex items-center gap-3">
          <div className="flex h-11 w-11 items-center justify-center rounded-2xl border border-primary/30 bg-primary/10 text-lg text-primary-light">
            ◌
          </div>
          <div>
            <div className="eyebrow text-[11px] text-primary-light">Engineer Mode</div>
            <div className="text-sm font-semibold text-white/90">Inventor Mission Control</div>
          </div>
        </div>
        <Link
          href="/auth"
          className="rounded-full border border-rim/80 bg-surface/70 px-5 py-2.5 text-sm font-semibold text-white transition-all hover:border-primary/50 hover:bg-primary/10"
        >
          Accedi
        </Link>
      </nav>

      <section className="mx-auto grid w-full max-w-6xl gap-10 px-6 pb-16 pt-8 lg:grid-cols-[1.1fr_0.9fr] lg:items-center">
        <div>
          <div className="hud-chip mb-6">
            <span className="h-2 w-2 rounded-full bg-success" />
            <span className="eyebrow text-[10px] text-white/75">{totalAreas} macro aree · {totalPaths} percorsi · {totalMissions} missioni</span>
          </div>
          <h1 className="max-w-3xl text-5xl font-bold leading-[0.94] tracking-[-0.05em] text-white sm:text-6xl lg:text-7xl">
            Costruisci
            <span className="block text-primary-light">la tua mente</span>
            <span className="block">da inventor-engineer</span>
          </h1>
          <p className="mt-6 max-w-2xl text-base leading-8 text-muted sm:text-lg">
            Non un catalogo di corsi. Un sistema operativo personale per imparare quello che serve a progettare
            macchine, software, energia, controllo, AI e prototipi complessi.
          </p>
          <div className="mt-8 flex flex-wrap gap-3">
            <Link
              href="/auth"
              className="rounded-[1.4rem] bg-primary px-7 py-4 text-sm font-bold uppercase tracking-[0.18em] text-bg shadow-[0_18px_60px_rgba(255,122,24,0.35)] transition-all hover:bg-primary-hover"
            >
              Entra nel laboratorio
            </Link>
            <div className="rounded-[1.4rem] border border-rim/80 bg-surface/70 px-5 py-4 text-sm text-white/80">
              5-10 min per missione, progettato per progressione reale
            </div>
          </div>
        </div>

        <div className="panel-strong rounded-[2rem] p-5 sm:p-6">
          <div className="flex items-center justify-between">
            <div>
              <div className="eyebrow text-[10px] text-primary-light">Mission Brief</div>
              <div className="mt-2 text-2xl font-semibold">Roadmap Stark</div>
            </div>
            <div className="rounded-2xl border border-rim/70 bg-bg/70 px-3 py-2 font-mono text-xs text-primary-light">
              FASE v1
            </div>
          </div>
          <div className="hud-divider my-5" />
          <div className="grid gap-3">
            {[
              ['Fondamenta', 'Sistemi, segnali, energia, logica di base'],
              ['Costruttore', 'Software, elettronica, meccanica, potenza'],
              ['Inventore', 'Controllo, simulazione, AI, prototipazione'],
              ['Architetto', 'Integrazione completa di sottosistemi complessi'],
            ].map(([title, desc], index) => (
              <div key={title} className="panel rounded-[1.4rem] px-4 py-4">
                <div className="flex items-start gap-4">
                  <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-primary/10 font-mono text-sm text-primary-light">
                    0{index + 1}
                  </div>
                  <div>
                    <div className="text-sm font-semibold text-white">{title}</div>
                    <div className="mt-1 text-sm leading-6 text-muted">{desc}</div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="mx-auto w-full max-w-6xl px-6 pb-20">
        <div className="mb-6 flex items-center justify-between gap-4">
          <div>
            <div className="eyebrow text-[10px] text-primary-light">Curriculum</div>
            <h2 className="mt-2 text-2xl font-semibold tracking-[-0.03em] text-white">Macro aree del programma</h2>
          </div>
          <div className="hidden rounded-full border border-rim/70 bg-surface/60 px-4 py-2 text-xs text-muted sm:block">
            Progressione per missioni, non per lezioni passive
          </div>
        </div>
        <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-5">
          {features.map((feature) => (
            <div key={feature.title} className="panel rounded-[1.6rem] p-5">
              <div className="font-mono text-lg text-primary-light">{feature.icon}</div>
              <h3 className="mt-4 text-lg font-semibold text-white">{feature.title}</h3>
              <p className="mt-2 text-sm leading-7 text-muted">{feature.desc}</p>
            </div>
          ))}
        </div>
      </section>
    </main>
  )
}
