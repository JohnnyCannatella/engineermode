import { Skeleton, SkeletonCard } from '@/components/ui/Skeleton'

export default function DashboardLoading() {
  return (
    <div className="min-h-screen bg-bg max-w-lg mx-auto px-5 pt-12">
      {/* Header skeleton */}
      <div className="flex items-center justify-between mb-6">
        <div className="flex flex-col gap-2">
          <Skeleton className="h-3 w-20" />
          <Skeleton className="h-5 w-32" />
        </div>
        <Skeleton className="w-11 h-11 rounded-full" />
      </div>
      {/* XP card skeleton */}
      <Skeleton className="h-24 w-full rounded-2xl mb-8" />
      {/* Continue skeleton */}
      <Skeleton className="h-20 w-full rounded-2xl mb-6" />
      {/* Path cards */}
      <div className="flex flex-col gap-3">
        <SkeletonCard />
        <SkeletonCard />
        <SkeletonCard />
      </div>
    </div>
  )
}
