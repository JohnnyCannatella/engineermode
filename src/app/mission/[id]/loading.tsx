import { Skeleton } from '@/components/ui/Skeleton'

export default function MissionLoading() {
  return (
    <div className="min-h-screen bg-bg flex flex-col items-center justify-center px-6 py-12 max-w-lg mx-auto">
      <Skeleton className="w-16 h-16 rounded-full mb-6" />
      <Skeleton className="h-7 w-48 rounded-xl mb-3" />
      <Skeleton className="h-4 w-64 rounded-lg mb-2" />
      <Skeleton className="h-4 w-56 rounded-lg mb-10" />
      <div className="flex items-center gap-6 mb-10">
        <Skeleton className="h-10 w-16 rounded-xl" />
        <Skeleton className="h-10 w-16 rounded-xl" />
        <Skeleton className="h-10 w-16 rounded-xl" />
      </div>
      <Skeleton className="h-14 w-full max-w-xs rounded-2xl" />
    </div>
  )
}
