alter table public.missions
  add column if not exists difficulty_level text,
  add column if not exists learning_objectives text[] default '{}',
  add column if not exists review_after_days integer default 7;

alter table public.missions
  drop constraint if exists missions_difficulty_level_check;

alter table public.missions
  add constraint missions_difficulty_level_check
  check (difficulty_level in ('intro', 'core', 'advanced') or difficulty_level is null);

create table if not exists public.mission_prerequisites (
  mission_id uuid not null references public.missions(id) on delete cascade,
  prerequisite_mission_id uuid not null references public.missions(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (mission_id, prerequisite_mission_id),
  check (mission_id <> prerequisite_mission_id)
);

create table if not exists public.user_mission_mastery (
  user_id uuid not null references auth.users(id) on delete cascade,
  mission_id uuid not null references public.missions(id) on delete cascade,
  mastery_level text not null default 'learning',
  last_score_pct integer not null default 0,
  completion_count integer not null default 0,
  last_completed_at timestamptz,
  next_review_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, mission_id)
);

alter table public.user_mission_mastery
  drop constraint if exists user_mission_mastery_mastery_level_check;

alter table public.user_mission_mastery
  add constraint user_mission_mastery_mastery_level_check
  check (mastery_level in ('learning', 'practicing', 'mastered'));

create index if not exists mission_prerequisites_prerequisite_idx
  on public.mission_prerequisites (prerequisite_mission_id);

create index if not exists user_mission_mastery_next_review_idx
  on public.user_mission_mastery (user_id, next_review_at);

update public.missions
set difficulty_level = case
  when order_index <= 3 then 'intro'
  when order_index <= 7 then 'core'
  else 'advanced'
end
where difficulty_level is null;

insert into public.mission_prerequisites (mission_id, prerequisite_mission_id)
select current_mission.id, previous_mission.id
from public.missions current_mission
join public.missions previous_mission
  on previous_mission.path_id = current_mission.path_id
 and previous_mission.order_index = current_mission.order_index - 1
on conflict do nothing;
