alter table public.profiles
  add column if not exists learning_goal text,
  add column if not exists experience_level text,
  add column if not exists recommended_path_slug text;

alter table public.profiles
  drop constraint if exists profiles_learning_goal_check;

alter table public.profiles
  add constraint profiles_learning_goal_check
  check (learning_goal in ('career', 'curiosity', 'study', 'build') or learning_goal is null);

alter table public.profiles
  drop constraint if exists profiles_experience_level_check;

alter table public.profiles
  add constraint profiles_experience_level_check
  check (experience_level in ('beginner', 'student', 'professional', 'expert') or experience_level is null);

alter table public.profiles
  drop constraint if exists profiles_recommended_path_slug_fkey;

alter table public.profiles
  add constraint profiles_recommended_path_slug_fkey
  foreign key (recommended_path_slug) references public.learning_paths(slug);

update public.profiles
set
  learning_goal = case
    when goal = 'career' then 'career'
    when goal = 'curiosity' then 'curiosity'
    when goal = 'study' then 'study'
    when goal = 'build' then 'build'
    when goal like 'goal:%' then split_part(split_part(goal, 'goal:', 2), '|', 1)
    else learning_goal
  end,
  experience_level = case
    when goal like '%level:beginner%' then 'beginner'
    when goal like '%level:student%' then 'student'
    when goal like '%level:professional%' then 'professional'
    when goal like '%level:expert%' then 'expert'
    else experience_level
  end;

update public.profiles
set recommended_path_slug = case
  when experience_level = 'beginner' then 'systems-foundations'
  when learning_goal = 'study' then 'software-systems'
  when learning_goal = 'career' and experience_level = 'professional' then 'software-systems'
  when learning_goal = 'build' and experience_level = 'expert' then 'mechanical-thinking'
  when learning_goal = 'curiosity' and experience_level = 'expert' then 'electronics-basics'
  else 'systems-foundations'
end
where recommended_path_slug is null;
