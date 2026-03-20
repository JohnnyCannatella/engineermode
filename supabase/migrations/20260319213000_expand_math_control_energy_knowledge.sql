insert into public.topics (
  slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals
)
values (
  'engineering-math-calculus-and-linear-algebra',
  'Matematica per Ingegneri: Calcolo e Algebra Lineare',
  'Derivate, integrali, vettori, matrici e trasformazioni come strumenti pratici per modellare sistemi reali.',
  'deep',
  20,
  'La matematica utile per un engineer non è una collezione di esercizi, ma un linguaggio per descrivere variazione, accumulo, direzione, dipendenze e vincoli. Calcolo differenziale e algebra lineare tornano ovunque: controllo, segnali, simulazione, robotica, power electronics e machine learning.' ,
  array[
    'La derivata misura come un sistema cambia, non solo una pendenza astratta.',
    'L integrale accumula effetti e grandezze nel tempo o nello spazio.',
    'Vettori e matrici descrivono sistemi multivariabili molto meglio di formule scalarizzate.'
  ],
  '[
    {"title":"Perche serve davvero","content":"Appena studi dinamica, controlli o sistemi con più variabili, lo scalare non basta più. L algebra lineare ti permette di vedere struttura, accoppiamento e trasformazioni. Il calcolo ti dà invece il linguaggio della variazione e dell accumulo."},
    {"title":"Uso pratico","content":"Non ti serve ricordare tutto a memoria. Ti serve riconoscere quando un problema richiede ragionamento su derivata, su integrale o su uno spazio vettoriale. Questo cambia subito il modo in cui leggi modelli e risultati."}
  ]'::jsonb,
  '[
    {"label":"Derivata","expression":"dx/dt","note":"Misura la velocità di variazione di uno stato o di una grandezza."},
    {"label":"Sistema lineare","expression":"x_dot = A x + B u","note":"Forma compatta per descrivere dinamica multivariabile."}
  ]'::jsonb,
  '[
    {"title":"MIT OpenCourseWare - Linear Algebra","url":"https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/","type":"video","source":"MIT OpenCourseWare"},
    {"title":"MIT OpenCourseWare - Single Variable Calculus","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"state-machine","title":"Stato e trasformazione","caption":"Molti sistemi diventano leggibili quando li esprimi come stato, ingresso e trasformazione."}
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
  'probability-noise-and-uncertainty',
  'Probabilità, Rumore e Incertezza',
  'Per misurare, stimare e decidere bene serve ragionare su variabilità, distribuzioni ed errore, non solo su valori nominali.',
  'deep',
  18,
  'Ogni sistema reale vive sotto incertezza: sensori rumorosi, componenti variabili, modelli incompleti, eventi rari e dati parziali. Probabilità e statistica non servono solo per il ML: servono per capire rischio, fiducia, rumore, affidabilità e qualità di una decisione tecnica.' ,
  array[
    'Il valore medio da solo non basta a descrivere un sistema.',
    'Varianza e distribuzione cambiano il modo in cui interpreti una misura.',
    'Stimare sotto incertezza è una competenza centrale in controllo, sensing e AI.'
  ],
  '[
    {"title":"Misurare con giudizio","content":"Una misura non è solo un numero: è un numero con dispersione, bias, rumore e contesto. Se questi aspetti non sono chiari, il sistema decide male anche con sensori apparentemente corretti."},
    {"title":"Decisioni robuste","content":"Una buona architettura non cerca solo il caso medio. Deve sapere cosa succede quando il dato è sporco, il sensore degrada o il mondo esce dalla distribuzione attesa."}
  ]'::jsonb,
  '[
    {"label":"Varianza","expression":"sigma^2 = E[(x - mu)^2]","note":"Misura quanto un insieme di dati si disperde attorno al valore medio."}
  ]'::jsonb,
  '[
    {"title":"Khan Academy - Probability and Statistics","url":"https://www.khanacademy.org/math/statistics-probability","type":"article","source":"Khan Academy"}
  ]'::jsonb,
  '[
    {"kind":"signal-wave","title":"Rumore e dispersione","caption":"Il dato utile va sempre separato dalla variabilità che può ingannare il sistema."}
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
  'signals-systems-and-transforms',
  'Segnali, Sistemi e Trasformate',
  'Tempo, frequenza, filtri, convoluzione e risposta del sistema come base trasversale per elettronica, controllo e AI fisica.',
  'architect',
  21,
  'Segnali e sistemi sono uno dei ponti più forti tra discipline. Una vibrazione meccanica, una tensione analogica, una misura di corrente, una rete di comunicazione o una pipeline di stima possono essere letti come segnali che attraversano sistemi con memoria, guadagno, rumore e risposta in frequenza.' ,
  array[
    'Un sistema modifica i segnali secondo una propria dinamica.',
    'Tempo e frequenza sono viste complementari, non alternative.',
    'Convoluzione, filtraggio e risposta in frequenza compaiono ovunque, non solo in elettronica.'
  ],
  '[
    {"title":"Perche è così centrale","content":"Capire segnali e sistemi migliora direttamente la tua capacità di leggere sensori, controlli, filtri, fenomeni oscillatori e qualità del dato. È una lingua comune tra elettronica, meccanica e software."},
    {"title":"Dove entra la trasformata","content":"Guardare un fenomeno in frequenza rivela cose che nel tempo sembrano confuse: risonanze, bande utili, rumore ad alta frequenza, ritardi e guadagni selettivi."}
  ]'::jsonb,
  '[
    {"label":"Convoluzione","expression":"y(t) = x(t) * h(t)","note":"L output dipende da come l ingresso attraversa la dinamica del sistema."}
  ]'::jsonb,
  '[
    {"title":"MIT OCW - Signals and Systems","url":"https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/","type":"video","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"signal-wave","title":"Segnale e sistema","caption":"Un sistema filtra, ritarda o amplifica componenti diverse dello stesso segnale."}
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
  'differential-equations-and-state-space',
  'Equazioni Differenziali e State-Space',
  'La dinamica seria dei sistemi si esprime con stati, equazioni e modelli che evolvono nel tempo.',
  'architect',
  22,
  'Quando un sistema ha memoria, inerzia, accumulo o accoppiamenti, la descrizione più naturale diventa differenziale. Lo state-space porta questa intuizione in forma moderna: descrivere il sistema attraverso stati interni, ingressi, uscite e matrici di dinamica.' ,
  array[
    'Molti fenomeni ingegneristici non sono statici ma evolutivi.',
    'Lo stato cattura l informazione minima necessaria per prevedere il futuro del sistema.',
    'Lo state-space è il linguaggio naturale di controllo moderno, osservatori e simulazione.'
  ],
  '[
    {"title":"Dinamica come memoria","content":"Un sistema dinamico non reagisce solo all ingresso attuale ma anche a ciò che è già successo. Per questo servono variabili di stato, non solo input e output istantanei."},
    {"title":"Perché è utile anche fuori dal controllo","content":"Lo state-space aiuta a leggere reti, strutture, sistemi energetici, filtri e modelli di stima. È una struttura mentale prima ancora che una notazione."}
  ]'::jsonb,
  '[
    {"label":"Forma di stato","expression":"x_dot = A x + B u,  y = C x + D u","note":"Schema base per rappresentare sistemi lineari multivariabili."}
  ]'::jsonb,
  '[
    {"title":"MIT OCW - Dynamic Systems and Control","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"state-machine","title":"Stati e transizioni continue","caption":"Lo state-space rende esplicito come il sistema evolve e come ingressi e uscite si collegano."}
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
  'modern-control-observability-and-optimization',
  'Controllo Moderno, Osservabilità e Ottimizzazione',
  'Oltre il PID: controllo in stato, osservatori, stabilità, vincoli e decisione ottima.',
  'architect',
  22,
  'Il PID è solo l inizio. Quando il sistema diventa multivariabile, vincolato o parzialmente osservabile, entrano in gioco controlli in stato, osservatori, stabilità interna, controllabilità, osservabilità e metodi di ottimizzazione. Questa è la zona in cui il controllo smette di essere tuning empirico e diventa vera architettura.' ,
  array[
    'Controllare bene non significa solo ridurre errore, ma farlo con vincoli e stabilità.',
    'Osservabilità e controllabilità dicono cosa puoi davvero inferire o governare.',
    'Ottimizzare significa scegliere comportamento, costo e margine, non solo risposta rapida.'
  ],
  '[
    {"title":"Perche serve andare oltre il PID","content":"Appena hai più stati, più attuatori o vincoli forti, il PID da solo non basta a raccontare il problema. Il controllo moderno fornisce strumenti per progettare in modo più sistemico."},
    {"title":"Osservatore e decisione ottima","content":"Molti sistemi devono stimare stati interni e poi scegliere un azione che minimizzi un costo. Qui controllo, stima e ottimizzazione si incontrano davvero."}
  ]'::jsonb,
  '[
    {"label":"Costo quadratico","expression":"J = integral (x^T Q x + u^T R u) dt","note":"Forma tipica per esprimere compromesso tra errore di stato e sforzo di controllo."}
  ]'::jsonb,
  '[
    {"title":"MIT OCW - Control Systems","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"feedback-loop","title":"Loop moderno","caption":"Nel controllo moderno feedback, stato stimato e costo convivono nella stessa architettura decisionale."}
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
  'electrochemistry-batteries-and-degradation',
  'Elettrochimica, Batterie e Degrado',
  'Capire davvero accumulo energetico, limiti di cella, sicurezza, ageing e progettazione di sistemi a batteria.',
  'architect',
  20,
  'Le batterie non sono solo serbatoi di energia. Sono sistemi elettrochimici con limiti di corrente, temperatura, sicurezza, vita utile, resistenza interna e degrado. Per costruire sistemi mobili seri devi capire come una batteria si comporta sotto carico, nel tempo e in condizioni reali.' ,
  array[
    'Capacità nominale e comportamento reale sotto carico non coincidono sempre.',
    'Temperatura, corrente e profondità di scarica cambiano vita utile e sicurezza.',
    'La batteria è parte attiva dell architettura energetica, non un blocco passivo.'
  ],
  '[
    {"title":"Batteria come sistema vivo","content":"C-rate, resistenza interna, riscaldamento, stato di carica e stato di salute cambiano prestazioni e affidabilità. Senza questa visione, il sistema energetico viene spesso sovrasemplificato."},
    {"title":"Degrado e safety","content":"Ageing, thermal runaway, bilanciamento e gestione intelligente sono fondamentali. La batteria è insieme risorsa energetica e vincolo di rischio."}
  ]'::jsonb,
  '[
    {"label":"Energia nominale","expression":"E approx V_nom * Ah","note":"Stima utile, ma la prestazione reale dipende da corrente, temperatura e degradazione."}
  ]'::jsonb,
  '[
    {"title":"Battery University","url":"https://batteryuniversity.com/","type":"article","source":"Battery University"}
  ]'::jsonb,
  '[
    {"kind":"trade-study","title":"Batteria come tradeoff","caption":"Energia, potenza, vita utile, massa e sicurezza vanno bilanciati come un unico problema."}
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
  'communication-information-and-encoding',
  'Comunicazione, Informazione e Codifica',
  'Dati, capacità di canale, ridondanza e robustezza della comunicazione nei sistemi digitali e cyber-fisici.',
  'deep',
  18,
  'Ogni sistema distribuito o embedded serio comunica sotto vincoli di rumore, banda, latenza e errore. Capire informazione, codifica, ridondanza e qualità del canale aiuta a progettare sistemi che non solo parlano, ma si capiscono in modo affidabile.' ,
  array[
    'Comunicare bene significa difendere informazione contro rumore e vincoli di canale.',
    'Ridondanza e codifica hanno un costo, ma rendono il sistema più robusto.',
    'Banda, latenza e affidabilità sono sempre in tensione.'
  ],
  '[
    {"title":"Dal bit al sistema","content":"Bus interni, reti, telemetria e protocolli vivono tutti nello stesso spazio di problemi: quanto informazione passa, con che affidabilità, a quale costo temporale ed energetico."},
    {"title":"Perché serve anche fuori dalle reti","content":"Controllo distribuito, robotica, diagnostica remota e sistemi embedded dipendono tutti da comunicazioni che reggano errori, ritardi e perdita di pacchetti."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT OCW - Information and Entropy","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"osi-stack","title":"Comunicazione robusta","caption":"Ogni strato contribuisce a come l informazione viene persa, difesa o ritardata."}
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
  ('probability-noise-and-uncertainty', 'dimensional-analysis-and-estimation', 1),
  ('signals-systems-and-transforms', 'engineering-math-calculus-and-linear-algebra', 1),
  ('signals-systems-and-transforms', 'waves-resonance-and-frequency-response', 2),
  ('differential-equations-and-state-space', 'engineering-math-calculus-and-linear-algebra', 1),
  ('differential-equations-and-state-space', 'classical-mechanics-and-dynamics', 2),
  ('modern-control-observability-and-optimization', 'differential-equations-and-state-space', 1),
  ('modern-control-observability-and-optimization', 'probability-noise-and-uncertainty', 2),
  ('modern-control-observability-and-optimization', 'signals-systems-and-transforms', 3),
  ('electrochemistry-batteries-and-degradation', 'electromagnetism-and-fields', 1),
  ('electrochemistry-batteries-and-degradation', 'power-electronics-and-switching-physics', 2),
  ('communication-information-and-encoding', 'probability-noise-and-uncertainty', 1),
  ('communication-information-and-encoding', 'computer-systems-and-networks', 2)
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
    ('systems-foundations', 1, 4, 'engineering-math-calculus-and-linear-algebra', 40, false),
    ('systems-foundations', 5, 10, 'probability-noise-and-uncertainty', 40, false),
    ('software-systems', 1, 4, 'communication-information-and-encoding', 40, false),
    ('software-systems', 5, 10, 'engineering-math-calculus-and-linear-algebra', 40, false),
    ('electronics-basics', 1, 5, 'signals-systems-and-transforms', 40, false),
    ('electronics-basics', 6, 10, 'communication-information-and-encoding', 40, false),
    ('mechanical-thinking', 1, 5, 'engineering-math-calculus-and-linear-algebra', 40, false),
    ('mechanical-thinking', 6, 10, 'differential-equations-and-state-space', 40, false),
    ('energy-control', 1, 4, 'electrochemistry-batteries-and-degradation', 40, false),
    ('energy-control', 5, 10, 'modern-control-observability-and-optimization', 40, false),
    ('ai-simulation', 1, 4, 'probability-noise-and-uncertainty', 40, false),
    ('ai-simulation', 5, 10, 'modern-control-observability-and-optimization', 40, false),
    ('materials-fabrication', 1, 5, 'engineering-math-calculus-and-linear-algebra', 40, false),
    ('systems-architecture', 1, 5, 'communication-information-and-encoding', 40, false),
    ('systems-architecture', 6, 10, 'modern-control-observability-and-optimization', 40, false)
) as rollout(path_slug, from_order, to_order, topic_slug, sort_order, is_primary)
  on p.slug = rollout.path_slug
 and m.order_index between rollout.from_order and rollout.to_order
on conflict (mission_id, topic_slug) do update set
  sort_order = excluded.sort_order,
  is_primary = excluded.is_primary;
