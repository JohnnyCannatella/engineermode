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
values (
  'systems-modeling-and-boundaries',
  'Modellazione di Sistema e Confini',
  'Come definire un sistema in termini di scopo, interfacce, flussi e limiti di analisi.',
  'deep',
  14,
  'Un sistema va capito prima di essere ottimizzato. Per farlo devi definire confini, ingressi, uscite, ambiente, sottosistemi e variabili che contano davvero. Senza questo passaggio, ogni ragionamento successivo si appoggia a un modello confuso e le decisioni diventano fragili.' ,
  array[
    'I confini di sistema stabiliscono cosa controlli e cosa devi trattare come ambiente.',
    'Un buon modello semplifica senza eliminare la causalita importante.',
    'Interfacce e flussi rendono il sistema leggibile e verificabile.'
  ],
  '[
    {"title":"Dove iniziare","content":"Scrivi il sistema come trasformazione: prende qualcosa in input, produce qualcosa in output e lo fa sotto vincoli. Poi separa struttura, dinamica e ambiente. Questo ti evita di confondere parti interne con disturbi esterni."},
    {"title":"Perche i confini sono importanti","content":"Se metti il sensore dentro il sistema oppure lo consideri parte dell ambiente, cambiano requisiti, failure modes e strategia di verifica. Un buon confine non e teorico: guida design e test."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"NASA Systems Engineering Handbook","url":"https://www.nasa.gov/reference/systems-engineering-handbook/","type":"handbook","source":"NASA"}
  ]'::jsonb,
  '[
    {"kind":"interface-contract","title":"Confini e interfacce","caption":"Un sistema si capisce meglio quando rendi espliciti scambi, limiti e responsabilita."}
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
  'measurement-energy-and-control',
  'Misura, Energia e Controllo',
  'Il trittico che fa funzionare i sistemi reali: percezione dello stato, disponibilita di energia e azione correttiva.',
  'deep',
  15,
  'Ogni sistema fisico credibile deve sapere qualcosa sul proprio stato, avere energia per agire e una logica per correggere deviazioni e disturbi. Quando uno di questi tre elementi manca, la prestazione degrada o il sistema diventa instabile.' ,
  array[
    'Misurare non significa conoscere perfettamente: ogni misura ha banda, ritardo e rumore.',
    'Energia e controllo sono accoppiati: ogni correzione costa risorse.',
    'La qualita di un sistema dipende spesso piu dai loop di feedback che dai singoli componenti.'
  ],
  '[
    {"title":"Catena minima di un sistema controllato","content":"Misura, stima, decisione e attuazione formano una catena. Se una fase e lenta o rumorosa, tutto il comportamento di sistema cambia."},
    {"title":"Energia come vincolo","content":"Potenza disponibile, efficienza e dissipazione sono limiti architetturali. Anche l algoritmo migliore fallisce se la fisica del sistema non regge."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT OpenCourseWare - Feedback and Control","url":"https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/resources/lecture-10-feedback-and-control/","type":"video","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"feedback-loop","title":"Misura ed azione","caption":"La qualita del controllo dipende dalla catena completa e non dal solo controller."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'analog-circuits-and-signals',
  'Circuiti Analogici e Segnali',
  'Base seria su tensione, corrente, reti resistive, reattivi e segnali elettrici.',
  'deep',
  16,
  'L elettronica analogica e il linguaggio continuo dell energia e della misura. Serve per capire come si distribuisce la tensione, dove scorre corrente, come si accumula energia e perche un circuito reale non si comporta mai come un blocco ideale.' ,
  array[
    'Tensione e corrente descrivono stato e flusso nel circuito.',
    'Elementi reattivi introducono memoria e dinamica temporale.',
    'Leggere un circuito significa ragionare su nodi, percorsi e vincoli di energia.'
  ],
  '[
    {"title":"Leggi fondamentali","content":"Kirchhoff, Ohm e conservazione dell energia sono il minimo sindacale per leggere un circuito con rigore. Non sono formule isolate: sono vincoli strutturali."},
    {"title":"Perche i segnali contano","content":"Un sensore, un filtro e uno stadio analogico manipolano segnali nel tempo. Capire ampiezza, fase e banda ti fa leggere meglio anche sistemi embedded e controllo."}
  ]'::jsonb,
  '[
    {"label":"Ohm","expression":"V = I R","note":"Relazione base per stimare correnti, cadute e dissipazione."}
  ]'::jsonb,
  '[
    {"title":"MIT OpenCourseWare - Circuits and Electronics","url":"https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/","type":"video","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"circuit-loop","title":"Loop elettrico","caption":"Percorsi di corrente e cadute di tensione vanno letti come parte di uno stesso circuito."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'semiconductors-and-digital-logic',
  'Semiconduttori, Switching e Logica Digitale',
  'Dal comportamento del giunto fino alla costruzione di sistemi digitali affidabili.',
  'architect',
  17,
  'Dietro ogni sistema embedded c e un ponte tra fisica del semiconduttore e informazione digitale. Diodi, transistor e porte logiche non sono capitoli separati: sono livelli diversi della stessa catena tecnologica.' ,
  array[
    'Il transistor e un dispositivo fisico prima di essere un simbolo di schema.',
    'La logica digitale nasce da soglie, rumore ammesso e tempi di commutazione.',
    'Un sistema digitale robusto richiede alimentazione, sincronizzazione e interfacce coerenti.'
  ],
  '[
    {"title":"Dal dispositivo al sistema","content":"Studiare solo il simbolo porta a errori di integrazione. Guadagni, saturazione, tempi di salita e limiti di corrente spiegano perche un circuito digitale reale non e mai ideale."},
    {"title":"Perche la logica fallisce","content":"Rumore, timing e metastabilita rendono fragili le interfacce digitali. La logica e binaria, ma il supporto fisico lo e molto meno."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"All About Circuits - Digital Logic","url":"https://www.allaboutcircuits.com/textbook/digital/","type":"article","source":"All About Circuits"}
  ]'::jsonb,
  '[
    {"kind":"mosfet-symbol","title":"Switching fisico","caption":"Il comportamento del dispositivo condiziona direttamente affidabilita e velocita della logica."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'statics-structures-and-materials',
  'Statica, Strutture e Materiali',
  'Forze, vincoli e proprieta dei materiali come base del ragionamento meccanico.',
  'deep',
  16,
  'La meccanica ingegneristica inizia da equilibrio, carichi e risposta del materiale. Se non sai leggere forze, vincoli e percorsi di carico, rischi di progettare oggetti eleganti ma strutturalmente ingenui.' ,
  array[
    'Ogni forza ha direzione, punto di applicazione e conseguenze strutturali.',
    'Sforzo e deformazione sono il ponte tra carico esterno e risposta del materiale.',
    'Il fallimento meccanico nasce spesso da concentrazioni locali e non dal solo carico medio.'
  ],
  '[
    {"title":"Leggere un free-body diagram","content":"Il free-body diagram non e un disegno scolastico: e il modo per esplicitare tutte le interazioni importanti prima di scrivere equilibrio o stimare rischio di cedimento."},
    {"title":"Materiali e margine","content":"Modulo elastico, snervamento, fragilita e fatica ti dicono come un componente regge nel tempo, non solo al primo carico."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT OpenCourseWare - Mechanics and Materials I","url":"https://ocw.mit.edu/courses/2-001-mechanics-materials-i-fall-2006/","type":"video","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"free-body","title":"Free-body thinking","caption":"Ogni analisi meccanica seria parte da forze esplicite e vincoli corretti."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'thermal-fluids-and-motion',
  'Termica, Fluidi e Dinamica del Movimento',
  'Introduzione avanzata a calore, flussi e comportamento dinamico dei sistemi meccanici.',
  'architect',
  17,
  'Molti sistemi reali falliscono o diventano inefficienti non per la statica, ma per dinamica, dissipazione termica e interazione con i fluidi. Qui entri nel lato meno intuitivo della meccanica: fenomeni distribuiti, perdite e dipendenza dal tempo.' ,
  array[
    'Calore e fluidi governano limiti pratici di potenza, rendimento e affidabilita.',
    'Le dinamiche dipendono da inerzia, attrito, resistenza del fluido e geometria.',
    'Una buona intuizione termofluidodinamica migliora anche il design di sistemi elettronici ed energetici.'
  ],
  '[
    {"title":"Perche il calore conta","content":"La termica e spesso un vincolo nascosto. Un sistema puo essere corretto in teoria ma non sostenibile se non gestisce dissipazione, gradienti e accumulo di energia."},
    {"title":"Flussi e perdite","content":"I fluidi introducono resistenza, turbolenza, cadute di pressione e ritardi. Questi effetti cambiano prestazione e controllo ben piu di quanto sembri in una descrizione statica."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT OpenCourseWare - Fluid Mechanics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"complexity-scale","title":"Fenomeni distribuiti","caption":"Quando dinamica, termica e fluidi entrano in gioco, il comportamento di sistema diventa meno lineare e piu interdipendente."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'computer-systems-and-networks',
  'Reti e Sistemi Operativi',
  'Come comunicazione, memoria e scheduling costruiscono il comportamento delle piattaforme software.',
  'deep',
  15,
  'Un sistema software reale vive tra rete, kernel, file system, processi e memoria. L astrazione applicativa e utile, ma per capire latenza, affidabilita e isolamento devi guardare sotto.' ,
  array[
    'La rete introduce distanza, fallimenti parziali e stato incoerente.',
    'Il sistema operativo media risorse limitate: CPU, memoria, I/O e concorrenza.',
    'Prestazione e affidabilita nascono da piu livelli che cooperano male o bene.'
  ],
  '[
    {"title":"Ragionare a strati","content":"Quando un servizio e lento o instabile, il problema puo stare in rete, scheduling, I/O o sincronizzazione. Servono modelli a strati e misure giuste per distinguerli."},
    {"title":"Perche il sistema operativo conta","content":"Thread, paginazione, file system e syscall influenzano direttamente architettura e prestazione applicativa."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT OpenCourseWare - Computer System Engineering","url":"https://ocw.mit.edu/courses/6-033-computer-system-engineering-spring-2018/","type":"video","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"osi-stack","title":"Strati di rete","caption":"Capire dove nasce un problema richiede distinguere bene i livelli del sistema."},
    {"kind":"memory-map","title":"Memoria di processo","caption":"Lo spazio indirizzi spiega molte scelte e molti failure mode dei sistemi software."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'data-algorithms-and-distributed-architecture',
  'Dati, Algoritmi e Architetture Distribuite',
  'Da strutture dati e complessita fino a database, compilatori e sistemi distribuiti.',
  'architect',
  18,
  'Le scelte su strutture dati, modelli di persistenza e architetture distribuite determinano costo computazionale, affidabilita e velocita di evoluzione di un sistema software. Qui si studia come trasformare teoria in decisioni architetturali.' ,
  array[
    'Algoritmo e struttura dati sono scelte di architettura, non dettagli implementativi.',
    'Persistenza e distribuzione introducono coerenza, latenza e fallimenti nuovi.',
    'Un buon engineer sa spiegare perche una soluzione scala e quando smette di farlo.'
  ],
  '[
    {"title":"Dal locale al distribuito","content":"Una struttura dati efficiente in RAM non risolve automaticamente problemi di persistenza o replica. Cambiando il livello di sistema cambiano anche i tradeoff."},
    {"title":"Perche la complessita non basta","content":"O grande e utile, ma da sola non racconta cache miss, serializzazione, contention o costo di rete. Serve sempre un modello piu fisico del sistema."}
  ]'::jsonb,
  '[
    {"label":"Complessita media","expression":"T(n) ~ costo locale + costo I/O + costo rete","note":"Nei sistemi reali la complessita teorica va integrata con i costi di piattaforma."}
  ]'::jsonb,
  '[
    {"title":"MIT OpenCourseWare - Introduction to Algorithms","url":"https://ocw.mit.edu/courses/6-006-introduction-to-algorithms-fall-2011/","type":"video","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"complexity-scale","title":"Costo computazionale","caption":"Le classi di complessita sono utili, ma vanno lette insieme ai costi reali di sistema."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'power-electronics-and-actuation',
  'Potenza, Conversione e Attuazione',
  'Come l energia viene immagazzinata, convertita e trasformata in azione utile.',
  'deep',
  16,
  'Energia e controllo si incontrano nel mondo dei bus di potenza, delle batterie, dei convertitori e degli attuatori. Qui capisci non solo come alimentare un sistema, ma come farlo agire con margine, efficienza e sicurezza.' ,
  array[
    'Potenza disponibile e rendimento governano architettura e autonomia.',
    'I convertitori spostano energia ma introducono perdite, rumore e vincoli termici.',
    'Gli attuatori traducono energia in movimento o forza, con limiti dinamici precisi.'
  ],
  '[
    {"title":"Dal bus al motore","content":"Una catena energetica reale comprende sorgente, conversione, distribuzione, protezione e attuatore. Ogni passaggio aggiunge efficienza da difendere e failure modes da coprire."},
    {"title":"Perche l attuatore non e ideale","content":"Saturazione, inerzia, attrito e ritardi rendono il comportamento dell attuatore diverso da un semplice comando astratto. Questo cambia la strategia di controllo."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"Texas Instruments - Power Management Basics","url":"https://www.ti.com/power-management/overview.html","type":"article","source":"Texas Instruments"}
  ]'::jsonb,
  '[
    {"kind":"feedback-loop","title":"Energia e comando","caption":"Anche il miglior controllo dipende dalla qualita della catena di potenza e dell attuatore."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'feedback-control-and-real-time-embedded',
  'Feedback, PID e Sistemi Embedded Real-Time',
  'Approfondimento sul lato temporale del controllo: campionamento, latenza, task e affidabilita.',
  'architect',
  18,
  'Un loop di controllo vive nel tempo reale. Sensori, filtri, scheduler, bus e attuatori introducono ritardi e jitter. Per costruire sistemi robotici o embedded credibili devi ragionare sulla catena completa e non solo sul controller PID.' ,
  array[
    'Il tempo di campionamento cambia direttamente stabilita e prestazione.',
    'Software embedded e controllo sono inseparabili in un sistema cyber-fisico.',
    'Jitter e latenza possono degradare un loop anche con un modello teorico corretto.'
  ],
  '[
    {"title":"PID nel mondo reale","content":"Il PID funziona bene solo se le misure sono sensate, gli attuatori non saturano e l esecuzione ha tempi prevedibili. Nella pratica, anti-windup e gestione dei limiti sono spesso piu importanti della formula nominale."},
    {"title":"Scheduling e real-time","content":"Un task di controllo non gira in un vuoto ideale. Concorre con acquisizione, comunicazioni e diagnostica. Per questo architettura software e dinamica di controllo devono essere progettate insieme."}
  ]'::jsonb,
  '[
    {"label":"PID","expression":"u(t) = Kp e(t) + Ki integral e(t) dt + Kd de/dt","note":"La forma continua va sempre reinterpretata in campionamento discreto e con limiti reali."}
  ]'::jsonb,
  '[
    {"title":"MIT OpenCourseWare - Control of Manufacturing Processes","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"pid-controller","title":"Loop PID","caption":"Prestazione e stabilita dipendono da misura, ritardo, saturazione e tuning."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'modeling-estimation-and-simulation',
  'Modelli, Stima e Simulazione',
  'Costruire una rappresentazione utile del sistema e usarla per prevedere, testare e stimare stato.',
  'deep',
  16,
  'Nessun sistema complesso si capisce bene solo osservandolo a occhio. Servono modelli, simulazioni e tecniche di stima dello stato per ragionare su scenari, incertezza e comportamento non ancora misurato direttamente.' ,
  array[
    'Un modello utile non deve essere perfetto, ma sufficientemente predittivo.',
    'La stima di stato compensa limiti di misura e osservabilita incompleta.',
    'La simulazione accelera design e verifica quando i test reali costano troppo.'
  ],
  '[
    {"title":"Perche simulare","content":"La simulazione permette di esplorare casi limite, perturbazioni e architetture alternative prima di costruire tutto. Riduce rischio e rende piu ragionati i tradeoff."},
    {"title":"Stima e osservatori","content":"Molte grandezze importanti non sono misurabili direttamente. Le stimi combinando modello e sensori. Questa mentalita e centrale in robotica, avionica e sistemi autonomi."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT OpenCourseWare - Dynamic Systems and Control","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"state-machine","title":"Stato e transizioni","caption":"Ragionare in termini di stato aiuta a prevedere evoluzione e failure mode del sistema."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'ml-decision-and-autonomy',
  'Machine Learning, Decisione e Autonomia',
  'Dove l AI aiuta davvero un engineer: percezione, classificazione, pianificazione e supervisione.',
  'architect',
  18,
  'AI e machine learning hanno valore quando sono trattati come blocchi di sistema con requisiti, limiti, dati e fallback. Il punto non e conoscere solo i modelli, ma capire dove inserirli in una architettura robusta e verificabile.' ,
  array[
    'Un modello ML e un componente con failure modes specifici, non una magia.',
    'Decisione e autonomia richiedono sempre supervisione, vincoli e fallback.',
    'La qualita di dati e metriche vale spesso piu della complessita del modello.'
  ],
  '[
    {"title":"ML come blocco di sistema","content":"Un classificatore o un planner devono convivere con sensori rumorosi, latenza, risorse limitate e safety constraints. Questo cambia il modo in cui li progetti e li valuti."},
    {"title":"Autonomia responsabile","content":"Un sistema autonomo serio non massimizza solo performance media. Deve anche sapere quando non sa, passare il controllo o degradare in modo sicuro."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"3Blue1Brown - Neural Networks","url":"https://www.3blue1brown.com/lessons/neural-networks","type":"video","source":"3Blue1Brown"}
  ]'::jsonb,
  '[
    {"kind":"trade-study","title":"Autonomia vs controllo","caption":"Ogni aumento di autonomia va bilanciato con osservabilita, safety e fallback."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'materials-processes-and-dfm',
  'Materiali, Processi e Design for Manufacturing',
  'Come scegliere materiale e processo in funzione di costo, prestazione e producibilita.',
  'deep',
  16,
  'Materiale e processo produttivo definiscono massa, resistenza, costo, precisione e possibilita di assemblaggio. Pensare da engineer significa progettare il pezzo sapendo gia come verra prodotto e controllato.' ,
  array[
    'Scelta materiale e processo non possono essere separate.',
    'DFM significa ridurre costo e rischio senza tradire il requisito.',
    'Le tolleranze sono una decisione di sistema, non un dettaglio CAD.'
  ],
  '[
    {"title":"Selezione materiale","content":"Non basta cercare il materiale piu resistente. Devi ragionare su densita, ambiente, fatica, costo, disponibilita e compatibilita con il processo."},
    {"title":"Pensare al processo mentre progetti","content":"Stampa 3D, CNC, lamiere, compositi e fusioni impongono geometrie, raggi, spessori e strategie di assemblaggio differenti. Ignorarli genera prototipi fragili o costosi."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"MIT OpenCourseWare - Materials Selection","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  '[
    {"kind":"trade-study","title":"Selezione materiale","caption":"Prestazione, costo e producibilita devono essere confrontati insieme, non a silos."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'metrology-quality-and-prototyping',
  'Metrologia, Qualita e Prototipazione',
  'Come verificare un pezzo, iterare un prototipo e costruire fiducia nei risultati.',
  'architect',
  17,
  'Prototipare non significa solo costruire una versione iniziale. Significa generare evidenza. Per questo servono misure affidabili, controlli dimensionali, test di assemblaggio e una strategia di iterazione che riduca rischio ad ogni ciclo.' ,
  array[
    'La misura e parte del progetto, non solo del collaudo finale.',
    'Un prototipo buono e quello che risponde a una domanda tecnica precisa.',
    'Qualita e metrologia trasformano il fare in apprendimento difendibile.'
  ],
  '[
    {"title":"Perche misurare bene","content":"Un componente fuori tolleranza o una misura fatta male possono invalidare un intero ciclo di sviluppo. La metrologia serve a distinguere errore di design da errore di fabbricazione."},
    {"title":"Iterare con criterio","content":"Ogni prototipo dovrebbe ridurre un rischio specifico: geometria, robustezza, integrazione, prestazione o assembly. Senza una domanda chiara, il prototipo genera poco apprendimento."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"NIST - Engineering Metrology","url":"https://www.nist.gov/","type":"article","source":"NIST"}
  ]'::jsonb,
  '[
    {"kind":"verification-stack","title":"Dal pezzo al sistema","caption":"Misura e verifica devono accompagnare il prototipo lungo tutto il ciclo."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'system-requirements-and-interfaces',
  'Requisiti, Budget e Interfacce',
  'Base architetturale per progettare sistemi complessi prima che l integrazione li renda ingestibili.',
  'architect',
  18,
  'I sistemi complessi si rompono spesso alle interfacce e nei requisiti ambigui, non nei singoli blocchi. Per questo gli architect ragionano in budget, contratti, vincoli e responsabilita esplicite tra sottosistemi.' ,
  array[
    'Un requisito utile e misurabile, tracciabile e testabile.',
    'Le interfacce sono punti di rischio e vanno progettate con la stessa cura dei componenti.',
    'I budget rendono visibili i compromessi prima dei test finali.'
  ],
  '[
    {"title":"Requirement flowdown","content":"Un obiettivo di sistema va scomposto in requisiti di sottosistema coerenti. Se il flowdown e debole, l integrazione scarica i conflitti troppo tardi."},
    {"title":"Interface contract","content":"Rate, latenza, unita, qualita del dato, timing, fallback e ownership devono essere espliciti. Molti bug di sistema nascono proprio da contratti impliciti."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"INCOSE Systems Engineering Handbook","url":"https://www.incose.org/products-and-publications/se-handbook","type":"handbook","source":"INCOSE"}
  ]'::jsonb,
  '[
    {"kind":"interface-contract","title":"Contratto di interfaccia","caption":"Ogni collegamento tra sottosistemi va pensato come un contratto tecnico e non come una speranza."},
    {"kind":"trade-study","title":"Budgeting","caption":"I requisiti migliori sono quelli che rendono subito visibili i compromessi."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

insert into public.topics (slug, title, summary, difficulty_level, estimated_minutes, overview, key_takeaways, study_blocks, formulas, "references", visuals)
values (
  'verification-risk-and-mbse',
  'Verification, Rischio e MBSE',
  'Come chiudere il loop architetturale con test, model-based thinking e gestione del rischio.',
  'architect',
  19,
  'Una architettura e credibile solo se sai dimostrare che funziona. Verification planning, hardware in the loop, model-based systems engineering e gestione del rischio servono a trasformare una buona idea in un sistema verificato e difendibile.' ,
  array[
    'Testare tardi costa molto di piu che modellare e verificare presto.',
    'Il rischio va collegato a test, margini e decisioni di architettura.',
    'MBSE aiuta a mantenere coerenza tra requisiti, modelli, interfacce e verifica.'
  ],
  '[
    {"title":"Verification matrix","content":"Ogni requisito dovrebbe avere un metodo di verifica: analisi, test, ispezione o dimostrazione. Senza questa traccia, il progetto perde controllo."},
    {"title":"Model-based thinking","content":"Modelli e viste architetturali aiutano a gestire complessita, impatti di modifica e tracciabilita lungo il ciclo di sviluppo."}
  ]'::jsonb,
  '[]'::jsonb,
  '[
    {"title":"NASA Systems Engineering Handbook","url":"https://www.nasa.gov/reference/systems-engineering-handbook/","type":"handbook","source":"NASA"}
  ]'::jsonb,
  '[
    {"kind":"verification-stack","title":"Stack di verifica","caption":"La fiducia architetturale nasce da verifica distribuita su piu livelli."}
  ]'::jsonb
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, difficulty_level = excluded.difficulty_level, estimated_minutes = excluded.estimated_minutes,
  overview = excluded.overview, key_takeaways = excluded.key_takeaways, study_blocks = excluded.study_blocks, formulas = excluded.formulas,
  "references" = excluded."references", visuals = excluded.visuals;

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
    ('systems-foundations', 1, 5, 'systems-modeling-and-boundaries', 10, false),
    ('systems-foundations', 6, 10, 'measurement-energy-and-control', 10, false),
    ('electronics-basics', 1, 5, 'analog-circuits-and-signals', 10, true),
    ('electronics-basics', 6, 10, 'semiconductors-and-digital-logic', 10, true),
    ('mechanical-thinking', 1, 5, 'statics-structures-and-materials', 10, true),
    ('mechanical-thinking', 6, 10, 'thermal-fluids-and-motion', 10, true),
    ('software-systems', 1, 5, 'computer-systems-and-networks', 10, true),
    ('software-systems', 6, 10, 'data-algorithms-and-distributed-architecture', 10, true),
    ('energy-control', 1, 5, 'power-electronics-and-actuation', 10, true),
    ('energy-control', 6, 10, 'feedback-control-and-real-time-embedded', 10, true),
    ('ai-simulation', 1, 5, 'modeling-estimation-and-simulation', 10, true),
    ('ai-simulation', 6, 10, 'ml-decision-and-autonomy', 10, true),
    ('materials-fabrication', 1, 5, 'materials-processes-and-dfm', 10, true),
    ('materials-fabrication', 6, 10, 'metrology-quality-and-prototyping', 10, true),
    ('systems-architecture', 1, 5, 'system-requirements-and-interfaces', 10, true),
    ('systems-architecture', 6, 10, 'verification-risk-and-mbse', 10, true)
) as rollout(path_slug, from_order, to_order, topic_slug, sort_order, is_primary)
  on p.slug = rollout.path_slug
 and m.order_index between rollout.from_order and rollout.to_order
on conflict (mission_id, topic_slug) do update set
  sort_order = excluded.sort_order,
  is_primary = excluded.is_primary;
