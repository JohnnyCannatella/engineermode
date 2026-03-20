insert into public.topics (
  slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals
)
values (
  'robot-kinematics-and-manipulation',
  'Robotica: Cinematica, Workspace e Manipolazione',
  'Dal giunto al task-space: come un robot si muove, raggiunge, orienta e manipola il mondo.',
  'architect',
  22,
  'La robotica inizia molto prima del controllo avanzato: inizia da come una macchina può fisicamente muoversi e raggiungere il mondo. Cinematica diretta e inversa, workspace, singularità e gradi di libertà spiegano cosa un robot può fare prima ancora di chiedergli di farlo bene.' ,
  array[
    'La geometria del robot decide possibilità e limiti della manipolazione.',
    'Task-space e joint-space sono due viste complementari dello stesso problema.',
    'Singolarità e workspace non sono dettagli matematici: sono vincoli operativi reali.'
  ],
  '[
    {"title":"Perché serve davvero","content":"Esoscheletri, bracci, piattaforme mobili con end-effector e sistemi di actuation complessi richiedono una lettura cinematica chiara. Senza questa base, il controllo compensa male una geometria non capita."},
    {"title":"Manipolare è più difficile che muoversi","content":"Raggiungere una posizione non basta. Devi anche controllare orientamento, contatto, margine articolare e comportamento vicino alle singularità."}
  ]'::jsonb,
  '[
    {"label":"Mappa cinematica","expression":"x = f(q)","note":"Il task-space dipende dallo stato articolare e dalla geometria del robot."}
  ]'::jsonb,
  '[
    {"title":"MIT OCW - Robotics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"state-machine","title":"Joint-space vs task-space","caption":"Muoversi bene significa collegare stato articolare, vincoli geometrici e obiettivo nello spazio operativo."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title,
  summary = excluded.summary,
  difficulty_level = excluded.difficulty_level,
  estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview,
  key_takeaways = excluded.key_takeaways,
  study_blocks = excluded.study_blocks,
  formulas = excluded.formulas,
  "references" = excluded."references",
  visuals = excluded.visuals;

insert into public.topics (
  slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals
)
values (
  'robot-perception-planning-and-slam',
  'Robotica: Percezione, Planning e SLAM',
  'Come un sistema autonomo costruisce una mappa, localizza sé stesso e pianifica azioni nel mondo incerto.',
  'architect',
  23,
  'Un robot utile deve sapere dove si trova, cosa vede, quanto si fida dei propri sensori e quale traiettoria conviene seguire. Percezione, SLAM e planning stanno al cuore dell autonomia credibile e costringono a integrare stima, incertezza, geometria e decisione.' ,
  array[
    'Localizzazione e mappa sono problemi accoppiati, non separati.',
    'La pianificazione lavora sempre sotto vincoli e incertezza.',
    'Percezione robusta significa fondere geometria, probabilità e decisione.'
  ],
  '[
    {"title":"SLAM come idea architetturale","content":"Simultaneous Localization and Mapping non è solo un algoritmo: è un modo di ragionare su mondo ignoto, misura rumorosa e coerenza del modello interno."},
    {"title":"Planning reale","content":"Pianificare per un robot significa scegliere traiettorie e azioni compatibili con dinamica, ostacoli, tempi e margini di sicurezza. Non è solo trovare la strada più corta."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT Underactuated Robotics","url":"https://underactuated.mit.edu/","type":"article","source":"MIT"}
  ]'::jsonb,
  '[
    {"kind":"trade-study","title":"Percezione e planning","caption":"Autonomia robusta nasce dal compromesso tra qualità della stima, costo computazionale e sicurezza della decisione."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title,
  summary = excluded.summary,
  difficulty_level = excluded.difficulty_level,
  estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview,
  key_takeaways = excluded.key_takeaways,
  study_blocks = excluded.study_blocks,
  formulas = excluded.formulas,
  "references" = excluded."references",
  visuals = excluded.visuals;

insert into public.topics (
  slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals
)
values (
  'robot-locomotion-balance-and-contact',
  'Robotica: Locomozione, Equilibrio e Contatto',
  'Camminare, atterrare, spingere e restare stabili significa governare il contatto con il mondo.',
  'architect',
  22,
  'Quando un sistema mobile interagisce con il terreno o con un oggetto, il problema cambia natura: entrano in gioco equilibrio, contatto, attrito, impulsi, compliance e strategie di controllo in presenza di vincoli intermittenti.' ,
  array[
    'La locomozione è un problema di contatto e stabilità, non solo di motori.',
    'Attrito, impulso e compliance cambiano completamente il comportamento del sistema.',
    'Bilanciare e manipolare richiedono spesso la stessa mentalità dinamica.'
  ],
  '[
    {"title":"Perche il contatto è difficile","content":"Il contatto introduce discontinuità, shock, perdita di aderenza e regioni di stabilità limitate. Questo rende il sistema molto più sensibile di quanto sembri in un modello libero."},
    {"title":"Dove entra davvero","content":"Droni in atterraggio, esoscheletri, arti robotici, rover e manipolatori vivono tutti nel regime in cui il contatto col mondo decide stabilità e prestazione."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT Underactuated Robotics - Legged Locomotion","url":"https://underactuated.mit.edu/","type":"article","source":"MIT"}
  ]'::jsonb,
  '[
    {"kind":"free-body","title":"Contatto e stabilità","caption":"Quando il sistema tocca il mondo, forze, attriti e vincoli diventano il problema centrale."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title,
  summary = excluded.summary,
  difficulty_level = excluded.difficulty_level,
  estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview,
  key_takeaways = excluded.key_takeaways,
  study_blocks = excluded.study_blocks,
  formulas = excluded.formulas,
  "references" = excluded."references",
  visuals = excluded.visuals;

insert into public.topics (
  slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals
)
values (
  'optics-photonics-and-imaging-systems',
  'Scienze Dure: Ottica, Fotonica e Imaging',
  'Luce, lenti, sensori, risoluzione e sistemi di imaging come base di visione, sensing e misura avanzata.',
  'architect',
  20,
  'Molti sistemi intelligenti vedono, misurano o comunicano attraverso la luce. Ottica e fotonica spiegano come l informazione si propaga, si focalizza, si distorce, si perde e viene acquisita da un sensore. Questo topic è il ponte tra fisica della luce e sistemi di visione reali.' ,
  array[
    'Vedere bene dipende da ottica e sensore insieme, non solo da software.',
    'Risoluzione, rumore e illuminazione cambiano la qualità della decisione visiva.',
    'Ottica e imaging sono fondamentali per percezione, misura e interfacce avanzate.'
  ],
  '[
    {"title":"Perché serve davvero","content":"Visione artificiale, lidar, sensori ottici, ispezione, targeting e imaging scientifico dipendono tutti da come la luce entra, si focalizza e viene convertita in dato."},
    {"title":"Dal fotone al sistema","content":"Luce, ottica, sensore, rumore, esposizione e algoritmo sono parte della stessa pipeline. Se tratti bene solo l algoritmo, perdi metà del problema."}
  ]'::jsonb,
  '[
    {"label":"Risoluzione angolare semplificata","expression":"theta approx 1.22 lambda / D","note":"Forma intuitiva per capire il limite tra apertura ottica e dettaglio osservabile."}
  ]'::jsonb,
  '[
    {"title":"MIT OCW - Optics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"signal-wave","title":"Luce come segnale","caption":"Un sistema ottico acquisisce, distorce e campiona informazione luminosa prima che il software la interpreti."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title,
  summary = excluded.summary,
  difficulty_level = excluded.difficulty_level,
  estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview,
  key_takeaways = excluded.key_takeaways,
  study_blocks = excluded.study_blocks,
  formulas = excluded.formulas,
  "references" = excluded."references",
  visuals = excluded.visuals;

insert into public.topics (
  slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals
)
values (
  'modern-physics-quantum-and-semiconductor-foundations',
  'Scienze Dure: Fisica Moderna, Quantistica e Fondamenti dei Semiconduttori',
  'Quando la fisica classica non basta più: quantizzazione, livelli energetici e radici profonde dei dispositivi moderni.',
  'architect',
  21,
  'Laser, semiconduttori, sensori avanzati, materiali elettronici e dispositivi ad alte prestazioni poggiano su concetti di fisica moderna. Qui non serve fare fisica teorica pura, ma ottenere l intuizione minima necessaria per non trattare il mondo dei dispositivi avanzati come magia.' ,
  array[
    'La fisica moderna spiega molti limiti e potenzialità dei dispositivi contemporanei.',
    'Livelli energetici, quantizzazione e stati elettronici hanno effetti progettuali reali.',
    'Capire un minimo di quantistica applicata aiuta a leggere meglio semiconduttori, fotonica e materiali.'
  ],
  '[
    {"title":"Perche entra nel prodotto","content":"Non serve diventare un fisico teorico, ma per progettare bene sensori, chip, dispositivi di potenza e sistemi fotonici è utile sapere perché il dispositivo funziona e dove fallisce."},
    {"title":"Dove aiuta davvero","content":"Semiconduttori, imaging, materiali avanzati, batterie e tecnologie quantistiche future diventano meno opachi quando riconosci il livello fisico sottostante."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT OCW - Quantum Physics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"mosfet-symbol","title":"Dispositivo moderno","caption":"Dietro il simbolo c è una fisica di stati energetici, materiali e trasporto non classico."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title,
  summary = excluded.summary,
  difficulty_level = excluded.difficulty_level,
  estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview,
  key_takeaways = excluded.key_takeaways,
  study_blocks = excluded.study_blocks,
  formulas = excluded.formulas,
  "references" = excluded."references",
  visuals = excluded.visuals;

insert into public.topics (
  slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals
)
values (
  'chemistry-foundations-reactions-and-material-processes',
  'Scienze Dure: Chimica Generale, Reazioni e Processi dei Materiali',
  'Legami, reattività, equilibrio e trasformazioni come base per materiali, energia e fabbricazione.',
  'deep',
  19,
  'Molti fenomeni chiave dell ingegneria sono chimici prima che meccanici o elettronici: ossidazione, polimerizzazione, elettrochimica, trattamenti superficiali, catalisi, combustione e stabilità dei materiali. Questo topic costruisce una base chimica generale orientata al design di sistemi reali.' ,
  array[
    'Le trasformazioni chimiche influenzano direttamente materiali, energia e degrado.',
    'Equilibrio e cinetica spiegano perché una reazione è possibile, utile o problematica.',
    'Una base chimica migliora la lettura di batterie, corrosione, coating e processi produttivi.'
  ],
  '[
    {"title":"Perché serve a un engineer","content":"La chimica entra in batterie, materiali compositi, adesivi, rivestimenti, combustibili, raffreddamento, produzione e affidabilità. Trattarla come ambito separato impoverisce il progetto."},
    {"title":"Cosa portarti a casa","content":"Basta una base solida su struttura della materia, legami, reazioni, equilibrio e processi per leggere molto meglio tanti problemi di prodotto."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"Khan Academy - Chemistry","url":"https://www.khanacademy.org/science/chemistry","type":"article","source":"Khan Academy"}
  ]'::jsonb,
  '[
    {"kind":"trade-study","title":"Processo e reazione","caption":"Le trasformazioni chimiche cambiano qualità, durata e producibilità dei materiali reali."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title,
  summary = excluded.summary,
  difficulty_level = excluded.difficulty_level,
  estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview,
  key_takeaways = excluded.key_takeaways,
  study_blocks = excluded.study_blocks,
  formulas = excluded.formulas,
  "references" = excluded."references",
  visuals = excluded.visuals;

insert into public.topics (
  slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals
)
values (
  'plasma-high-energy-and-extreme-systems',
  'Scienze Dure: Plasma, Alta Energia e Sistemi Estremi',
  'Una finestra sui regimi in cui materia, campi ed energia si comportano fuori dall ordinario.',
  'architect',
  20,
  'Quando parli di archi, propulsione avanzata, ambienti estremi, scariche, materiali sotto forte stress energetico o sistemi ad altissima densità di potenza, entri in regimi dove plasma e fisica ad alta energia diventano concetti utili. Non è fantascienza: è uno strato avanzato di intuizione per sistemi estremi.' ,
  array[
    'I regimi estremi richiedono modelli diversi da quelli del caso nominale.',
    'Campo, temperatura e densità energetica cambiano radicalmente il comportamento della materia.',
    'Una base su plasma e sistemi estremi aiuta a leggere tecnologie fuori scala senza ridurle a marketing.'
  ],
  '[
    {"title":"Perché può servire","content":"Non tutti i prodotti arrivano qui, ma chi vuole pensare davvero in grande su energia, propulsione e sistemi fuori scala beneficia di una lente sui regimi estremi."},
    {"title":"A cosa stare attenti","content":"La lezione utile non è memorizzare fenomeni rari, ma imparare che molti modelli nominali collassano quando sali in densità di potenza, temperatura o campo."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT Plasma Science and Fusion Center","url":"https://www.psfc.mit.edu/","type":"article","source":"MIT"}
  ]'::jsonb,
  '[
    {"kind":"complexity-scale","title":"Regimi estremi","caption":"Quando l energia per unità di volume cresce, il sistema entra in domini fisici qualitativamente diversi."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title,
  summary = excluded.summary,
  difficulty_level = excluded.difficulty_level,
  estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview,
  key_takeaways = excluded.key_takeaways,
  study_blocks = excluded.study_blocks,
  formulas = excluded.formulas,
  "references" = excluded."references",
  visuals = excluded.visuals;

insert into public.topic_prerequisites (topic_slug, prerequisite_topic_slug, sort_order)
values
  ('robot-kinematics-and-manipulation', 'classical-mechanics-and-dynamics', 1),
  ('robot-kinematics-and-manipulation', 'engineering-math-calculus-and-linear-algebra', 2),
  ('robot-perception-planning-and-slam', 'probability-noise-and-uncertainty', 1),
  ('robot-perception-planning-and-slam', 'modeling-estimation-and-simulation', 2),
  ('robot-locomotion-balance-and-contact', 'robot-kinematics-and-manipulation', 1),
  ('robot-locomotion-balance-and-contact', 'powertrain-locomotion-and-mobility-systems', 2),
  ('optics-photonics-and-imaging-systems', 'electromagnetism-and-fields', 1),
  ('modern-physics-quantum-and-semiconductor-foundations', 'solid-state-and-device-physics', 1),
  ('modern-physics-quantum-and-semiconductor-foundations', 'electromagnetism-and-fields', 2),
  ('chemistry-foundations-reactions-and-material-processes', 'materials-chemistry-corrosion-and-failure', 1),
  ('plasma-high-energy-and-extreme-systems', 'modern-physics-quantum-and-semiconductor-foundations', 1),
  ('plasma-high-energy-and-extreme-systems', 'power-electronics-and-switching-physics', 2)
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
    ('systems-foundations', 1, 4, 'robot-kinematics-and-manipulation', 60, false),
    ('systems-foundations', 5, 10, 'optics-photonics-and-imaging-systems', 60, false),
    ('software-systems', 1, 5, 'robot-perception-planning-and-slam', 60, false),
    ('software-systems', 6, 10, 'optics-photonics-and-imaging-systems', 60, false),
    ('electronics-basics', 1, 5, 'modern-physics-quantum-and-semiconductor-foundations', 60, false),
    ('electronics-basics', 6, 10, 'optics-photonics-and-imaging-systems', 60, false),
    ('mechanical-thinking', 1, 5, 'robot-locomotion-balance-and-contact', 60, false),
    ('mechanical-thinking', 6, 10, 'chemistry-foundations-reactions-and-material-processes', 60, false),
    ('energy-control', 1, 4, 'robot-kinematics-and-manipulation', 60, false),
    ('energy-control', 5, 10, 'robot-locomotion-balance-and-contact', 60, false),
    ('ai-simulation', 1, 5, 'robot-perception-planning-and-slam', 60, false),
    ('ai-simulation', 6, 10, 'optics-photonics-and-imaging-systems', 60, false),
    ('materials-fabrication', 1, 5, 'chemistry-foundations-reactions-and-material-processes', 60, false),
    ('materials-fabrication', 6, 10, 'modern-physics-quantum-and-semiconductor-foundations', 60, false),
    ('systems-architecture', 1, 5, 'robot-perception-planning-and-slam', 60, false),
    ('systems-architecture', 6, 10, 'plasma-high-energy-and-extreme-systems', 60, false)
) as rollout(path_slug, from_order, to_order, topic_slug, sort_order, is_primary)
  on p.slug = rollout.path_slug
 and m.order_index between rollout.from_order and rollout.to_order
on conflict (mission_id, topic_slug) do update set
  sort_order = excluded.sort_order,
  is_primary = excluded.is_primary;
