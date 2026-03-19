import { cn } from '@/lib/utils'

export function Skeleton({ className }: { className?: string }) {
  return (
    <div
      className={cn(
        'animate-pulse rounded-xl bg-elevated',
        className
      )}
    />
  )
}

export function SkeletonCard() {
  return (
    <div className="bg-surface border border-rim/50 rounded-2xl p-4 flex flex-col gap-3">
      <div className="flex items-center gap-3">
        <Skeleton className="w-10 h-10 rounded-xl flex-shrink-0" />
        <div className="flex-1 flex flex-col gap-2">
          <Skeleton className="h-4 w-3/4" />
          <Skeleton className="h-3 w-1/2" />
        </div>
      </div>
      <Skeleton className="h-1.5 w-full rounded-full" />
    </div>
  )
}

export function SkeletonProfile() {
  return (
    <div className="flex flex-col items-center gap-4 py-8">
      <Skeleton className="w-20 h-20 rounded-full" />
      <Skeleton className="h-5 w-32" />
      <Skeleton className="h-4 w-48" />
    </div>
  )
}
