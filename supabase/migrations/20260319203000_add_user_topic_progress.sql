create table if not exists public.user_topic_progress (
  user_id uuid not null references auth.users(id) on delete cascade,
  topic_slug text not null references public.topics(slug) on delete cascade,
  status text not null default 'not_started' check (status in ('not_started', 'studying', 'understood')),
  started_at timestamptz,
  completed_at timestamptz,
  updated_at timestamptz not null default timezone('utc', now()),
  primary key (user_id, topic_slug)
);

create index if not exists user_topic_progress_user_id_idx on public.user_topic_progress(user_id);
create index if not exists user_topic_progress_topic_slug_idx on public.user_topic_progress(topic_slug);

create or replace function public.set_user_topic_progress_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;

drop trigger if exists set_user_topic_progress_updated_at on public.user_topic_progress;
create trigger set_user_topic_progress_updated_at
before update on public.user_topic_progress
for each row
execute function public.set_user_topic_progress_updated_at();

alter table public.user_topic_progress enable row level security;

drop policy if exists "Users can read own topic progress" on public.user_topic_progress;
create policy "Users can read own topic progress"
on public.user_topic_progress
for select
using (auth.uid() = user_id);

drop policy if exists "Users can insert own topic progress" on public.user_topic_progress;
create policy "Users can insert own topic progress"
on public.user_topic_progress
for insert
with check (auth.uid() = user_id);

drop policy if exists "Users can update own topic progress" on public.user_topic_progress;
create policy "Users can update own topic progress"
on public.user_topic_progress
for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);
