create table if not exists public.topic_prerequisites (
  topic_slug text not null references public.topics(slug) on delete cascade,
  prerequisite_topic_slug text not null references public.topics(slug) on delete cascade,
  sort_order integer not null default 0,
  created_at timestamptz not null default timezone('utc', now()),
  primary key (topic_slug, prerequisite_topic_slug),
  check (topic_slug <> prerequisite_topic_slug)
);

create index if not exists topic_prerequisites_topic_slug_idx on public.topic_prerequisites(topic_slug);
create index if not exists topic_prerequisites_prerequisite_slug_idx on public.topic_prerequisites(prerequisite_topic_slug);

insert into public.topic_prerequisites (topic_slug, prerequisite_topic_slug, sort_order)
values
  ('measurement-energy-and-control', 'systems-modeling-and-boundaries', 1),
  ('analog-circuits-and-signals', 'measurement-energy-and-control', 1),
  ('semiconductors-and-digital-logic', 'analog-circuits-and-signals', 1),
  ('thermal-fluids-and-motion', 'statics-structures-and-materials', 1),
  ('computer-systems-and-networks', 'systems-modeling-and-boundaries', 1),
  ('data-algorithms-and-distributed-architecture', 'computer-systems-and-networks', 1),
  ('power-electronics-and-actuation', 'analog-circuits-and-signals', 1),
  ('power-electronics-and-actuation', 'measurement-energy-and-control', 2),
  ('feedback-control-and-real-time-embedded', 'power-electronics-and-actuation', 1),
  ('feedback-control-and-real-time-embedded', 'measurement-energy-and-control', 2),
  ('modeling-estimation-and-simulation', 'systems-modeling-and-boundaries', 1),
  ('ml-decision-and-autonomy', 'modeling-estimation-and-simulation', 1),
  ('materials-processes-and-dfm', 'statics-structures-and-materials', 1),
  ('metrology-quality-and-prototyping', 'materials-processes-and-dfm', 1),
  ('system-requirements-and-interfaces', 'systems-modeling-and-boundaries', 1),
  ('verification-risk-and-mbse', 'system-requirements-and-interfaces', 1),
  ('verification-risk-and-mbse', 'failure-modes-and-resilience', 2),
  ('requirements-tradeoffs-and-budgets', 'engineering-design-loop', 1),
  ('fault-tree-and-observability', 'failure-modes-and-resilience', 1),
  ('sensor-filtering-and-latency', 'signal-noise-and-snr', 1)
on conflict (topic_slug, prerequisite_topic_slug) do update set
  sort_order = excluded.sort_order;

insert into public.mission_topics (mission_id, topic_slug, sort_order, is_primary)
select
  m.id,
  rollout.topic_slug,
  rollout.sort_order,
  rollout.is_primary
from public.missions m
join public.learning_paths p on p.id = m.path_id
join (
  values
    ('systems-foundations', 1, 3, 'systems-modeling-and-boundaries', 20, false),
    ('systems-foundations', 4, 7, 'signal-noise-and-snr', 20, false),
    ('systems-foundations', 8, 10, 'engineering-design-loop', 20, false),
    ('electronics-basics', 1, 4, 'measurement-energy-and-control', 20, false),
    ('electronics-basics', 5, 10, 'analog-circuits-and-signals', 20, false),
    ('mechanical-thinking', 1, 4, 'systems-modeling-and-boundaries', 20, false),
    ('mechanical-thinking', 5, 10, 'materials-processes-and-dfm', 20, false),
    ('software-systems', 1, 4, 'systems-modeling-and-boundaries', 20, false),
    ('software-systems', 5, 10, 'modeling-estimation-and-simulation', 20, false),
    ('energy-control', 1, 4, 'measurement-energy-and-control', 20, false),
    ('energy-control', 5, 10, 'system-requirements-and-interfaces', 20, false),
    ('ai-simulation', 1, 4, 'computer-systems-and-networks', 20, false),
    ('ai-simulation', 5, 10, 'system-requirements-and-interfaces', 20, false),
    ('materials-fabrication', 1, 4, 'statics-structures-and-materials', 20, false),
    ('materials-fabrication', 5, 10, 'system-requirements-and-interfaces', 20, false),
    ('systems-architecture', 1, 4, 'requirements-tradeoffs-and-budgets', 20, false),
    ('systems-architecture', 5, 10, 'fault-tree-and-observability', 20, false)
) as rollout(path_slug, from_order, to_order, topic_slug, sort_order, is_primary)
  on p.slug = rollout.path_slug
 and m.order_index between rollout.from_order and rollout.to_order
on conflict (mission_id, topic_slug) do update set
  sort_order = excluded.sort_order,
  is_primary = excluded.is_primary;
