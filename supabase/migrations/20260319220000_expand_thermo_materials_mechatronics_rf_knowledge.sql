insert into public.topics (
  slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals
)
values (
  'thermodynamics-heat-transfer-and-energy-systems',
  'Termodinamica, Trasferimento di Calore e Sistemi Energetici',
  'Temperatura, entropia, conduzione, convezione e bilanci energetici come vincoli reali di ogni macchina seria.',
  'architect',
  22,
  'Ogni sistema reale che muove energia, potenza o materia convive con la termodinamica. Non basta sapere che il calore esiste: devi capire dove nasce, come si propaga, come si accumula e quali limiti impone a prestazione, efficienza, sicurezza e durata. Qui il sistema smette di essere solo geometria o logica e diventa processo fisico.' ,
  array[
    'Il calore non è un effetto collaterale: spesso è il vincolo dominante del progetto.',
    'Bilanci energetici e resistenze termiche rendono leggibili molti failure mode nascosti.',
    'Efficienza, dissipazione e sicurezza termica vanno pensate insieme.'
  ],
  '[
    {"title":"Dove entra davvero","content":"Power electronics, batterie, attuatori, CPU, strutture compatte e sistemi ad alta densità energetica hanno tutti lo stesso problema: trasformano parte della potenza utile in calore che va gestito."},
    {"title":"Perché è centrale in sistemi complessi","content":"La termica collega quasi tutto: rendimento, packaging, materiali, affidabilità, controllo e sicurezza. Una buona intuizione termodinamica migliora l intera architettura."}
  ]'::jsonb,
  '[
    {"label":"Conduzione termica","expression":"q = -k A dT/dx","note":"Mostra come gradiente, materiale e geometria determinino il flusso di calore."}
  ]'::jsonb,
  '[
    {"title":"MIT OCW - Thermodynamics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"complexity-scale","title":"Bilancio energetico","caption":"Quando il sistema scala in potenza, la termica smette di essere un dettaglio e diventa architettura."}
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
  'mass-transfer-fluids-and-propulsion',
  'Trasporto di Massa, Fluidi e Propulsione',
  'Flussi, pressione, portata, perdite e propulsione come linguaggio per sistemi che respirano, raffreddano o si muovono.',
  'architect',
  21,
  'Quando un sistema scambia fluidi o genera spinta, devi ragionare in termini di portata, pressione, perdite, viscosità, inerzia del fluido e accoppiamento con la struttura e il controllo. Dai loop di raffreddamento fino alla propulsione, questa è fisica applicata ad alta conseguenza.' ,
  array[
    'Portata e pressione non sono intercambiabili: descrivono aspetti diversi del sistema.',
    'Le perdite nel fluido cambiano prestazione, controllo e consumo energetico.',
    'La propulsione è sempre un compromesso tra massa, efficienza, spinta e controllabilità.'
  ],
  '[
    {"title":"Fluido come sottosistema attivo","content":"Un circuito fluido o una catena propulsiva non sono solo tubi e pompe: hanno dinamica, ritardo, perdite e failure mode propri. Questo li rende veri sottosistemi architetturali."},
    {"title":"Perché conta per chi costruisce","content":"Robot mobili, sistemi energetici, raffreddamento, aerodinamica e locomozione richiedono tutti una lettura fluido-dinamica almeno a livello ingegneristico."}
  ]'::jsonb,
  '[
    {"label":"Continuità","expression":"Q = A v","note":"Portata volumetrica come prodotto tra area utile e velocità media del fluido."}
  ]'::jsonb,
  '[
    {"title":"MIT OCW - Fluid Mechanics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"trade-study","title":"Propulsione e perdite","caption":"Muovere fluido o generare spinta è sempre un tradeoff tra efficienza, massa, rumore e controllo."}
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
  'materials-chemistry-corrosion-and-failure',
  'Chimica dei Materiali, Corrosione e Failure',
  'Il lato chimico dei materiali reali: degradazione, ambiente, superfici e meccanismi di cedimento.',
  'architect',
  20,
  'Materiali e componenti non falliscono solo per carico meccanico. Falliscono anche per ambiente, ossidazione, corrosione galvanica, creep, diffusione, microstruttura e processi lenti che cambiano il comportamento nel tempo. Senza questa lente chimico-materiale, molti cedimenti sembrano inspiegabili.' ,
  array[
    'Il materiale vive dentro un ambiente e reagisce ad esso.',
    'Corrosione e degradazione sono spesso failure mode sistemici, non localizzati.',
    'La scelta di materiale e trattamento superficiale è una scelta di affidabilità, non solo di prestazione nominale.'
  ],
  '[
    {"title":"Perche la chimica conta","content":"Batterie, strutture leggere, elettronica, giunzioni metalliche e parti esposte lavorano tutti dentro ambienti termici, chimici e meccanici che li degradano nel tempo."},
    {"title":"Failure lenti ma letali","content":"Molti problemi seri non esplodono subito: crescono lentamente fino al punto di rottura. Corrosione, fatica assistita dall ambiente e invecchiamento dei materiali vanno previsti prima."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"NACE / AMPP Corrosion Basics","url":"https://www.ampp.org/","type":"article","source":"AMPP"}
  ]'::jsonb,
  '[
    {"kind":"trade-study","title":"Ambiente e materiale","caption":"Prestazione nominale e sopravvivenza in ambiente reale spesso non coincidono."}
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
  'mechatronics-integration-and-cyber-physical-design',
  'Meccatronica, Integrazione e Cyber-Physical Design',
  'Dove meccanica, elettronica, software e controllo smettono di essere silos e diventano un solo sistema.',
  'architect',
  22,
  'La meccatronica non è una somma di discipline: è integrazione intenzionale tra struttura, sensing, attuazione, potenza, logica e verifica. È il terreno più vicino a sistemi in stile Tony Stark, perché costringe a ragionare in co-progettazione continua.' ,
  array[
    'Le scelte di una disciplina cambiano i vincoli delle altre.',
    'L integrazione va progettata prima di essere testata.',
    'Un sistema cyber-fisico credibile nasce da architettura, non da incollaggio finale.'
  ],
  '[
    {"title":"Co-progettazione vera","content":"Se cambi un attuatore, cambiano massa, potenza, controllo, termica e meccanica. Se cambi un sensore, cambia anche l osservabilità e quindi l intero stack decisionale."},
    {"title":"Perche serve come mentalità","content":"Chi vuole costruire sistemi avanzati deve imparare a vedere dipendenze trasversali e a scegliere soluzioni che reggano l integrazione, non solo il sottosistema."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT OCW - Mechatronic Systems","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"interface-contract","title":"Sistema cyber-fisico","caption":"La qualità del sistema nasce da interfacce chiare tra materia, energia, segnale e decisione."}
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
  'rf-antennas-and-embedded-communications',
  'RF, Antenne e Comunicazioni Embedded',
  'Radiofrequenza, antenne, link budget e vincoli pratici delle comunicazioni reali in sistemi mobili e intelligenti.',
  'architect',
  21,
  'Quando un sistema comunica senza filo, il problema smette di essere solo protocollare e diventa elettromagnetico, geometrico e architetturale. Antenne, potenza irradiata, link budget, interferenze, schermatura e ambiente cambiano direttamente la qualità operativa del sistema.' ,
  array[
    'Una comunicazione wireless è anche un problema di campo, spazio e potenza.',
    'Il link budget collega teoria, hardware e ambiente reale.',
    'Embedded communication e RF impattano affidabilità, sicurezza e autonomia.'
  ],
  '[
    {"title":"Dal protocollo al mondo fisico","content":"Il dato può essere corretto a livello software eppure perdersi nel canale fisico. Per questo radio, antenne e ambiente vanno letti come parte della stessa architettura comunicativa."},
    {"title":"Perche conta in sistemi avanzati","content":"Droni, dispositivi mobili, robot distribuiti e wearables intelligenti vivono tutti sotto vincoli di comunicazione embedded che non si possono trattare come dettaglio."}
  ]'::jsonb,
  '[
    {"label":"Link budget base","expression":"P_rx = P_tx + G_tx + G_rx - L_path","note":"Forma semplificata per leggere bilancio di potenza del collegamento."}
  ]'::jsonb,
  '[
    {"title":"MIT OCW - Electromagnetics and Applications","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"signal-wave","title":"Canale radio","caption":"Comunicare bene in RF significa difendere il segnale nel dominio fisico, non solo nel protocollo."}
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
  'powertrain-locomotion-and-mobility-systems',
  'Powertrain, Locomozione e Sistemi di Mobilità',
  'Catena completa da sorgente energetica ad azione utile: trasmissione, trazione, stabilità e manovrabilità.',
  'architect',
  21,
  'Un sistema mobile non dipende da un solo motore. Dipende dalla catena completa che trasforma energia in movimento controllabile: sorgente, potenza, attuatore, trasmissione, contatto con il mondo, stabilità e strategia di controllo. Questo vale per robot, droni, esoscheletri e veicoli compatti.' ,
  array[
    'La locomozione è sempre una catena sistemica, non un componente isolato.',
    'Trazione, stabilità e manovrabilità competono con efficienza e massa.',
    'Powertrain e controllo devono essere co-progettati.'
  ],
  '[
    {"title":"Dal bus alla trazione","content":"Una piattaforma mobile seria va letta dall energia disponibile fino al punto di contatto col mondo: ruota, giunto, spinta, atto di equilibrio o locomozione. Ogni anello cambia il comportamento complessivo."},
    {"title":"Perche è importante","content":"La mobilità è spesso il punto dove tutti i compromessi esplodono insieme: massa, autonomia, sicurezza, dinamica, termica, robustezza e manutenibilità."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT OCW - Vehicle Dynamics / Robotics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"trade-study","title":"Powertrain e locomozione","caption":"Una buona mobilità nasce dal bilanciamento tra energia, attuazione, massa, controllo e contatto col mondo."}
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
  ('thermodynamics-heat-transfer-and-energy-systems', 'engineering-math-calculus-and-linear-algebra', 1),
  ('thermodynamics-heat-transfer-and-energy-systems', 'dimensional-analysis-and-estimation', 2),
  ('mass-transfer-fluids-and-propulsion', 'thermodynamics-heat-transfer-and-energy-systems', 1),
  ('mass-transfer-fluids-and-propulsion', 'classical-mechanics-and-dynamics', 2),
  ('materials-chemistry-corrosion-and-failure', 'materials-processes-and-dfm', 1),
  ('materials-chemistry-corrosion-and-failure', 'thermodynamics-heat-transfer-and-energy-systems', 2),
  ('mechatronics-integration-and-cyber-physical-design', 'feedback-control-and-real-time-embedded', 1),
  ('mechatronics-integration-and-cyber-physical-design', 'statics-structures-and-materials', 2),
  ('rf-antennas-and-embedded-communications', 'electromagnetism-and-fields', 1),
  ('rf-antennas-and-embedded-communications', 'communication-information-and-encoding', 2),
  ('powertrain-locomotion-and-mobility-systems', 'power-electronics-and-switching-physics', 1),
  ('powertrain-locomotion-and-mobility-systems', 'mass-transfer-fluids-and-propulsion', 2)
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
    ('systems-foundations', 1, 5, 'thermodynamics-heat-transfer-and-energy-systems', 50, false),
    ('systems-foundations', 6, 10, 'mechatronics-integration-and-cyber-physical-design', 50, false),
    ('mechanical-thinking', 1, 5, 'mass-transfer-fluids-and-propulsion', 50, false),
    ('mechanical-thinking', 6, 10, 'materials-chemistry-corrosion-and-failure', 50, false),
    ('electronics-basics', 1, 5, 'rf-antennas-and-embedded-communications', 50, false),
    ('electronics-basics', 6, 10, 'powertrain-locomotion-and-mobility-systems', 50, false),
    ('software-systems', 1, 5, 'rf-antennas-and-embedded-communications', 50, false),
    ('energy-control', 1, 4, 'thermodynamics-heat-transfer-and-energy-systems', 50, false),
    ('energy-control', 5, 10, 'powertrain-locomotion-and-mobility-systems', 50, false),
    ('ai-simulation', 1, 5, 'mechatronics-integration-and-cyber-physical-design', 50, false),
    ('materials-fabrication', 1, 5, 'materials-chemistry-corrosion-and-failure', 50, false),
    ('materials-fabrication', 6, 10, 'thermodynamics-heat-transfer-and-energy-systems', 50, false),
    ('systems-architecture', 1, 5, 'mechatronics-integration-and-cyber-physical-design', 50, false),
    ('systems-architecture', 6, 10, 'rf-antennas-and-embedded-communications', 50, false)
) as rollout(path_slug, from_order, to_order, topic_slug, sort_order, is_primary)
  on p.slug = rollout.path_slug
 and m.order_index between rollout.from_order and rollout.to_order
on conflict (mission_id, topic_slug) do update set
  sort_order = excluded.sort_order,
  is_primary = excluded.is_primary;
