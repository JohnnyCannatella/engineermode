import type { StepVisual } from '@/types'

interface Props {
  visual: StepVisual
}

export default function TechnicalVisual({ visual }: Props) {
  return (
    <div className="rounded-[1.6rem] border border-white/10 bg-white/5 p-4">
      <div className="text-xs font-semibold uppercase tracking-[0.18em] text-slate-500">{visual.title}</div>
      <div className="mt-4 overflow-hidden rounded-[1.2rem] border border-white/10 bg-[#08111f]/80 p-4">

        {/* ── EXISTING ── */}

        {visual.kind === 'feedback-loop' && (
          <svg viewBox="0 0 360 150" className="w-full">
            <rect x="24" y="48" width="90" height="42" rx="12" fill="rgba(56,189,248,0.16)" stroke="#38bdf8" />
            <rect x="142" y="48" width="82" height="42" rx="12" fill="rgba(45,212,191,0.14)" stroke="#2dd4bf" />
            <rect x="252" y="48" width="84" height="42" rx="12" fill="rgba(246,166,59,0.14)" stroke="#f6a63b" />
            <path d="M114 69h28" stroke="#94a3b8" strokeWidth="3" />
            <path d="M224 69h28" stroke="#94a3b8" strokeWidth="3" />
            <path d="M294 90c0 24-28 34-114 34S66 114 66 92" fill="none" stroke="#7dd3fc" strokeWidth="3" strokeDasharray="7 6" />
            <text x="69" y="74" fill="#e2e8f0" fontSize="12" textAnchor="middle">Setpoint</text>
            <text x="183" y="74" fill="#e2e8f0" fontSize="12" textAnchor="middle">Controller</text>
            <text x="294" y="74" fill="#e2e8f0" fontSize="12" textAnchor="middle">Plant</text>
            <text x="155" y="36" fill="#7dd3fc" fontSize="11">feedback</text>
          </svg>
        )}

        {visual.kind === 'trade-study' && (
          <svg viewBox="0 0 360 150" className="w-full">
            <line x1="44" y1="112" x2="320" y2="112" stroke="#334155" strokeWidth="2" />
            <line x1="44" y1="112" x2="44" y2="28" stroke="#334155" strokeWidth="2" />
            <circle cx="110" cy="78" r="12" fill="#38bdf8" />
            <circle cx="188" cy="58" r="12" fill="#f6a63b" />
            <circle cx="264" cy="92" r="12" fill="#2dd4bf" />
            <text x="95" y="136" fill="#94a3b8" fontSize="11">Costo</text>
            <text x="8" y="40" fill="#94a3b8" fontSize="11">Prestazione</text>
            <text x="101" y="80" fill="#08111f" fontSize="10">A</text>
            <text x="184" y="60" fill="#08111f" fontSize="10">B</text>
            <text x="260" y="94" fill="#08111f" fontSize="10">C</text>
          </svg>
        )}

        {visual.kind === 'verification-stack' && (
          <svg viewBox="0 0 360 150" className="w-full">
            <rect x="84" y="102" width="192" height="24" rx="10" fill="rgba(246,166,59,0.16)" stroke="#f6a63b" />
            <rect x="108" y="74" width="144" height="22" rx="10" fill="rgba(56,189,248,0.16)" stroke="#38bdf8" />
            <rect x="128" y="48" width="104" height="20" rx="10" fill="rgba(45,212,191,0.16)" stroke="#2dd4bf" />
            <rect x="144" y="24" width="72" height="18" rx="9" fill="rgba(125,211,252,0.18)" stroke="#7dd3fc" />
            <text x="180" y="118" fill="#e2e8f0" fontSize="11" textAnchor="middle">System Test</text>
            <text x="180" y="88" fill="#e2e8f0" fontSize="11" textAnchor="middle">Integration / HIL</text>
            <text x="180" y="61" fill="#e2e8f0" fontSize="11" textAnchor="middle">Subsystem</text>
            <text x="180" y="37" fill="#e2e8f0" fontSize="10" textAnchor="middle">Component</text>
          </svg>
        )}

        {visual.kind === 'interface-contract' && (
          <svg viewBox="0 0 360 150" className="w-full">
            <rect x="26" y="44" width="102" height="54" rx="14" fill="rgba(56,189,248,0.16)" stroke="#38bdf8" />
            <rect x="232" y="44" width="102" height="54" rx="14" fill="rgba(45,212,191,0.16)" stroke="#2dd4bf" />
            <rect x="144" y="56" width="72" height="30" rx="12" fill="rgba(246,166,59,0.14)" stroke="#f6a63b" />
            <path d="M128 70h16M216 70h16" stroke="#94a3b8" strokeWidth="3" />
            <text x="77" y="74" fill="#e2e8f0" fontSize="12" textAnchor="middle">Sensors</text>
            <text x="180" y="74" fill="#e2e8f0" fontSize="11" textAnchor="middle">Contract</text>
            <text x="283" y="74" fill="#e2e8f0" fontSize="12" textAnchor="middle">Control</text>
            <text x="180" y="110" fill="#7dd3fc" fontSize="11" textAnchor="middle">rate · timeout · quality · fallback</text>
          </svg>
        )}

        {visual.kind === 'free-body' && (
          <svg viewBox="0 0 360 150" className="w-full">
            <rect x="150" y="52" width="60" height="46" rx="12" fill="rgba(56,189,248,0.16)" stroke="#38bdf8" />
            <line x1="180" y1="18" x2="180" y2="50" stroke="#f6a63b" strokeWidth="3" />
            <line x1="180" y1="100" x2="180" y2="136" stroke="#ef4444" strokeWidth="3" />
            <line x1="124" y1="76" x2="148" y2="76" stroke="#2dd4bf" strokeWidth="3" />
            <line x1="212" y1="76" x2="238" y2="76" stroke="#7dd3fc" strokeWidth="3" />
            <text x="188" y="28" fill="#f8c777" fontSize="11">N</text>
            <text x="188" y="130" fill="#fca5a5" fontSize="11">W</text>
            <text x="126" y="68" fill="#81f4e1" fontSize="11">F_f</text>
            <text x="220" y="68" fill="#7dd3fc" fontSize="11">F</text>
          </svg>
        )}

        {visual.kind === 'circuit-loop' && (
          <svg viewBox="0 0 360 150" className="w-full">
            <path d="M72 42h74M210 42h80v68h-52M72 42v68h46" stroke="#94a3b8" strokeWidth="3" fill="none" />
            <path d="M118 110h172" stroke="#94a3b8" strokeWidth="3" fill="none" />
            <rect x="146" y="30" width="52" height="24" rx="10" fill="rgba(246,166,59,0.14)" stroke="#f6a63b" />
            <path d="M102 28v28M116 34v16" stroke="#38bdf8" strokeWidth="3" />
            <path d="M290 58v20M304 52v32" stroke="#2dd4bf" strokeWidth="3" />
            <text x="98" y="20" fill="#7dd3fc" fontSize="11">V</text>
            <text x="164" y="46" fill="#f8fafc" fontSize="11">R</text>
            <text x="298" y="46" fill="#81f4e1" fontSize="11">I</text>
          </svg>
        )}

        {visual.kind === 'complexity-scale' && (
          <svg viewBox="0 0 360 150" className="w-full">
            <line x1="42" y1="112" x2="322" y2="112" stroke="#334155" strokeWidth="2" />
            <line x1="42" y1="112" x2="42" y2="26" stroke="#334155" strokeWidth="2" />
            <path d="M58 100c30-4 52-8 78-14 18-5 24-10 38-20 14-10 22-22 36-40" stroke="#38bdf8" strokeWidth="3" fill="none" />
            <path d="M58 101c32-2 60-2 92-4 34-2 70-6 112-12" stroke="#2dd4bf" strokeWidth="3" fill="none" />
            <path d="M58 102c42-1 82-2 122-2 40 0 78 1 122 2" stroke="#f6a63b" strokeWidth="3" fill="none" />
            <text x="246" y="34" fill="#7dd3fc" fontSize="11">O(2^n)</text>
            <text x="268" y="78" fill="#81f4e1" fontSize="11">O(n log n)</text>
            <text x="270" y="100" fill="#f8c777" fontSize="11">O(n)</text>
          </svg>
        )}

        {/* ── NEW: STATE MACHINE ── */}
        {visual.kind === 'state-machine' && (
          <svg viewBox="0 0 360 150" className="w-full">
            {/* States */}
            <circle cx="60" cy="75" r="28" fill="rgba(56,189,248,0.14)" stroke="#38bdf8" strokeWidth="1.5" />
            <circle cx="180" cy="75" r="28" fill="rgba(45,212,191,0.14)" stroke="#2dd4bf" strokeWidth="1.5" />
            <circle cx="300" cy="75" r="28" fill="rgba(246,166,59,0.14)" stroke="#f6a63b" strokeWidth="1.5" />
            {/* Final state double ring */}
            <circle cx="300" cy="75" r="22" fill="none" stroke="#f6a63b" strokeWidth="1" strokeDasharray="3 2" />
            {/* Arrows S0→S1 */}
            <path d="M89 70h62" stroke="#94a3b8" strokeWidth="2" fill="none" markerEnd="url(#arrow)" />
            <text x="120" y="62" fill="#7dd3fc" fontSize="10" textAnchor="middle">evento A</text>
            {/* Arrows S1→S2 */}
            <path d="M209 70h62" stroke="#94a3b8" strokeWidth="2" fill="none" markerEnd="url(#arrow)" />
            <text x="240" y="62" fill="#7dd3fc" fontSize="10" textAnchor="middle">evento B</text>
            {/* Self-loop S1 */}
            <path d="M175 46 Q180 20 185 46" stroke="#94a3b8" strokeWidth="1.5" fill="none" markerEnd="url(#arrow)" />
            <text x="180" y="16" fill="#94a3b8" fontSize="9" textAnchor="middle">loop</text>
            {/* Labels */}
            <text x="60" y="79" fill="#e2e8f0" fontSize="10" textAnchor="middle">S0</text>
            <text x="180" y="79" fill="#e2e8f0" fontSize="10" textAnchor="middle">S1</text>
            <text x="300" y="79" fill="#e2e8f0" fontSize="10" textAnchor="middle">S2</text>
            <text x="60" y="118" fill="#94a3b8" fontSize="9" textAnchor="middle">Inizio</text>
            <text x="180" y="118" fill="#94a3b8" fontSize="9" textAnchor="middle">Attivo</text>
            <text x="300" y="118" fill="#94a3b8" fontSize="9" textAnchor="middle">Terminale</text>
            {/* Arrow marker */}
            <defs>
              <marker id="arrow" markerWidth="6" markerHeight="6" refX="5" refY="3" orient="auto">
                <path d="M0,0 L0,6 L6,3 z" fill="#94a3b8" />
              </marker>
            </defs>
          </svg>
        )}

        {/* ── NEW: OSI STACK ── */}
        {visual.kind === 'osi-stack' && (
          <svg viewBox="0 0 360 168" className="w-full">
            {[
              { y: 8,  label: '7 · Applicazione',   fill: 'rgba(167,139,250,0.25)', stroke: '#a78bfa' },
              { y: 32, label: '6 · Presentazione',  fill: 'rgba(129,140,248,0.20)', stroke: '#818cf8' },
              { y: 56, label: '5 · Sessione',        fill: 'rgba(56,189,248,0.18)',  stroke: '#38bdf8' },
              { y: 80, label: '4 · Trasporto',       fill: 'rgba(45,212,191,0.18)',  stroke: '#2dd4bf' },
              { y: 104,label: '3 · Rete',            fill: 'rgba(52,211,153,0.18)',  stroke: '#34d399' },
              { y: 128,label: '2 · Data Link',       fill: 'rgba(246,166,59,0.18)',  stroke: '#f6a63b' },
              { y: 152,label: '1 · Fisico',          fill: 'rgba(239,68,68,0.18)',   stroke: '#ef4444' },
            ].map(({ y, label, fill, stroke }) => (
              <g key={y}>
                <rect x="40" y={y} width="280" height="20" rx="6" fill={fill} stroke={stroke} strokeWidth="1" />
                <text x="180" y={y + 14} fill="#e2e8f0" fontSize="10" textAnchor="middle">{label}</text>
              </g>
            ))}
          </svg>
        )}

        {/* ── NEW: MEMORY MAP ── */}
        {visual.kind === 'memory-map' && (
          <svg viewBox="0 0 360 152" className="w-full">
            {/* Stack (top — grows down) */}
            <rect x="120" y="8" width="120" height="28" rx="8" fill="rgba(56,189,248,0.18)" stroke="#38bdf8" />
            <text x="180" y="27" fill="#e2e8f0" fontSize="11" textAnchor="middle">Stack ↓</text>
            {/* ... gap */}
            <text x="180" y="54" fill="#475569" fontSize="10" textAnchor="middle">· · · spazio libero · · ·</text>
            {/* Heap (grows up) */}
            <rect x="120" y="66" width="120" height="28" rx="8" fill="rgba(52,211,153,0.18)" stroke="#34d399" />
            <text x="180" y="85" fill="#e2e8f0" fontSize="11" textAnchor="middle">Heap ↑</text>
            {/* BSS / Data */}
            <rect x="120" y="100" width="120" height="22" rx="8" fill="rgba(246,166,59,0.18)" stroke="#f6a63b" />
            <text x="180" y="115" fill="#e2e8f0" fontSize="10" textAnchor="middle">BSS / Data</text>
            {/* Text / Code */}
            <rect x="120" y="128" width="120" height="20" rx="8" fill="rgba(239,68,68,0.14)" stroke="#ef4444" />
            <text x="180" y="142" fill="#e2e8f0" fontSize="10" textAnchor="middle">Codice (read-only)</text>
            {/* Address axis */}
            <line x1="100" y1="8" x2="100" y2="150" stroke="#334155" strokeWidth="1.5" />
            <text x="96" y="14" fill="#94a3b8" fontSize="9" textAnchor="end">High</text>
            <text x="96" y="148" fill="#94a3b8" fontSize="9" textAnchor="end">Low</text>
          </svg>
        )}

        {/* ── NEW: SIGNAL WAVE ── */}
        {visual.kind === 'signal-wave' && (
          <svg viewBox="0 0 360 150" className="w-full">
            {/* Axes */}
            <line x1="32" y1="30" x2="32" y2="130" stroke="#334155" strokeWidth="1.5" />
            <line x1="32" y1="130" x2="336" y2="130" stroke="#334155" strokeWidth="1.5" />
            <text x="26" y="20" fill="#94a3b8" fontSize="9" textAnchor="middle">V</text>
            <text x="340" y="134" fill="#94a3b8" fontSize="9">t</text>

            {/* Sine wave */}
            <path
              d="M40 80 Q60 40 80 80 Q100 120 120 80 Q140 40 160 80 Q180 120 200 80"
              stroke="#38bdf8" strokeWidth="2" fill="none"
            />
            <text x="204" y="80" fill="#38bdf8" fontSize="9">sin</text>

            {/* Square wave */}
            <path
              d="M40 110 L40 60 L80 60 L80 110 L120 110 L120 60 L160 60 L160 110 L200 110"
              stroke="#2dd4bf" strokeWidth="2" fill="none"
            />
            <text x="204" y="110" fill="#2dd4bf" fontSize="9">sqr</text>

            {/* PWM wave */}
            <path
              d="M40 125 L40 95 L55 95 L55 125 L80 125 L80 95 L95 95 L95 125 L120 125 L120 95 L135 95 L135 125 L160 125 L160 95 L175 95 L175 125"
              stroke="#f6a63b" strokeWidth="2" fill="none"
            />
            <text x="204" y="125" fill="#f6a63b" fontSize="9">PWM</text>
          </svg>
        )}

        {/* ── NEW: BINARY TREE ── */}
        {visual.kind === 'binary-tree' && (
          <svg viewBox="0 0 360 150" className="w-full">
            {/* Edges */}
            <line x1="180" y1="32" x2="100" y2="72" stroke="#334155" strokeWidth="1.5" />
            <line x1="180" y1="32" x2="260" y2="72" stroke="#334155" strokeWidth="1.5" />
            <line x1="100" y1="88" x2="60" y2="120" stroke="#334155" strokeWidth="1.5" />
            <line x1="100" y1="88" x2="140" y2="120" stroke="#334155" strokeWidth="1.5" />
            <line x1="260" y1="88" x2="220" y2="120" stroke="#334155" strokeWidth="1.5" />
            <line x1="260" y1="88" x2="300" y2="120" stroke="#334155" strokeWidth="1.5" />
            {/* Root */}
            <circle cx="180" cy="25" r="18" fill="rgba(167,139,250,0.2)" stroke="#a78bfa" strokeWidth="1.5" />
            <text x="180" y="29" fill="#e2e8f0" fontSize="11" textAnchor="middle">50</text>
            {/* L1 */}
            <circle cx="100" cy="80" r="15" fill="rgba(56,189,248,0.18)" stroke="#38bdf8" strokeWidth="1.5" />
            <text x="100" y="84" fill="#e2e8f0" fontSize="10" textAnchor="middle">25</text>
            <circle cx="260" cy="80" r="15" fill="rgba(45,212,191,0.18)" stroke="#2dd4bf" strokeWidth="1.5" />
            <text x="260" y="84" fill="#e2e8f0" fontSize="10" textAnchor="middle">75</text>
            {/* L2 */}
            <circle cx="60" cy="128" r="13" fill="rgba(246,166,59,0.18)" stroke="#f6a63b" strokeWidth="1.5" />
            <text x="60" y="132" fill="#e2e8f0" fontSize="10" textAnchor="middle">10</text>
            <circle cx="140" cy="128" r="13" fill="rgba(246,166,59,0.18)" stroke="#f6a63b" strokeWidth="1.5" />
            <text x="140" y="132" fill="#e2e8f0" fontSize="10" textAnchor="middle">40</text>
            <circle cx="220" cy="128" r="13" fill="rgba(246,166,59,0.18)" stroke="#f6a63b" strokeWidth="1.5" />
            <text x="220" y="132" fill="#e2e8f0" fontSize="10" textAnchor="middle">60</text>
            <circle cx="300" cy="128" r="13" fill="rgba(246,166,59,0.18)" stroke="#f6a63b" strokeWidth="1.5" />
            <text x="300" y="132" fill="#e2e8f0" fontSize="10" textAnchor="middle">90</text>
          </svg>
        )}

        {/* ── NEW: PID CONTROLLER ── */}
        {visual.kind === 'pid-controller' && (
          <svg viewBox="0 0 360 150" className="w-full">
            {/* Setpoint */}
            <text x="18" y="72" fill="#94a3b8" fontSize="10">r(t)</text>
            {/* Summing junction */}
            <circle cx="68" cy="68" r="14" fill="rgba(56,189,248,0.1)" stroke="#38bdf8" strokeWidth="1.5" />
            <text x="68" y="73" fill="#38bdf8" fontSize="14" textAnchor="middle">Σ</text>
            {/* PID block */}
            <rect x="102" y="50" width="80" height="36" rx="10" fill="rgba(167,139,250,0.16)" stroke="#a78bfa" strokeWidth="1.5" />
            <text x="142" y="65" fill="#e2e8f0" fontSize="10" textAnchor="middle">P · I · D</text>
            <text x="142" y="79" fill="#a78bfa" fontSize="9" textAnchor="middle">Controllore</text>
            {/* Plant */}
            <rect x="216" y="50" width="70" height="36" rx="10" fill="rgba(45,212,191,0.14)" stroke="#2dd4bf" strokeWidth="1.5" />
            <text x="251" y="65" fill="#e2e8f0" fontSize="10" textAnchor="middle">Pianta</text>
            <text x="251" y="79" fill="#2dd4bf" fontSize="9" textAnchor="middle">G(s)</text>
            {/* Output */}
            <text x="312" y="72" fill="#f6a63b" fontSize="10">y(t)</text>
            {/* Connections */}
            <path d="M36 68h18" stroke="#94a3b8" strokeWidth="2" />
            <path d="M82 68h20" stroke="#94a3b8" strokeWidth="2" />
            <path d="M182 68h34" stroke="#94a3b8" strokeWidth="2" />
            <path d="M286 68h22" stroke="#94a3b8" strokeWidth="2" />
            {/* Feedback arrow */}
            <path d="M308 80 Q308 120 180 120 Q80 120 68 82" fill="none" stroke="#f6a63b" strokeWidth="2" strokeDasharray="6 4" />
            <text x="185" y="136" fill="#f6a63b" fontSize="9" textAnchor="middle">feedback e(t) = r(t) – y(t)</text>
            {/* Error label */}
            <text x="68" y="47" fill="#7dd3fc" fontSize="9" textAnchor="middle">e(t)</text>
          </svg>
        )}

        {/* ── NEW: MOSFET SYMBOL ── */}
        {visual.kind === 'mosfet-symbol' && (
          <svg viewBox="0 0 360 150" className="w-full">
            {/* Gate terminal */}
            <line x1="60" y1="75" x2="130" y2="75" stroke="#38bdf8" strokeWidth="2" />
            <text x="48" y="79" fill="#38bdf8" fontSize="11" textAnchor="middle">G</text>
            {/* Gate insulator (vertical bar) */}
            <rect x="130" y="45" width="5" height="60" rx="2" fill="rgba(56,189,248,0.3)" stroke="#38bdf8" strokeWidth="1" />
            {/* Channel / Body */}
            <line x1="145" y1="45" x2="145" y2="105" stroke="#94a3b8" strokeWidth="2.5" />
            {/* Drain connection */}
            <line x1="145" y1="52" x2="220" y2="52" stroke="#2dd4bf" strokeWidth="2" />
            <line x1="220" y1="52" x2="220" y2="20" stroke="#2dd4bf" strokeWidth="2" />
            <text x="230" y="24" fill="#2dd4bf" fontSize="11">D</text>
            {/* Source connection */}
            <line x1="145" y1="98" x2="220" y2="98" stroke="#f6a63b" strokeWidth="2" />
            <line x1="220" y1="98" x2="220" y2="130" stroke="#f6a63b" strokeWidth="2" />
            <text x="230" y="134" fill="#f6a63b" fontSize="11">S</text>
            {/* Arrow (N-channel: points inward) */}
            <path d="M145 75 l-10 6 l0-12 z" fill="#a78bfa" />
            {/* Body diode */}
            <path d="M220 68 L220 82 M215 68 L225 68 M215 82 L225 82" stroke="#94a3b8" strokeWidth="1" fill="none" />
            {/* Labels */}
            <text x="180" y="140" fill="#94a3b8" fontSize="9" textAnchor="middle">N-channel MOSFET</text>
            <text x="136" y="40" fill="#94a3b8" fontSize="8" textAnchor="middle">ossido</text>
          </svg>
        )}

        {/* ── NEW: PIPELINE STAGES ── */}
        {visual.kind === 'pipeline-stages' && (
          <svg viewBox="0 0 360 110" className="w-full">
            {[
              { x: 20,  label: 'IF',  sub: 'Fetch',    fill: 'rgba(167,139,250,0.2)', stroke: '#a78bfa' },
              { x: 85,  label: 'ID',  sub: 'Decode',   fill: 'rgba(56,189,248,0.18)', stroke: '#38bdf8' },
              { x: 150, label: 'EX',  sub: 'Execute',  fill: 'rgba(45,212,191,0.18)', stroke: '#2dd4bf' },
              { x: 215, label: 'MEM', sub: 'Memory',   fill: 'rgba(246,166,59,0.18)', stroke: '#f6a63b' },
              { x: 280, label: 'WB',  sub: 'Write',    fill: 'rgba(239,68,68,0.18)',  stroke: '#ef4444' },
            ].map(({ x, label, sub, fill, stroke }, i) => (
              <g key={label}>
                <rect x={x} y="30" width="55" height="50" rx="10" fill={fill} stroke={stroke} strokeWidth="1.5" />
                <text x={x + 27} y="52" fill="#e2e8f0" fontSize="13" textAnchor="middle" fontWeight="bold">{label}</text>
                <text x={x + 27} y="68" fill="#94a3b8" fontSize="8" textAnchor="middle">{sub}</text>
                {i < 4 && (
                  <path d={`M${x + 55} 55 l8 0`} stroke="#94a3b8" strokeWidth="2" markerEnd="url(#arrowP)" />
                )}
              </g>
            ))}
            {/* Time axis */}
            <line x1="20" y1="95" x2="340" y2="95" stroke="#334155" strokeWidth="1" />
            <text x="185" y="108" fill="#475569" fontSize="9" textAnchor="middle">tempo →</text>
            <defs>
              <marker id="arrowP" markerWidth="5" markerHeight="5" refX="4" refY="2.5" orient="auto">
                <path d="M0,0 L0,5 L5,2.5 z" fill="#94a3b8" />
              </marker>
            </defs>
          </svg>
        )}

      </div>
      <p className="mt-3 text-sm leading-6 text-slate-400">{visual.caption}</p>
    </div>
  )
}
