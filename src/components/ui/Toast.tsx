'use client'

import { useEffect } from 'react'

export interface ToastItem {
  id: string
  message: string
  icon: string
  color: 'achievement' | 'success' | 'info'
}

const colorMap = {
  achievement: 'bg-warning/20 border-warning/50 text-warning',
  success: 'bg-success/20 border-success/50 text-success',
  info: 'bg-primary/20 border-primary/50 text-primary-light',
}

interface ToastProps {
  items: ToastItem[]
  onDismiss: (id: string) => void
}

export default function Toast({ items, onDismiss }: ToastProps) {
  return (
    <div className="fixed top-6 left-1/2 -translate-x-1/2 z-[100] flex flex-col gap-2 w-full max-w-sm px-4 pointer-events-none">
      {items.map((item) => (
        <ToastRow key={item.id} item={item} onDismiss={onDismiss} />
      ))}
    </div>
  )
}

function ToastRow({ item, onDismiss }: { item: ToastItem; onDismiss: (id: string) => void }) {
  useEffect(() => {
    const t = setTimeout(() => onDismiss(item.id), 3800)
    return () => clearTimeout(t)
  }, [item.id, onDismiss])

  return (
    <div
      className={`flex items-center gap-3 px-4 py-3 rounded-2xl border shadow-xl animate-fade-up pointer-events-auto backdrop-blur-sm ${colorMap[item.color]}`}
      style={{ background: 'rgba(15,15,26,0.92)' }}
    >
      <span className="text-2xl flex-shrink-0">{item.icon}</span>
      <span className="text-sm font-semibold text-white flex-1 leading-tight">{item.message}</span>
      <button
        onClick={() => onDismiss(item.id)}
        className="text-white/40 hover:text-white/80 transition-colors flex-shrink-0 text-xl leading-none"
      >
        ×
      </button>
    </div>
  )
}
