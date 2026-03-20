insert into public.topics (
  slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals
)
values (
  'dimensional-analysis-and-estimation',
  'Analisi Dimensionale e Stime di Ordine di Grandezza',
  'La fisica utile parte spesso da unità, scala e stime intelligenti prima ancora del modello completo.',
  'deep',
  16,
  'Un engineer forte non parte sempre da una simulazione completa. Spesso parte da un controllo di sanita: dimensioni, ordini di grandezza, rapporti tra grandezze, limiti fisici. L analisi dimensionale ti impedisce di costruire castelli matematici su formule applicate male e ti aiuta a capire rapidamente se un risultato e plausibile.' ,
  array[
    'Le unità sono parte del significato fisico di una formula.',
    'Una buona stima anticipa molti errori di progetto e di interpretazione.',
    'Ordine di grandezza e scaling sono strumenti decisionali, non scorciatoie rozze.'
  ],
  '[
    {"title":"Perche serve davvero","content":"Se una missione parla di potenza, controllo, fluidi o sensori, l analisi dimensionale ti dice subito se la formula che stai usando ha senso e se il risultato e nel range fisicamente credibile."},
    {"title":"Scaling law","content":"Quando raddoppi una lunghezza, una massa, una velocita o una frequenza, non tutto scala allo stesso modo. Pensare in leggi di scala aiuta a evitare errori sistemici in robotica, termica ed elettronica."}
  ]'::jsonb,
  '[
    {"label":"Controllo dimensionale","expression":"[LHS] = [RHS]","note":"Una relazione fisica sensata deve essere dimensionalmente coerente."}
  ]'::jsonb,
  '[
    {"title":"MIT OCW - Dimensional Analysis","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"complexity-scale","title":"Ordine di grandezza","caption":"Prima di rifinire il modello, verifica che la scala del fenomeno abbia senso."}
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
  'classical-mechanics-and-dynamics',
  'Meccanica Classica, Dinamica e Conservazione',
  'Forza, quantità di moto, energia e vincoli come linguaggio universale dei sistemi fisici.',
  'deep',
  18,
  'Dietro ogni macchina, robot o meccanismo c è ancora la fisica classica: forze, momenti, inerzia, lavoro, energia e quantità di moto. Questo topic non serve a fare esercizi scolastici, ma a leggere meglio il comportamento dei sistemi reali: perche accelerano, perche oscillano, dove dissipano e dove accumulano energia.' ,
  array[
    'Forza e accelerazione sono legate, ma sempre dentro un contesto di vincoli e massa.',
    'Energia e quantità di moto aiutano a leggere il sistema su scale diverse.',
    'La dinamica spiega molti failure mode che la sola geometria non mostra.'
  ],
  '[
    {"title":"Lettura dinamica del sistema","content":"Molti problemi apparentemente di controllo o attuazione sono in realtà problemi di inerzia, attrito, leva o energia accumulata. Se non vedi la dinamica, il comportamento resta opaco."},
    {"title":"Conservazione come strumento","content":"Conservazione di energia e quantità di moto non sono solo principi teorici: sono check potenti per capire dove la tua interpretazione del sistema sta perdendo causalità."}
  ]'::jsonb,
  '[
    {"label":"Seconda legge di Newton","expression":"F = m a","note":"Valida localmente, ma sempre dentro un sistema con vincoli, attriti e riferimenti corretti."},
    {"label":"Energia cinetica","expression":"E_k = 1/2 m v^2","note":"La velocità pesa quadraticamente: questo cambia subito il budget energetico e il rischio."}
  ]'::jsonb,
  '[
    {"title":"MIT OCW - Classical Mechanics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"free-body","title":"Forze e vincoli","caption":"La dinamica si capisce quando espliciti correttamente le interazioni meccaniche."}
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
  'electromagnetism-and-fields',
  'Elettromagnetismo e Field Thinking',
  'Dal campo elettrico e magnetico fino alla lettura moderna di sensori, motori, segnali e conversione.',
  'architect',
  19,
  'Molti sistemi elettronici sembrano circuiti astratti finché non ricordi che sotto esistono campi elettrici e magnetici. Capacità, induzione, accoppiamenti, rumore, antenne, motori e sensori magnetici diventano molto più leggibili quando ragioni in termini di campi e non solo di simboli su schema.' ,
  array[
    'Tensione, corrente e campo sono livelli diversi dello stesso fenomeno fisico.',
    'Molti problemi di rumore e accoppiamento nascono da geometria e campi, non da formule isolate.',
    'Motori, induttori e sensori magnetici si capiscono meglio con una visione di field physics.'
  ],
  '[
    {"title":"Perche l elettromagnetismo serve a un builder","content":"Appena lavori con switching, motori, sensori, bus o segnali rapidi, i campi entrano in gioco. Se li ignori, capisci meno rumore, meno EMI e meno comportamento reale."},
    {"title":"Dallo schema alla fisica","content":"Uno schema e una vista logica. Il campo elettromagnetico e la vista fisica sottostante. Le due vanno collegate per progettare davvero bene elettronica e controllo."}
  ]'::jsonb,
  '[
    {"label":"Induttanza","expression":"V = L di/dt","note":"Le variazioni rapide di corrente generano tensioni che impattano controllo, rumore e protezione."}
  ]'::jsonb,
  '[
    {"title":"MIT OCW - Electricity and Magnetism","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"signal-wave","title":"Campi e segnali","caption":"Dietro ogni forma d onda c è una fisica di accumulo, propagazione e accoppiamento."}
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
  'waves-resonance-and-frequency-response',
  'Onde, Risonanza e Risposta in Frequenza',
  'La stessa idea attraversa meccanica, elettronica, controllo e segnali: sistemi che reagiscono in modo diverso a frequenze diverse.',
  'architect',
  18,
  'Molti comportamenti che sembrano strani sono solo fenomeni in frequenza: risonanza, filtraggio, smorzamento, risposta lenta, picchi, aliasing. Questo topic collega meccanica, segnali ed elettronica con un linguaggio unico: frequenza, fase, ampiezza e dinamica.' ,
  array[
    'Risonanza non è un dettaglio: può amplificare o distruggere il comportamento del sistema.',
    'Ogni sistema filtra il mondo in modo proprio.',
    'Capire frequenza e smorzamento migliora sensori, controllo, strutture e alimentazioni.'
  ],
  '[
    {"title":"Una lente unica su molti domini","content":"La stessa struttura concettuale spiega vibrazioni meccaniche, filtri RC, loop di controllo e onde nei segnali. Questo è uno dei veri ponti tra discipline."},
    {"title":"Perche serve davvero","content":"Se progetti un sistema robotico o elettronico, devi sapere quando una frequenza è utile, quando è rumore e quando sta eccitando una modalità pericolosa."}
  ]'::jsonb,
  '[
    {"label":"Frequenza naturale","expression":"omega_n = sqrt(k/m)","note":"In forma semplificata mostra come rigidità e massa fissino la dinamica di base."}
  ]'::jsonb,
  '[
    {"title":"MIT OCW - Signals and Systems","url":"https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/","type":"video","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"signal-wave","title":"Dominio del tempo e della frequenza","caption":"Molti fenomeni diventano leggibili solo quando li guardi come risposta in frequenza."}
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
  'solid-state-and-device-physics',
  'Fisica dei Dispositivi e Stato Solido',
  'Per capire davvero diodi, transistor, sensori e materiali elettronici serve tornare alla fisica del dispositivo.',
  'architect',
  19,
  'La logica digitale e l elettronica moderna poggiano su materiali, portatori di carica, bande di energia, giunzioni e fenomeni di trasporto. Senza almeno un intuizione di device physics, molti componenti restano scatole nere e certi tradeoff sembrano arbitrari.' ,
  array[
    'Diodi e transistor derivano da proprietà fisiche del materiale, non da simboli astratti.',
    'La device physics aiuta a capire limiti, non solo funzionamento nominale.',
    'Sensori, semiconduttori di potenza e logica condividono radici fisiche comuni.'
  ],
  '[
    {"title":"Perche guardare sotto il simbolo","content":"Leakage, breakdown, tempi di commutazione, temperatura e rumore non si capiscono bene senza una base di fisica del dispositivo. Questo migliora sia progetto sia debugging."},
    {"title":"Dal materiale alla funzione","content":"Gap di banda, drogaggio e giunzioni spiegano perche certi dispositivi sono veloci, altri robusti, altri sensibili e altri adatti alla potenza."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT OCW - Solid State Chemistry / Device Physics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"mosfet-symbol","title":"Dal simbolo al dispositivo","caption":"Ogni simbolo elettronico nasconde una fisica di portatori, campi e materiali."}
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
  'analog-instrumentation-and-signal-conditioning',
  'Strumentazione Analogica e Signal Conditioning',
  'Il ponte tra fenomeno fisico e dato digitale: amplificazione, filtraggio, riferimento, rumore e acquisizione.',
  'deep',
  18,
  'Molti sistemi falliscono non perché l algoritmo è sbagliato, ma perché il segnale entra già degradato. Il signal conditioning riguarda proprio quel tratto spesso invisibile: adattare ampiezza, banda, rumore e riferimenti del segnale prima che il sistema decida qualcosa.' ,
  array[
    'Misurare bene spesso vale più che elaborare molto.',
    'Amplificare senza pensare al rumore è un errore classico.',
    'Il front-end analogico è parte dell intelligenza del sistema.'
  ],
  '[
    {"title":"Dal sensore all ADC","content":"Tra il mondo fisico e il software ci sono offset, guadagni, rumore, filtri, riferimenti e dinamica dei componenti. Questa catena decide se il dato sarà utile o fuorviante."},
    {"title":"Perche serve a chi costruisce sistemi","content":"Robotica, wearable, power electronics e device intelligenti dipendono tutti da acquisizione credibile, non solo da ML o controllo sofisticato."}
  ]'::jsonb,
  '[
    {"label":"Filtro RC","expression":"f_c = 1 / (2 pi R C)","note":"Mostra come resistenza e capacità fissino una scala di frequenza rilevante per il segnale."}
  ]'::jsonb,
  '[
    {"title":"National Instruments - Signal Conditioning Fundamentals","url":"https://www.ni.com/","type":"article","source":"National Instruments"}
  ]'::jsonb,
  '[
    {"kind":"circuit-loop","title":"Catena di acquisizione","caption":"Un segnale utile nasce da una catena fisica ben condizionata, non da un solo sensore ideale."}
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
  'power-electronics-and-switching-physics',
  'Elettronica di Potenza e Fisica dello Switching',
  'Conversione, commutazione, perdite e dinamica di dispositivi che muovono davvero energia.',
  'architect',
  20,
  'Quando l elettronica smette di solo informare e inizia a muovere energia, entrano in gioco switching, dissipazione, componenti magnetici, EMI e termica. Questa è la zona dove elettronica, fisica e controllo si incontrano in modo più brutale.' ,
  array[
    'Lo switching efficiente ha sempre un costo in rumore, termica o complessità.',
    'La potenza non si progetta solo in schema: richiede pensiero fisico sul layout e sui transitori.',
    'Motori, bus di potenza e convertitori vanno letti come sistemi elettromagnetici dinamici.'
  ],
  '[
    {"title":"Perdite di conduzione e commutazione","content":"Un dispositivo di potenza non perde solo quando conduce: perde anche quando cambia stato. Questo è centrale per capire efficienza, termica e limiti di frequenza."},
    {"title":"Perche il layout conta","content":"Induttanze parassite, loop di corrente e commutazioni rapide trasformano un convertitore in un problema di campo, EMI e affidabilità, non solo di logica di controllo."}
  ]'::jsonb,
  '[
    {"label":"Potenza dissipata","expression":"P = V I","note":"Nella potenza reale devi poi separare conduzione, switching e perdite distribuite."}
  ]'::jsonb,
  '[
    {"title":"TI Power Electronics Basics","url":"https://www.ti.com/power-management/overview.html","type":"article","source":"Texas Instruments"}
  ]'::jsonb,
  '[
    {"kind":"feedback-loop","title":"Potenza e controllo","caption":"Nel mondo reale la catena di potenza modifica direttamente la qualità del controllo."}
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
  ('classical-mechanics-and-dynamics', 'dimensional-analysis-and-estimation', 1),
  ('electromagnetism-and-fields', 'dimensional-analysis-and-estimation', 1),
  ('waves-resonance-and-frequency-response', 'classical-mechanics-and-dynamics', 1),
  ('waves-resonance-and-frequency-response', 'electromagnetism-and-fields', 2),
  ('analog-instrumentation-and-signal-conditioning', 'electromagnetism-and-fields', 1),
  ('analog-instrumentation-and-signal-conditioning', 'dimensional-analysis-and-estimation', 2),
  ('solid-state-and-device-physics', 'electromagnetism-and-fields', 1),
  ('power-electronics-and-switching-physics', 'solid-state-and-device-physics', 1),
  ('power-electronics-and-switching-physics', 'electromagnetism-and-fields', 2)
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
    ('systems-foundations', 1, 3, 'dimensional-analysis-and-estimation', 30, false),
    ('systems-foundations', 4, 7, 'waves-resonance-and-frequency-response', 30, false),
    ('mechanical-thinking', 1, 6, 'classical-mechanics-and-dynamics', 30, false),
    ('mechanical-thinking', 7, 10, 'waves-resonance-and-frequency-response', 30, false),
    ('electronics-basics', 1, 4, 'electromagnetism-and-fields', 30, false),
    ('electronics-basics', 5, 7, 'analog-instrumentation-and-signal-conditioning', 30, false),
    ('electronics-basics', 8, 10, 'solid-state-and-device-physics', 30, false),
    ('energy-control', 1, 4, 'power-electronics-and-switching-physics', 30, false),
    ('energy-control', 5, 10, 'waves-resonance-and-frequency-response', 30, false),
    ('ai-simulation', 1, 3, 'dimensional-analysis-and-estimation', 30, false),
    ('materials-fabrication', 1, 5, 'classical-mechanics-and-dynamics', 30, false),
    ('materials-fabrication', 6, 10, 'solid-state-and-device-physics', 30, false),
    ('systems-architecture', 1, 5, 'dimensional-analysis-and-estimation', 30, false),
    ('systems-architecture', 6, 10, 'electromagnetism-and-fields', 30, false)
) as rollout(path_slug, from_order, to_order, topic_slug, sort_order, is_primary)
  on p.slug = rollout.path_slug
 and m.order_index between rollout.from_order and rollout.to_order
on conflict (mission_id, topic_slug) do update set
  sort_order = excluded.sort_order,
  is_primary = excluded.is_primary;
