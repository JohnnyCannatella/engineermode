create table if not exists public.learning_areas (
  slug text primary key,
  title text not null,
  description text,
  icon text not null,
  color text not null,
  order_index integer not null default 0,
  created_at timestamptz not null default now()
);

alter table public.learning_paths
  add column if not exists area_slug text references public.learning_areas(slug);

insert into public.learning_areas (slug, title, description, icon, color, order_index)
values
  ('systems-thinking', 'Pensiero Sistemico', 'Modelli mentali, feedback, failure modes e architettura dei sistemi complessi.', '🧠', '#7C3AED', 1),
  ('software-ai', 'Software, AI e Computazione', 'Reti, sistemi operativi, algoritmi, dati e software intelligente.', '💻', '#8B5CF6', 2),
  ('electronics-embedded', 'Elettronica, Embedded e Sensori', 'Circuiti, semiconduttori, strumentazione, embedded e segnali.', '⚡', '#06B6D4', 3),
  ('mechanics-materials', 'Meccanica, Materiali e Fabbricazione', 'Forze, strutture, trasmissioni, fluidi e comportamento dei materiali.', '⚙️', '#10B981', 4),
  ('energy-control', 'Energia, Robotica e Controllo', 'Potenza, attuazione, controllo, sistemi cyber-fisici e robotica.', '🤖', '#F59E0B', 5)
on conflict (slug) do update
set
  title = excluded.title,
  description = excluded.description,
  icon = excluded.icon,
  color = excluded.color,
  order_index = excluded.order_index;

update public.learning_paths
set area_slug = case slug
  when 'systems-foundations' then 'systems-thinking'
  when 'software-systems' then 'software-ai'
  when 'electronics-basics' then 'electronics-embedded'
  when 'mechanical-thinking' then 'mechanics-materials'
  when 'energy-control' then 'energy-control'
  else area_slug
end;

insert into public.learning_paths (
  id,
  slug,
  title,
  description,
  icon,
  color,
  order_index,
  mission_count,
  is_published,
  area_slug
)
values (
  '9ebf6c2f-531c-4c8d-8d33-9ca61f5b5c17',
  'energy-control',
  'Energia e Controllo',
  'Impara a progettare sistemi che misurano, decidono e agiscono: potenza, sensori, motori, controllo e embedded.',
  '🤖',
  '#F59E0B',
  5,
  6,
  true,
  'energy-control'
)
on conflict (slug) do update
set
  title = excluded.title,
  description = excluded.description,
  icon = excluded.icon,
  color = excluded.color,
  order_index = excluded.order_index,
  mission_count = excluded.mission_count,
  is_published = excluded.is_published,
  area_slug = excluded.area_slug;

