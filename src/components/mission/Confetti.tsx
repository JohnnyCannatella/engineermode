'use client'

import { useState } from 'react'

const COLORS = ['#7c3aed', '#06b6d4', '#10b981', '#f59e0b', '#f43f5e', '#a78bfa', '#34d399', '#fbbf24']

interface Piece {
  id: number
  left: number
  color: string
  size: number
  duration: number
  delay: number
  shape: 'square' | 'circle' | 'rect'
}

export default function Confetti() {
  const [pieces] = useState<Piece[]>(() =>
    Array.from({ length: 48 }, (_, i) => ({
      id: i,
      left: Math.random() * 100,
      color: COLORS[Math.floor(Math.random() * COLORS.length)],
      size: 6 + Math.random() * 8,
      duration: 2.2 + Math.random() * 1.8,
      delay: Math.random() * 1.2,
      shape: (['square', 'circle', 'rect'] as const)[Math.floor(Math.random() * 3)],
    }))
  )

  return (
    <div className="fixed inset-0 pointer-events-none overflow-hidden z-50" aria-hidden>
      {pieces.map((p) => (
        <div
          key={p.id}
          style={{
            position: 'absolute',
            left: `${p.left}%`,
            top: 0,
            width: p.shape === 'rect' ? p.size * 1.8 : p.size,
            height: p.size,
            backgroundColor: p.color,
            borderRadius: p.shape === 'circle' ? '50%' : p.shape === 'rect' ? '2px' : '2px',
            animation: `confetti-fall ${p.duration}s ${p.delay}s linear forwards`,
            opacity: 0,
          }}
        />
      ))}
    </div>
  )
}
