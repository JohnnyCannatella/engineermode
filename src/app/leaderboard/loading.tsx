import { Skeleton } from '@/components/ui/Skeleton'

export default function LeaderboardLoading() {
  return (
    <div className="min-h-screen bg-bg max-w-lg mx-auto px-5 pt-12">
      <Skeleton className="h-5 w-24 rounded-lg mb-6" />
      <Skeleton className="h-7 w-36 rounded-xl mb-1" />
      <Skeleton className="h-4 w-48 rounded-lg mb-6" />
      <Skeleton className="h-36 w-full rounded-2xl mb-6" />
      <div className="flex flex-col gap-2">
        {Array.from({ length: 8 }).map((_, i) => (
          <Skeleton key={i} className="h-16 w-full rounded-xl" />
        ))}
      </div>
    </div>
  )
}