insert into public.missions (
  id, path_id, title, description, icon, xp_reward, estimated_minutes, order_index, is_published,
  difficulty_level, learning_objectives, review_after_days, steps
)
values
(
  'c4d2d74d-4c47-4c14-a8a0-0c8f6db8236f',
  '9ebf6c2f-531c-4c8d-8d33-9ca61f5b5c17',
  'Potenza, Energia ed Efficienza',
  'Le grandezze che governano ogni macchina reale: potenza, energia, rendimento e perdite.',
  '🔋',
  80,
  7,
  1,
  true,
  'intro',
  array['distinguere potenza ed energia', 'calcolare il rendimento', 'ragionare sulle perdite'],
  5,
  '[
    {"type":"lesson","emoji":"🔋","title":"Energia vs Potenza","content":"L energia e la quantita totale di lavoro disponibile. La potenza e la velocita con cui quell energia viene trasferita o convertita. Una batteria contiene energia; un motore richiede potenza per compiere lavoro nel tempo.","key_points":["Energia = quantita totale disponibile","Potenza = energia per unita di tempo","Le macchine reali richiedono entrambe"]},
    {"type":"lesson","emoji":"📉","title":"Efficienza e Perdite","content":"Nessun sistema reale converte tutta l energia utile in output. Parte viene persa in calore, attrito, resistenza elettrica o rumore. Il rendimento e il rapporto tra output utile e input totale.","key_points":["Rendimento = output utile / input totale","Le perdite diventano spesso calore","Aumentare l efficienza migliora autonomia e prestazioni"]},
    {"type":"quiz","question":"Un convertitore riceve 100 W e ne consegna 82 W utili. Qual e il rendimento?","options":["18%","82%","100%","122%"],"correct":1,"explanation":"Il rendimento e output/input = 82/100 = 82%."},
    {"type":"challenge","title":"Progetto del Reattore","scenario":"Stai alimentando un sistema volante. Ogni watt sprecato diventa calore da gestire e peso da dissipare.","question":"Perche un ingegnere come Tony Stark ossessionato dalla miniaturizzazione cura cosi tanto il rendimento?","options":["Perche il rendimento influenza solo il costo dei componenti","Perche meno perdite significano meno calore, meno massa e piu autonomia","Perche un sistema inefficiente e sempre piu stabile","Perche i sistemi efficienti non hanno bisogno di controllo"],"correct":1,"explanation":"Nei sistemi compatti le perdite termiche e di massa diventano vincoli di primo livello. Efficienza significa piu autonomia, meno raffreddamento e meno peso."}
  ]'::jsonb
),
(
  'c65d4000-c4b7-43f0-9a8c-e042d11b2437',
  '9ebf6c2f-531c-4c8d-8d33-9ca61f5b5c17',
  'Batterie, Bus di Potenza e Conversione',
  'Come si immagazzina, distribuisce e converte energia in un sistema avanzato.',
  '🔌',
  90,
  8,
  2,
  true,
  'intro',
  array['capire bus di potenza', 'distinguere convertitori buck e boost', 'ragionare su tensione e corrente'],
  6,
  '[
    {"type":"lesson","emoji":"🔌","title":"Bus di Potenza","content":"I sistemi complessi non usano quasi mai una sola tensione. Una batteria puo alimentare un bus principale, poi convertitori secondari generano i livelli necessari a logica, sensori, attuatori e comunicazione.","key_points":["Un bus distribuisce energia a piu sottosistemi","Ogni sottosistema puo richiedere una tensione diversa","La conversione locale riduce sprechi e complessita"]},
    {"type":"lesson","emoji":"⚙️","title":"Buck e Boost","content":"Un convertitore buck riduce la tensione in modo efficiente. Un boost la aumenta. In un sistema reale puoi avere entrambi: batteria a 24V, logica a 5V, attuatore a 48V.","key_points":["Buck = step-down","Boost = step-up","La conversione switching e piu efficiente della dissipazione resistiva"]},
    {"type":"quiz","question":"Quale convertitore useresti per alimentare un microcontrollore a 5V da un bus a 24V?","options":["Boost","Buck","Raddrizzatore","Filtro passa-basso"],"correct":1,"explanation":"Serve ridurre la tensione: il convertitore corretto e un buck."},
    {"type":"challenge","title":"Distribuzione su Armatura","scenario":"Un esoscheletro ha batteria centrale, computer di bordo, radar e attuatori ad alta coppia.","question":"Qual e l architettura piu credibile?","options":["Un solo livello di tensione per tutti i moduli","Un bus principale con conversioni dedicate per i diversi carichi","Ogni sensore alimentato direttamente dalla batteria senza regolazione","Solo resistenze per abbassare la tensione"],"correct":1,"explanation":"Sistemi complessi usano bus principali e regolazioni locali per efficienza, isolamento e robustezza."}
  ]'::jsonb
),
(
  'e306c7aa-50ce-48f4-b950-10d93331f72f',
  '9ebf6c2f-531c-4c8d-8d33-9ca61f5b5c17',
  'Sensori, Misura e Fusione dei Segnali',
  'Un sistema intelligente misura il mondo prima di poterlo controllare.',
  '📡',
  100,
  8,
  3,
  true,
  'core',
  array['classificare sensori', 'ragionare sul rumore', 'capire la fusione sensoriale'],
  6,
  '[
    {"type":"lesson","emoji":"📡","title":"Dal Mondo Fisico ai Dati","content":"I sensori convertono grandezze fisiche in segnali interpretabili: posizione, velocita, temperatura, corrente, pressione, orientamento. Senza misura, il controllo e cieco.","key_points":["I sensori trasformano fenomeni fisici in dati","Ogni misura ha rumore e incertezza","Controllo e decisione dipendono dalla qualita della misura"]},
    {"type":"lesson","emoji":"🧭","title":"Fusione Sensoriale","content":"Un singolo sensore raramente basta. IMU, encoder, telecamere e sensori di corrente possono essere fusi per ottenere una stima piu robusta dello stato del sistema.","key_points":["Piu sensori riducono ambiguita","La fusione migliora robustezza e affidabilita","Stimare lo stato e diverso dal misurarlo direttamente"]},
    {"type":"quiz","question":"Perche un sistema di volo combina spesso giroscopi, accelerometri e magnetometri?","options":["Per consumare piu energia","Per ottenere una stima dell orientamento piu robusta","Per eliminare completamente il rumore","Per sostituire il controllore"],"correct":1,"explanation":"Ogni sensore ha punti forti e limiti. La fusione migliora la stima dell orientamento."},
    {"type":"challenge","title":"Armatura in Ambiente Ostile","scenario":"Un sistema robotico opera con vibrazioni, disturbi elettromagnetici e urti continui.","question":"Qual e la scelta migliore?","options":["Usare un solo sensore perfetto","Ridondanza sensoriale e validazione incrociata","Ignorare il rumore e filtrare tutto dopo","Aumentare soltanto la potenza del motore"],"correct":1,"explanation":"Ridondanza e cross-check sono fondamentali nei sistemi mission-critical soggetti a disturbi reali."}
  ]'::jsonb
),
(
  '66cfc3f7-f75d-45aa-b72f-8727c030751c',
  '9ebf6c2f-531c-4c8d-8d33-9ca61f5b5c17',
  'Motori, Attuatori e Trasmissione del Movimento',
  'Come un sistema trasforma energia in forza, coppia e movimento controllato.',
  '🦾',
  110,
  9,
  4,
  true,
  'core',
  array['distinguere attuatori', 'legare coppia e velocita', 'scegliere una catena di attuazione'],
  7,
  '[
    {"type":"lesson","emoji":"🦾","title":"Attuatori","content":"Un attuatore converte energia in azione: motori elettrici, servomotori, attuatori lineari, sistemi idraulici e pneumatici. La scelta dipende da coppia, velocita, precisione e massa.","key_points":["Ogni attuatore ha tradeoff diversi","Coppia, velocita e precisione raramente massimizzano insieme","Il carico meccanico definisce la scelta"]},
    {"type":"lesson","emoji":"⚙️","title":"Riduzione e Trasmissione","content":"Spesso il motore non viene collegato direttamente al carico. Riduttori, viti a ricircolo, cinghie e leveraggi adattano la dinamica del motore al compito reale.","key_points":["La trasmissione adatta il motore al carico","Riduzione = piu coppia, meno velocita","L inerzia riflessa cambia il comportamento del sistema"]},
    {"type":"quiz","question":"Per muovere un arto robotico pesante con precisione, cosa serve spesso oltre al motore?","options":["Solo una batteria piu grande","Una trasmissione o riduzione adatta al carico","Un sensore di temperatura","Un fusibile piu grande"],"correct":1,"explanation":"La trasmissione serve ad adattare coppia, velocita e controllo al carico reale."},
    {"type":"challenge","title":"Spalla dell Armatura","scenario":"Devi sollevare rapidamente un carico pesante senza perdere precisione di posizionamento.","question":"Qual e l idea piu corretta?","options":["Massimizzare solo la velocita del motore","Scegliere insieme motore, sensore e trasmissione","Usare il motore piu piccolo possibile","Eliminare il feedback per ridurre latenza"],"correct":1,"explanation":"L attuazione e una catena completa: motore, trasmissione, sensore e controllo devono essere progettati come sistema."}
  ]'::jsonb
),
(
  '6b3236c9-0bc1-4107-a01a-163976af6f34',
  '9ebf6c2f-531c-4c8d-8d33-9ca61f5b5c17',
  'Controllo a Retroazione e PID',
  'Stabilizzare, inseguire e correggere: il cuore di ogni sistema robotico avanzato.',
  '🎛️',
  125,
  10,
  5,
  true,
  'advanced',
  array['capire errore e setpoint', 'distinguere P I D', 'ragionare su stabilita e tuning'],
  8,
  '[
    {"type":"lesson","emoji":"🎛️","title":"Errore, Setpoint e Retroazione","content":"Un controllore confronta il valore desiderato con quello misurato. La differenza e l errore. Il feedback usa questo errore per correggere continuamente il sistema.","key_points":["Setpoint = valore desiderato","Errore = setpoint meno misura","La retroazione riduce l errore nel tempo"]},
    {"type":"lesson","emoji":"📈","title":"PID","content":"La parte Proporzionale reagisce all errore attuale. L Integrale accumula errore passato. La Derivativa anticipa il trend futuro. Insieme, le tre azioni permettono un controllo robusto ma richiedono tuning.","key_points":["P reagisce subito","I corregge errori persistenti","D smorza e anticipa"]},
    {"type":"quiz","question":"Quale termine del PID aiuta a eliminare un piccolo errore costante che rimane nel tempo?","options":["Proporzionale","Integrale","Derivativo","Nessuno"],"correct":1,"explanation":"L azione integrale accumula l errore residuo e lo annulla nel tempo."},
    {"type":"challenge","title":"Hover di Stabilizzazione","scenario":"Un sistema volante oscilla intorno alla quota desiderata. La risposta e rapida ma troppo nervosa.","question":"Quale interpretazione e piu plausibile?","options":["Serve rimuovere tutti i sensori","Il controllo ha bisogno di piu smorzamento o tuning migliore","Bisogna aumentare solo la tensione della batteria","Un sistema oscillante e sempre ottimale"],"correct":1,"explanation":"Oscillazioni e nervosismo indicano un tuning non ben smorzato. Serve lavorare sul controllore, non solo sulla potenza."}
  ]'::jsonb
),
(
  'd4cc7379-1921-4b73-b50f-8aab51f3d9db',
  '9ebf6c2f-531c-4c8d-8d33-9ca61f5b5c17',
  'Embedded, Tempo Reale e Architettura Robotica',
  'Il software che collega sensori, controllo e attuazione nel mondo fisico.',
  '🧠',
  140,
  10,
  6,
  true,
  'advanced',
  array['capire loop di controllo', 'distinguere hard e soft real-time', 'ragionare per architetture cyber-fisiche'],
  8,
  '[
    {"type":"lesson","emoji":"🧠","title":"Loop di Controllo Embedded","content":"Un sistema embedded legge i sensori, stima lo stato, calcola il controllo e comanda gli attuatori in un ciclo che deve rispettare timing stretti. Se il loop salta il timing, il comportamento fisico peggiora.","key_points":["Il loop legge, decide e agisce","Il timing e parte del comportamento del sistema","Nel mondo fisico il software non e mai separato dalla dinamica"]},
    {"type":"lesson","emoji":"⏱️","title":"Tempo Reale","content":"Hard real-time significa che mancare una deadline e inaccettabile. Soft real-time significa che e degradante ma tollerabile. Robotica, volo, automazione e power electronics vivono di queste deadline.","key_points":["Hard real-time = deadline inviolabile","Soft real-time = deadline importante ma non assoluta","La latenza influenza stabilita e sicurezza"]},
    {"type":"quiz","question":"Perche il tempo di campionamento e critico in un sistema di controllo embedded?","options":["Perche cambia il colore dell interfaccia","Perche determina quanto rapidamente il sistema percepisce e corregge il proprio stato","Perche sostituisce il feedback","Perche riduce sempre il consumo"],"correct":1,"explanation":"Il tempo di campionamento definisce quanto spesso il controllore osserva il sistema e reagisce. Se e troppo lento, il controllo degrada."},
    {"type":"challenge","title":"Jarvis su Hardware Reale","scenario":"Hai sensori, bus di comunicazione, inferenza locale, attuatori e vincoli termici in una piattaforma mobile complessa.","question":"Qual e l approccio migliore?","options":["Progettare ogni modulo in isolamento e integrarli dopo","Pensare in architettura cyber-fisica, con tradeoff congiunti tra software, elettronica, controllo e termica","Aumentare solo la frequenza del processore","Ridurre il numero di sensori a uno"],"correct":1,"explanation":"Un sistema alla Tony Stark richiede co-progettazione: software, sensing, potenza, controllo e termica vanno pensati insieme."}
  ]'::jsonb
)
on conflict (id) do update
set
  title = excluded.title,
  description = excluded.description,
  icon = excluded.icon,
  xp_reward = excluded.xp_reward,
  estimated_minutes = excluded.estimated_minutes,
  order_index = excluded.order_index,
  is_published = excluded.is_published,
  difficulty_level = excluded.difficulty_level,
  learning_objectives = excluded.learning_objectives,
  review_after_days = excluded.review_after_days,
  steps = excluded.steps;

insert into public.mission_prerequisites (mission_id, prerequisite_mission_id)
select current_mission.id, previous_mission.id
from public.missions current_mission
join public.missions previous_mission
  on previous_mission.path_id = current_mission.path_id
 and previous_mission.order_index = current_mission.order_index - 1
where current_mission.path_id = '9ebf6c2f-531c-4c8d-8d33-9ca61f5b5c17'
on conflict do nothing;
