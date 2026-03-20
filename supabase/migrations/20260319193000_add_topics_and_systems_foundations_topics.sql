create table if not exists public.topics (
  slug text primary key,
  title text not null,
  summary text not null,
  difficulty_level text not null check (difficulty_level in ('core', 'deep', 'architect')),
  estimated_minutes integer not null default 10 check (estimated_minutes > 0),
  overview text not null,
  key_takeaways text[] not null default '{}',
  study_blocks jsonb not null default '[]'::jsonb,
  formulas jsonb not null default '[]'::jsonb,
  "references" jsonb not null default '[]'::jsonb,
  visuals jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.mission_topics (
  mission_id uuid not null references public.missions(id) on delete cascade,
  topic_slug text not null references public.topics(slug) on delete cascade,
  sort_order integer not null default 0,
  is_primary boolean not null default false,
  created_at timestamptz not null default timezone('utc', now()),
  primary key (mission_id, topic_slug)
);

create index if not exists mission_topics_topic_slug_idx on public.mission_topics(topic_slug);
create index if not exists mission_topics_mission_id_idx on public.mission_topics(mission_id);

insert into public.topics (
  slug,
  title,
  summary,
  difficulty_level,
  estimated_minutes,
  overview,
  key_takeaways,
  study_blocks,
  formulas,
  "references",
  visuals
)
values
(
  'signal-noise-and-snr',
  'Segnale, Rumore e Rapporto S/N',
  'Capire quando un sensore o un canale di comunicazione porta informazione utile e quando invece misura soprattutto disturbo.',
  'deep',
  14,
  'Un sistema misura o trasmette informazione attraverso segnali fisici: tensione, corrente, pressione, luce, pacchetti di rete, impulsi digitali. Il problema e che il mondo reale non ti consegna mai un segnale perfetto. Ogni misura contiene anche rumore, cioe variazioni indesiderate dovute a sensori, elettronica, ambiente, quantizzazione o interferenze.\n\nLa domanda ingegneristica non e "c''e rumore?", ma "il segnale utile emerge abbastanza da permettere una decisione affidabile?". Per questo ragioni in termini di rapporto segnale/rumore, banda, filtraggio e compromesso tra sensibilita e robustezza.',
  array[
    'Un segnale vale solo se resta distinguibile dal rumore lungo la catena di misura.',
    'Aumentare il filtraggio migliora la pulizia ma introduce ritardo e puo nascondere eventi rapidi.',
    'Ogni sensore va valutato come sistema completo: sorgente, acquisizione, elaborazione e soglia decisionale.'
  ],
  '[
    {"title":"Dove nasce il rumore","content":"Il rumore puo entrare dal sensore, dai cavi, dallo stadio di amplificazione, dalla conversione A/D o dall''ambiente. Un accelerometro montato male o un encoder vicino a un motore rumoroso possono generare misure apparentemente plausibili ma poco affidabili. Non basta quindi conoscere il componente: devi guardare il contesto di integrazione."},
    {"title":"SNR e soglie decisionali","content":"Se la differenza tra stato sano e stato anomalo e piccola rispetto alla dispersione della misura, il sistema confonde i due casi. Per questo in diagnostica e controllo si sceglie una soglia con margine, oppure si accumulano piu campioni e si ragiona sulla media o su un filtro. Il costo e sempre un compromesso fra reattivita e affidabilita."},
    {"title":"Cosa approfondire quando resti corto di teoria","content":"Quando il concetto resta vago, studia tre pezzi in sequenza: campionamento, banda del segnale, e filtraggio. Sono loro che spiegano perche due misure dello stesso mondo possano raccontare storie diverse."}
  ]'::jsonb,
  '[
    {"label":"Rapporto segnale/rumore","expression":"SNR = P_segnale / P_rumore","note":"Spesso si usa anche la forma in dB per confronti rapidi tra catene di acquisizione."},
    {"label":"Forma in dB","expression":"SNR_dB = 10 log10(P_segnale / P_rumore)","note":"Un incremento di 10 dB significa circa 10 volte piu potenza utile rispetto al rumore."}
  ]'::jsonb,
  '[
    {"title":"MIT OpenCourseWare - Signals and Systems","url":"https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/","type":"video","source":"MIT OpenCourseWare"},
    {"title":"3Blue1Brown - But what is a Fourier series?","url":"https://www.3blue1brown.com/lessons/fourier-series","type":"video","source":"3Blue1Brown"},
    {"title":"NI - Signal-to-Noise Ratio Explained","url":"https://www.ni.com/en/support/documentation/supplemental/18/signal-to-noise-ratio--snr--explained.html","type":"article","source":"National Instruments"}
  ]'::jsonb,
  '[
    {"kind":"signal-wave","title":"Forme d''onda e rumore","caption":"Confronta segnale utile, disturbo e perdita di leggibilita quando la misura si sporca."}
  ]'::jsonb
),
(
  'sensor-filtering-and-latency',
  'Filtraggio, Banda e Latenza',
  'Approfondimento su come pulire una misura senza distruggere la dinamica che vuoi osservare.',
  'architect',
  12,
  'Un filtro non e solo uno strumento matematico: e una scelta architetturale. Riduce rumore e oscillazioni, ma introduce ritardo e puo deformare il comportamento osservato. In un controllo rapido o in una diagnostica di fault precoce, quel ritardo puo essere piu costoso del rumore stesso.\n\nPer questo i filtri vanno scelti in base al fenomeno fisico che vuoi vedere, alla frequenza degli eventi rilevanti e al costo di una falsa decisione.',
  array[
    'Ogni filtro elimina informazione insieme al rumore.',
    'Banda stretta e segnale stabile spesso implicano risposta piu lenta.',
    'Il filtro giusto dipende dalla decisione da prendere, non da una preferenza estetica del grafico.'
  ],
  '[
    {"title":"Low-pass come compromesso","content":"Un filtro passa-basso attenua componenti veloci e lascia passare la parte lenta del segnale. E utile se il rumore e ad alta frequenza, ma puo nascondere picchi o transitori che per il controllo sono essenziali. Un loop di retroazione con misura troppo filtrata reagisce in ritardo e puo diventare fragile."},
    {"title":"Campionamento e aliasing","content":"Se campioni troppo lentamente, il sistema scambia dinamiche veloci per fenomeni piu lenti o addirittura per comportamenti opposti. Questo errore non si corregge con una dashboard migliore: e un problema di acquisizione e teoria del segnale."}
  ]'::jsonb,
  '[
    {"label":"Filtro discreto semplice","expression":"y[k] = alpha x[k] + (1 - alpha) y[k-1]","note":"Alpha alto rende il filtro reattivo; alpha basso lo rende piu stabile ma piu lento."}
  ]'::jsonb,
  '[
    {"title":"MIT OpenCourseWare - Feedback and Control","url":"https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/resources/lecture-10-feedback-and-control/","type":"video","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"feedback-loop","title":"Filtro nel loop","caption":"Ogni ritardo nella misura cambia la qualita del controllo e della diagnosi."}
  ]'::jsonb
),
(
  'failure-modes-and-resilience',
  'Failure Modes, Diagnostica e Resilienza',
  'Come leggere un sistema dal punto di vista dei modi di guasto, delle catene causali e delle contromisure realistiche.',
  'deep',
  15,
  'Un sistema ingegneristico non fallisce in un solo modo. Fallisce per degradazione, saturazione, perdita di alimentazione, errore software, interfaccia sbagliata, ambiente non previsto o combinazione di piccoli difetti. La disciplina utile qui non e memorizzare una lista, ma imparare a vedere i modi di guasto come catene causali.\n\nQuando sai descrivere cosa si rompe, come si propaga e cosa il sistema osserva, puoi progettare ridondanza, monitoraggio, fallback e test mirati. Questa e la differenza tra un oggetto che funziona in demo e un sistema che regge il mondo reale.',
  array[
    'Un guasto va descritto come meccanismo, sintomo osservabile e impatto sul sistema.',
    'Ridondanza e fallback hanno senso solo se i failure modes sono davvero indipendenti.',
    'La resilienza si progetta prima nei requisiti e poi nei test, non dopo il primo crash.'
  ],
  '[
    {"title":"Dal componente al sistema","content":"Un sensore che drift-a lentamente e un cavo che si apre improvvisamente non generano lo stesso pattern di errore. Il primo produce misure plausibili ma sbagliate; il secondo spesso produce assenza di dato. Per questo la diagnostica deve riconoscere famiglie di guasti diverse e non solo valori fuori range."},
    {"title":"FMEA come strumento mentale","content":"Una Failure Mode and Effects Analysis ben fatta ti costringe a legare causa, effetto locale, effetto a livello sistema e metodo di rilevazione. Anche in forma semplificata, e un esercizio potentissimo per smettere di ragionare in modo ingenuo su affidabilita e sicurezza."},
    {"title":"Fallback e graceful degradation","content":"La domanda giusta non e solo come evitare il guasto, ma anche come fallire bene. Se perdi un sensore, il sistema continua in modalita degradata? Se la rete degrada, il controllo locale resta sicuro? La resilienza nasce da queste scelte."}
  ]'::jsonb,
  '[
    {"label":"Disponibilita approssimata","expression":"A = MTBF / (MTBF + MTTR)","note":"Non spiega tutto, ma aiuta a separare frequenza del guasto e velocita di recupero."}
  ]'::jsonb,
  '[
    {"title":"NASA Systems Engineering Handbook","url":"https://www.nasa.gov/reference/systems-engineering-handbook/","type":"handbook","source":"NASA"},
    {"title":"IEC 60812 / FMEA overview","url":"https://asq.org/quality-resources/fmea","type":"article","source":"ASQ"},
    {"title":"MIT OpenCourseWare - System Safety examples","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"verification-stack","title":"Dove intercettare un guasto","caption":"I failure modes vanno coperti a piu livelli: componente, sottosistema, integrazione e sistema."}
  ]'::jsonb
),
(
  'fault-tree-and-observability',
  'Osservabilita del Guasto e Fault Tree Thinking',
  'Come trasformare sintomi, telemetria e allarmi in un modello causale utile per debug e verifica.',
  'architect',
  13,
  'Un fault tree e un modello causale: parte da un evento indesiderato e scompone le possibili condizioni che lo generano. Ti costringe a distinguere tra causa primaria, condizioni necessarie, trigger e meccanismi di propagazione.\n\nQuesto tipo di ragionamento serve anche nel software e nei sistemi cyber-physical: non basta vedere un timeout o una temperatura anomala, devi capire quali combinazioni possono produrre quell''evento e come riconoscerle in telemetria.',
  array[
    'Telemetria utile significa sapere quali segnali discriminano tra cause diverse.',
    'Un allarme senza contesto raramente rende il sistema osservabile.',
    'Debug e safety migliorano quando costruisci alberi causali invece di reagire solo ai sintomi.'
  ],
  '[
    {"title":"Segnali diagnostici","content":"Per capire un fault non basta sapere che qualcosa e fuori range. Servono segnali che ti aiutino a distinguere: alimentazione presente, comando emesso, attuatore in risposta, sensore valido, timing rispettato. L''osservabilita e progettata, non regalata."},
    {"title":"Perche i sistemi sembrano intermittenti","content":"Molti problemi sembrano casuali solo perche la telemetria e povera. Quando tracci i nodi giusti della catena causale, l''intermittenza si riduce a una combinazione di condizioni precise."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"NASA Fault Management Handbook","url":"https://www.nasa.gov/reference/systems-engineering-handbook/","type":"handbook","source":"NASA"}
  ]'::jsonb,
  '[
    {"kind":"interface-contract","title":"Osservabilita di interfaccia","caption":"Per fare diagnosi servono contratti chiari: stati, timeout, qualita del dato e fallback."}
  ]'::jsonb
),
(
  'engineering-design-loop',
  'Processo di Progettazione Ingegneristica',
  'Dal bisogno al prototipo, fino alla verifica: come evitare di progettare in modo impulsivo o scolastico.',
  'deep',
  16,
  'Progettare non significa saltare subito alla soluzione piu elegante. Un buon processo parte dal problema, esplicita vincoli e criteri di successo, genera alternative, confronta tradeoff, costruisce un prototipo e verifica contro i requisiti. Quando questo loop manca, il team confonde velocita con progresso.\n\nIl processo ingegneristico serve proprio a impedire due errori opposti: restare bloccati nell''analisi o costruire troppo presto qualcosa di non verificabile.',
  array[
    'Il requisito definisce cosa conta; il concept definisce come potresti ottenerlo.',
    'Trade study e prototipazione riducono il rischio prima dell''implementazione completa.',
    'La verifica chiude il loop: senza test sui requisiti, non sai davvero cosa hai costruito.'
  ],
  '[
    {"title":"Definire il problema","content":"Scrivi il sistema in termini di funzione, ambiente, utenti, vincoli e metriche. Se il requisito non e misurabile, la verifica sara ambigua. Questa fase sembra lenta ma evita sprechi enormi piu avanti."},
    {"title":"Generare e confrontare concetti","content":"Le alternative non servono a fare brainstorming infinito, ma a evitare il primo design ovvio. Confronta almeno due o tre architetture usando criteri espliciti: massa, potenza, costo, rischio, complessita, manutenzione."},
    {"title":"Verifica e iterazione","content":"Ogni iterazione dovrebbe ridurre un rischio preciso: prestazione, affidabilita, integrazione, manutenibilita. Il prototipo vale se produce evidenza, non se e solo bello da vedere."}
  ]'::jsonb,
  '[
    {"label":"Margine ingegneristico","expression":"margine = capacita - richiesta","note":"Esplicita quanto sei lontano dal limite. Senza margine, il sistema e fragile anche se oggi funziona."}
  ]'::jsonb,
  '[
    {"title":"NASA Systems Engineering Handbook","url":"https://www.nasa.gov/reference/systems-engineering-handbook/","type":"handbook","source":"NASA"},
    {"title":"IDEO - Design Thinking vs Engineering Constraints","url":"https://designthinking.ideo.com/","type":"article","source":"IDEO"},
    {"title":"MIT OpenCourseWare - Engineering Design Process","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"trade-study","title":"Confronto tra concetti","caption":"Il design non si sceglie per gusto, ma confrontando criteri e vincoli espliciti."},
    {"kind":"verification-stack","title":"Dal prototipo al sistema","caption":"Ogni livello di verifica riduce un rischio diverso prima della piena integrazione."}
  ]'::jsonb
),
(
  'requirements-tradeoffs-and-budgets',
  'Requisiti, Margini e Tradeoff',
  'Come trasformare un obiettivo vago in budget tecnici confrontabili e decisioni difendibili.',
  'architect',
  14,
  'Nei sistemi complessi non puoi massimizzare tutto insieme. Potenza, massa, costo, latenza, accuratezza e affidabilita competono. Per questo gli engineer ragionano in budget: quanto puoi spendere di energia, quanto errore tolleri, quanto ritardo puoi accettare.\n\nUn trade study serio nasce da requisiti chiari e usa criteri pesati, non impressioni personali. Questa mentalita vale in meccanica, elettronica, software, controllo e architettura di sistema.',
  array[
    'Un budget tecnico distribuisce un limite di sistema tra sottosistemi.',
    'I tradeoff vanno resi espliciti prima che emergano come problemi in test.',
    'Una decisione e difendibile quando sai spiegare criterio, margine e costo della scelta scartata.'
  ],
  '[
    {"title":"Budget thinking","content":"Se un veicolo ha un limite di potenza, ogni sottosistema consuma parte di quel budget. Lo stesso vale per massa, latenza o memoria. Questa logica ti obbliga a progettare in termini di sistema completo e non di componenti isolati."},
    {"title":"Decision matrix","content":"Per confrontare opzioni diverse, assegna criteri, pesi e punteggi. Non e perfetto, ma rende visibile dove la decisione e robusta e dove invece dipende da assunzioni fragili."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"NASA Systems Engineering Handbook","url":"https://www.nasa.gov/reference/systems-engineering-handbook/","type":"handbook","source":"NASA"}
  ]'::jsonb,
  '[
    {"kind":"trade-study","title":"Trade study","caption":"Costo e prestazione cambiano insieme: il punto migliore dipende dalla missione, non da un valore assoluto."}
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

insert into public.mission_topics (mission_id, topic_slug, sort_order, is_primary)
select m.id, x.topic_slug, x.sort_order, x.is_primary
from public.missions m
join (
  values
    ('Segnale vs Rumore', 'signal-noise-and-snr', 1, true),
    ('Segnale vs Rumore', 'sensor-filtering-and-latency', 2, false),
    ('Modalità di Guasto del Sistema', 'failure-modes-and-resilience', 1, true),
    ('Modalità di Guasto del Sistema', 'fault-tree-and-observability', 2, false),
    ('Processo di Progettazione Ingegneristica', 'engineering-design-loop', 1, true),
    ('Processo di Progettazione Ingegneristica', 'requirements-tradeoffs-and-budgets', 2, false)
) as x(mission_title, topic_slug, sort_order, is_primary)
on m.title = x.mission_title
on conflict (mission_id, topic_slug) do update set
  sort_order = excluded.sort_order,
  is_primary = excluded.is_primary;
