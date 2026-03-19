import { Skeleton, SkeletonProfile } from '@/components/ui/Skeleton'

export default function ProfileLoading() {
  return (
    <div className="min-h-screen bg-bg max-w-lg mx-auto px-5 pt-12">
      <SkeletonProfile />
      <Skeleton className="h-24 w-full rounded-2xl mb-4" />
      <div className="grid grid-cols-2 gap-3 mb-6">
        <Skeleton className="h-20 rounded-2xl" />
        <Skeleton className="h-20 rounded-2xl" />
        <Skeleton className="h-20 rounded-2xl" />
        <Skeleton className="h-20 rounded-2xl" />
      </div>
      <Skeleton className="h-40 w-full rounded-2xl" />
    </div>
  )
}
