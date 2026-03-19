type Props = {
  completedDates: string[]
}

export default function ActivityCalendar({ completedDates }: Props) {
  const dateSet = new Set(completedDates.map((d) => d.split('T')[0]))

  // Build last 28 days
  const days: { date: string; active: boolean }[] = []
  for (let i = 27; i >= 0; i--) {
    const d = new Date()
    d.setDate(d.getDate() - i)
    const dateStr = d.toISOString().split('T')[0]
    days.push({ date: dateStr, active: dateSet.has(dateStr) })
  }

  // Split into 4 rows of 7
  const weeks: typeof days[] = []
  for (let i = 0; i < 4; i++) {
    weeks.push(days.slice(i * 7, i * 7 + 7))
  }

  const dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S']

  return (
    <div className="flex flex-col gap-2">
      {/* Day labels */}
      <div className="grid grid-cols-7 gap-1.5">
        {dayLabels.map((l, i) => (
          <div key={i} className="text-center text-[10px] text-muted font-medium">{l}</div>
        ))}
      </div>
      {/* Calendar grid */}
      {weeks.map((week, wi) => (
        <div key={wi} className="grid grid-cols-7 gap-1.5">
          {week.map((day, di) => (
            <div
              key={di}
              title={day.date}
              className={`aspect-square rounded-md transition-all ${
                day.active
                  ? 'bg-primary shadow-sm'
                  : 'bg-elevated'
              }`}
            />
          ))}
        </div>
      ))}
      <div className="flex justify-between mt-1">
        <span className="text-[10px] text-muted">28 days ago</span>
        <span className="text-[10px] text-muted">Today</span>
      </div>
    </div>
  )
}
