update public.learning_areas
set description = 'Reti, sistemi operativi, algoritmi, dati, simulazione e software intelligente.'
where slug = 'software-ai';

update public.learning_areas
set description = 'Forze, strutture, trasmissioni, materiali, fabbricazione e prototipazione rapida.'
where slug = 'mechanics-materials';

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
values
(
  'efc4432d-0eac-4ae8-aacb-d9bc1f7ef001',
  'ai-simulation',
  'AI, Simulazione e Decisione',
  'Modelli, simulazioni, stima, pianificazione e decisione per costruire sistemi intelligenti credibili.',
  '🧠',
  '#EC4899',
  6,
  5,
  true,
  'software-ai'
),
(
  '8ce5b25d-3fd0-44b6-9e92-c58e8e5a9002',
  'materials-fabrication',
  'Materiali e Prototipazione',
  'Dal materiale giusto al componente reale: fabbricazione, tolleranze, design for manufacturing e prototipi.',
  '🛠️',
  '#14B8A6',
  7,
  5,
  true,
  'mechanics-materials'
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
  'f0b2ab11-09f8-4e7a-bdc9-d08d32dd0001',
  'efc4432d-0eac-4ae8-aacb-d9bc1f7ef001',
  'Modelli, Stati e Simulazione',
  'Prima di costruire una macchina intelligente devi modellarla.',
  '🧮',
  95,
  8,
  1,
  true,
  'intro',
  array['capire stato di un sistema', 'distinguere modello e realta', 'usare simulazione per ridurre rischio'],
  6,
  '[
    {"type":"lesson","emoji":"🧮","title":"Modellare Prima di Costruire","content":"Gli ingegneri non progettano sistemi complessi andando a tentoni. Costruiscono modelli: rappresentazioni semplificate ma utili del comportamento reale. Un modello puo essere fisico, matematico o computazionale.","key_points":["Un modello semplifica la realta","Serve a prevedere prima di costruire","Ogni modello ha limiti di validita"]},
    {"type":"lesson","emoji":"🎮","title":"Simulazione","content":"Una simulazione ti permette di testare scenari, failure mode e strategie di controllo senza rompere hardware costoso. Più il sistema e costoso o rischioso, più la simulazione diventa cruciale.","key_points":["La simulazione riduce rischio e costo","Permette test su scenari rari o pericolosi","Non sostituisce il mondo reale ma lo anticipa"]},
    {"type":"quiz","question":"Perche un team avanzato simula un sistema prima del prototipo fisico?","options":["Per evitare di progettare sensori","Per ridurre rischio e iterare piu velocemente","Per eliminare la necessita di test reali","Per aumentare il peso del sistema"],"correct":1,"explanation":"La simulazione accelera l iterazione e riduce il costo degli errori prima dell hardware."},
    {"type":"challenge","title":"Primo Volto di Jarvis","scenario":"Stai progettando un sistema volante compatto con sensori, controllo e vincoli energetici.","question":"Qual e il primo artefatto tecnico piu credibile?","options":["Una UI spettacolare","Un modello di stato con simulazione di dinamica e sensori","Una batteria piu grande","Un casing in titanio"],"correct":1,"explanation":"Per sistemi complessi il modello viene prima dell ottimizzazione cosmetica o della scelta dei materiali finali."}
  ]'::jsonb
),
(
  'f0b2ab11-09f8-4e7a-bdc9-d08d32dd0002',
  'efc4432d-0eac-4ae8-aacb-d9bc1f7ef001',
  'Stimare lo Stato del Sistema',
  'La misura e rumorosa: i sistemi intelligenti devono stimare, non solo leggere.',
  '📍',
  105,
  9,
  2,
  true,
  'core',
  array['capire differenza tra misura e stima', 'ragionare su stato nascosto', 'introdurre fusione e filtraggio'],
  7,
  '[
    {"type":"lesson","emoji":"📍","title":"Misura vs Stima","content":"Molte grandezze importanti non sono misurabili direttamente o sono osservate con rumore. La stima combina modello e sensori per inferire lo stato reale del sistema.","key_points":["Lo stato utile non coincide sempre con cio che misuri","Stimare significa inferire con dati incompleti","Modello e sensori lavorano insieme"]},
    {"type":"lesson","emoji":"🌫️","title":"Rumore e Incertezza","content":"Ogni sensore introduce incertezza. Filtri e stimatori servono a separare segnale utile e disturbo, senza reagire in modo nervoso a ogni oscillazione.","key_points":["Il rumore e inevitabile","Filtrare non significa ignorare informazione","Stimatori buoni migliorano controllo e decisione"]},
    {"type":"quiz","question":"Perche uno stimatore e spesso migliore di una misura grezza?","options":["Perche elimina ogni errore","Perche combina modello e sensori per una stima piu robusta","Perche consuma meno batteria","Perche evita il feedback"],"correct":1,"explanation":"Gli stimatori sfruttano ridondanza e dinamica del sistema per produrre stime piu credibili."},
    {"type":"challenge","title":"Tracking in Combattimento","scenario":"Un sensore ottico perde il target per pochi istanti a causa di fumo e vibrazioni.","question":"Qual e la risposta architetturale piu forte?","options":["Abbandonare il tracking subito","Usare uno stimatore che continui a predire lo stato finche arrivano nuove misure","Aumentare solo la luminosita del display","Eliminare il modello dinamico"],"correct":1,"explanation":"Uno stimatore mantiene continuita temporale anche quando le misure sono temporaneamente degradate."}
  ]'::jsonb
),
(
  'f0b2ab11-09f8-4e7a-bdc9-d08d32dd0003',
  'efc4432d-0eac-4ae8-aacb-d9bc1f7ef001',
  'Decisione, Pianificazione e Tradeoff',
  'Una macchina intelligente sceglie azioni sotto vincoli, rischio e risorse limitate.',
  '♟️',
  115,
  9,
  3,
  true,
  'core',
  array['capire decisione sotto vincoli', 'ragionare su costo e utilita', 'introdurre pianificazione'],
  7,
  '[
    {"type":"lesson","emoji":"♟️","title":"Scegliere Azioni","content":"Decisione ingegneristica significa scegliere l azione con il miglior compromesso tra obiettivi, rischio, tempo, energia e sicurezza. Non esiste quasi mai una scelta perfetta, ma una scelta dominata da vincoli reali.","key_points":["Decisione = scelta sotto vincoli","Energia, rischio e tempo competono tra loro","Le buone architetture rendono espliciti i tradeoff"]},
    {"type":"lesson","emoji":"🗺️","title":"Pianificazione","content":"Pianificare significa ordinare azioni future per raggiungere un obiettivo. Nei sistemi complessi la pianificazione si aggiorna mentre arrivano nuovi dati.","key_points":["Pianificare = scegliere una sequenza di azioni","I piani si aggiornano quando cambiano i dati","La pianificazione dipende da modello e stato stimato"]},
    {"type":"quiz","question":"Qual e la descrizione piu credibile di una decisione ingegneristica avanzata?","options":["Scegliere sempre l opzione piu potente","Scegliere l azione che ottimizza i tradeoff dati vincoli reali","Agire senza modello per ridurre latenza","Massimizzare una sola metrica"],"correct":1,"explanation":"Le decisioni reali sono multi-obiettivo e vincolate, non monodimensionali."},
    {"type":"challenge","title":"Gestione delle Risorse","scenario":"Un sistema autonomo ha batteria limitata, piu target possibili e rischio crescente.","question":"Qual e la logica migliore?","options":["Usare tutta la potenza subito","Valutare costo, beneficio e rischio di ogni azione","Seguire sempre il target piu vicino","Ignorare il vincolo energetico"],"correct":1,"explanation":"Le decisioni robuste pesano utilita, rischio e risorse residue nello stesso modello."}
  ]'::jsonb
),
(
  'f0b2ab11-09f8-4e7a-bdc9-d08d32dd0004',
  'efc4432d-0eac-4ae8-aacb-d9bc1f7ef001',
  'Machine Learning per Ingegneri',
  'Usa il machine learning come strumento ingegneristico, non come magia.',
  '📈',
  130,
  10,
  4,
  true,
  'advanced',
  array['capire generalizzazione', 'distinguere training e inferenza', 'valutare quando ML serve davvero'],
  8,
  '[
    {"type":"lesson","emoji":"📈","title":"ML come Blocco di Sistema","content":"Il machine learning non sostituisce l ingegneria dei sistemi: e uno dei suoi blocchi possibili. Un modello ML e utile quando il mapping input-output e troppo complesso da programmare a mano ma abbastanza osservabile da apprendere dai dati.","key_points":["ML e uno strumento, non un architettura completa","Training e inferenza hanno costi diversi","I dati diventano parte del sistema"]},
    {"type":"lesson","emoji":"🧪","title":"Generalizzazione","content":"Un modello buono non memorizza solo gli esempi visti. Generalizza a casi nuovi. Per questo servono set di validazione, metriche corrette e attenzione ai bias dei dati.","key_points":["Generalizzare e il vero obiettivo","Valutazione e training non sono la stessa cosa","Dati sbagliati producono sistemi fragili"]},
    {"type":"quiz","question":"Quando ha senso usare ML in un sistema fisico?","options":["Sempre, a prescindere dal problema","Quando il mapping e complesso ma i dati e le metriche sono disponibili","Solo se hai GPU potenti","Mai nei sistemi reali"],"correct":1,"explanation":"ML ha senso quando aggiunge capacità previsiva o percettiva che una regola manuale non offre con costo accettabile."},
    {"type":"challenge","title":"Visione per il Casco","scenario":"Vuoi rilevare oggetti e intenzioni in ambienti variabili e rumorosi.","question":"Qual e l approccio piu maturo?","options":["Solo regole hard-coded","ML integrato in una pipeline con sensing, tracking e validazione di sistema","Un modello enorme senza test","Ignorare i dati di campo"],"correct":1,"explanation":"Il ML funziona bene quando e inserito in un architettura di sistema con validazione, fallback e sensor fusion."}
  ]'::jsonb
),
(
  'f0b2ab11-09f8-4e7a-bdc9-d08d32dd0005',
  'efc4432d-0eac-4ae8-aacb-d9bc1f7ef001',
  'Autonomia, Sicurezza e Supervisione',
  'I sistemi intelligenti davvero avanzati devono anche sapere quando fermarsi.',
  '🛡️',
  145,
  10,
  5,
  true,
  'advanced',
  array['capire supervisione', 'ragionare su fail-safe', 'progettare autonomia con vincoli di sicurezza'],
  8,
  '[
    {"type":"lesson","emoji":"🛡️","title":"Autonomia con Guardrail","content":"Più un sistema prende decisioni da solo, più servono regole di supervisione, limiti operativi e meccanismi di arresto sicuro. L autonomia senza vincoli e una demo, non un prodotto reale.","key_points":["Autonomia richiede supervisione","Fail-safe e limiti operativi sono parte del design","La sicurezza e una funzione di sistema"]},
    {"type":"lesson","emoji":"🚨","title":"Fallback e Graceful Degradation","content":"Quando un modulo fallisce, il sistema non deve sempre collassare. Può degradare con eleganza: meno prestazioni, più margine, modalità sicura o handoff al controllo umano.","key_points":["Non tutti i guasti richiedono shutdown totale","Degradare bene aumenta resilienza","Il fallback va progettato prima, non dopo"]},
    {"type":"quiz","question":"Qual e il segno di un sistema autonomo maturo?","options":["Non ha mai bisogno di limiti","Ha strategie di fallback e supervisione","Usa il massimo della potenza sempre","Nasconde i failure mode"],"correct":1,"explanation":"Sistemi maturi rendono espliciti i limiti operativi e prevedono modalità sicure."},
    {"type":"challenge","title":"Autopilota dell Armatura","scenario":"Un modulo di visione diventa inaffidabile durante un volo urbano ad alta velocita.","question":"Qual e la risposta ingegneristicamente piu forte?","options":["Continuare come nulla fosse","Ridurre autonomia, aumentare margini e passare a una modalita supervisionata","Spegnere tutto istantaneamente in ogni caso","Aumentare soltanto la luminosita dei sensori"],"correct":1,"explanation":"Un buon sistema degrada con logica di sicurezza, non ignora il rischio e non collassa inutilmente."}
  ]'::jsonb
),
(
  'a9c5b9dd-e8e8-4c4e-9cd7-2fe918cd1001',
  '8ce5b25d-3fd0-44b6-9e92-c58e8e5a9002',
  'Materiali, Proprieta e Selezione',
  'Scegliere il materiale giusto significa progettare prestazioni, peso e affidabilita.',
  '🧱',
  90,
  8,
  1,
  true,
  'intro',
  array['distinguere famiglie di materiali', 'ragionare su tradeoff peso-resistenza', 'collegare materiale e funzione'],
  6,
  '[
    {"type":"lesson","emoji":"🧱","title":"Nessun Materiale E Migliore in Assoluto","content":"Acciaio, alluminio, titanio, compositi e polimeri vincono in contesti diversi. La scelta dipende da rigidezza, resistenza, temperatura, costo, massa e processo produttivo.","key_points":["La selezione materiale e sempre contestuale","Peso, costo e prestazioni competono","Il materiale influenza anche il processo"]},
    {"type":"lesson","emoji":"⚖️","title":"Tradeoff Reali","content":"Un materiale leggero puo essere costoso. Uno resistente puo essere difficile da lavorare. Uno economico puo cedere in fatica o temperatura. Il design maturo vive di questi compromessi.","key_points":["Ogni materiale introduce compromessi","La producibilita conta quanto la prestazione","Il contesto operativo decide la scelta"]},
    {"type":"quiz","question":"Qual e il criterio piu corretto nella selezione di un materiale?","options":["Scegliere sempre il piu resistente","Scegliere quello che bilancia i requisiti del sistema","Scegliere quello piu famoso","Scegliere sempre il piu leggero"],"correct":1,"explanation":"La selezione materiale e una decisione multi-obiettivo guidata dal contesto reale."},
    {"type":"challenge","title":"Telaio di una Piattaforma Mobile","scenario":"Hai bisogno di rigidita, massa contenuta e tempi rapidi di prototipazione.","question":"Qual e il ragionamento migliore?","options":["Guardare solo la resistenza a trazione","Valutare insieme materiale, processo e vincoli di test","Scegliere il titanio a prescindere","Usare solo plastica per ridurre i costi"],"correct":1,"explanation":"Materiale e processo vanno scelti insieme in funzione del prototipo e del prodotto."}
  ]'::jsonb
),
(
  'a9c5b9dd-e8e8-4c4e-9cd7-2fe918cd1002',
  '8ce5b25d-3fd0-44b6-9e92-c58e8e5a9002',
  'Fabbricazione: CNC, Stampa 3D e Lamiere',
  'Ogni geometria ha un processo che la rende economica o impossibile.',
  '🏭',
  100,
  8,
  2,
  true,
  'core',
  array['distinguere processi produttivi', 'capire vincoli geometrici', 'ragionare su tempi e costi'],
  6,
  '[
    {"type":"lesson","emoji":"🏭","title":"Il Processo Cambia il Design","content":"Una parte pensata per stampa 3D non e ottimale per CNC, e una parte ottimizzata per lamiera non e uguale a una per fusione. Il processo produttivo impone geometrie, tolleranze e costi.","key_points":["Ogni processo ha i propri vincoli","Il design cambia con il processo","Costo e tempo dipendono dalla producibilita"]},
    {"type":"lesson","emoji":"🌀","title":"Additivo vs Sottrattivo","content":"La stampa 3D costruisce materiale dove serve. Il CNC rimuove materiale da un blocco. L uno privilegia complessita geometrica, l altro precisione e finitura superiore in molti casi.","key_points":["Additivo = costruire materiale","Sottrattivo = rimuovere materiale","Geometria e precisione dipendono dal processo"]},
    {"type":"quiz","question":"Qual e il vantaggio piu tipico della stampa 3D rispetto al CNC?","options":["Sempre maggiore precisione","Liberta geometrica piu alta in prototipazione rapida","Costo minore per ogni volume produttivo","Materiali sempre migliori"],"correct":1,"explanation":"La stampa 3D brilla spesso nella complessita geometrica e nell iterazione rapida."},
    {"type":"challenge","title":"Braccio Prototipo","scenario":"Devi validare rapidamente forma e cinematica di un supporto complesso prima della versione finale lavorata.","question":"Qual e la prima scelta piu sensata?","options":["Produzione definitiva in titanio","Prototipo stampato 3D con geometria iterabile","Forgiatura industriale","Solo simulazione senza parte fisica"],"correct":1,"explanation":"Per iterazione rapida conviene spesso validare prima la geometria con produzione additiva."}
  ]'::jsonb
),
(
  'a9c5b9dd-e8e8-4c4e-9cd7-2fe918cd1003',
  '8ce5b25d-3fd0-44b6-9e92-c58e8e5a9002',
  'Tolleranze, Accoppiamenti e Assemblaggio',
  'Il prodotto reale vive negli scarti minimi tra teoria e fabbricazione.',
  '📏',
  110,
  9,
  3,
  true,
  'core',
  array['capire tolleranze', 'ragionare su assemblaggio', 'evitare errori da over-precision'],
  7,
  '[
    {"type":"lesson","emoji":"📏","title":"La Geometria Reale non e Perfetta","content":"Ogni parte prodotta ha variazioni. Le tolleranze definiscono quanto puo discostarsi dalla geometria nominale senza compromettere la funzione.","key_points":["Le tolleranze gestiscono la variabilita reale","Precisione inutile aumenta costo","La funzione guida la specifica"]},
    {"type":"lesson","emoji":"🔩","title":"Accoppiamenti e Assemblaggio","content":"Un albero e un foro non devono solo avere la dimensione nominale giusta: devono potersi assemblare, lavorare sotto carico e mantenere il comportamento desiderato nel tempo.","key_points":["Assemblaggio e parte del design","Accoppiamenti diversi producono comportamenti diversi","Il costo esplode se tolleri tutto troppo stretto"]},
    {"type":"quiz","question":"Perche tolleranze troppo strette sono un problema?","options":["Perche rendono il prodotto piu leggero","Perche aumentano costo e difficolta produttiva senza sempre migliorare la funzione","Perche impediscono i test","Perche riducono la resistenza dei materiali"],"correct":1,"explanation":"La precisione ha un costo: va applicata dove serve davvero alla funzione."},
    {"type":"challenge","title":"Modulo di Polso dell Armatura","scenario":"Un giunto deve muoversi in modo fluido ma senza gioco eccessivo sotto coppia variabile.","question":"Qual e il principio corretto?","options":["Specificare la tolleranza minima possibile ovunque","Progettare accoppiamenti e tolleranze in funzione di assemblaggio e comportamento sotto carico","Ignorare la tolleranza e correggere a mano","Usare sempre parti incollate"],"correct":1,"explanation":"Tolleranze e accoppiamenti vanno progettati per il comportamento reale, non per un ideale astratto."}
  ]'::jsonb
),
(
  'a9c5b9dd-e8e8-4c4e-9cd7-2fe918cd1004',
  '8ce5b25d-3fd0-44b6-9e92-c58e8e5a9002',
  'Design for Manufacturing',
  'Un grande progetto non e solo funzionante: e anche producibile.',
  '🧩',
  120,
  9,
  4,
  true,
  'advanced',
  array['capire DFM', 'ridurre complessita inutile', 'progettare parti e assemblaggi migliori'],
  7,
  '[
    {"type":"lesson","emoji":"🧩","title":"DFM","content":"Design for Manufacturing significa progettare il prodotto tenendo conto di come verra costruito, assemblato, testato e manutenuto. Un progetto elegante in CAD puo essere pessimo in produzione.","key_points":["Prodotto e processo vanno progettati insieme","Meno complessita inutile significa piu robustezza","Assemblaggio e manutenzione contano fin dall inizio"]},
    {"type":"lesson","emoji":"🔁","title":"Iterare Senza Sprechi","content":"Un buon DFM riduce parti inutili, orienta le geometrie al processo giusto e semplifica attrezzaggi, controlli e assemblaggio. Il miglior componente e spesso quello che non devi produrre affatto.","key_points":["Ridurre parti riduce rischio","Ogni interfaccia aggiunge complessita","Iterare bene richiede feedback da produzione"]},
    {"type":"quiz","question":"Qual e un segnale di buon DFM?","options":["Più parti e più viti possibili","Geometrie coerenti con il processo scelto e meno complessita superflua","Solo materiali premium","Tolleranze minime ovunque"],"correct":1,"explanation":"Il buon DFM allinea geometria, processo, assemblaggio e costo."},
    {"type":"challenge","title":"Piastra Multi-Funzione","scenario":"Tre supporti separati, dieci viti e due staffe possono essere sostituiti da una singola parte riprogettata.","question":"Qual e la mossa migliore?","options":["Mantenere l architettura originale per sicurezza","Valutare integrazione funzionale se migliora produzione e assemblaggio","Aumentare solo lo spessore","Usare materiale piu costoso"],"correct":1,"explanation":"L integrazione funzionale ben progettata riduce assemblaggio, errori e massa."}
  ]'::jsonb
),
(
  'a9c5b9dd-e8e8-4c4e-9cd7-2fe918cd1005',
  '8ce5b25d-3fd0-44b6-9e92-c58e8e5a9002',
  'Test, Iterazione e Costruzione del Prototipo',
  'La prototipazione seria non e costruire una volta: e imparare velocemente.',
  '🧪',
  135,
  10,
  5,
  true,
  'advanced',
  array['ragionare su test incrementali', 'collegare prototipo e apprendimento', 'capire build-measure-learn ingegneristico'],
  8,
  '[
    {"type":"lesson","emoji":"🧪","title":"Il Prototipo Come Strumento Cognitivo","content":"Un prototipo serve a imparare, non solo a dimostrare. Ogni build deve rispondere a domande precise: regge? si assembla? vibra? dissipa? pesa troppo?","key_points":["Ogni prototipo deve testare un ipotesi","Prototipare e apprendere velocemente","Misurare vale piu che intuire"]},
    {"type":"lesson","emoji":"🔬","title":"Test Incrementali","content":"Invece di validare tutto insieme, i team forti isolano sottosistemi: meccanica, potenza, controllo, termica, sensing. Questo rende i failure mode piu leggibili e accelera il debug.","key_points":["Testare per sottosistemi riduce ambiguita","Ogni failure mode va isolato","La sequenza di test influenza la velocita di apprendimento"]},
    {"type":"quiz","question":"Qual e il modo piu efficace di usare un prototipo?","options":["Usarlo come oggetto finale e basta","Usarlo per validare ipotesi precise e raccogliere dati","Costruirlo una sola volta senza iterazioni","Nascondere i problemi finche tutto funziona"],"correct":1,"explanation":"Il prototipo migliore e quello che produce apprendimento strutturato, non solo impressione visiva."},
    {"type":"challenge","title":"Mk I, Mk II, Mk III","scenario":"Il primo prototipo funziona a tratti, il secondo migliora potenza ma scalda troppo, il terzo riduce massa e aumenta stabilita.","question":"Qual e la lettura giusta?","options":["Il primo doveva gia essere perfetto","La sequenza di prototipi e il processo corretto per convergere su un sistema complesso","Ogni iterazione indica un errore grave di partenza","Bisognava evitare il test fisico"],"correct":1,"explanation":"Sistemi complessi maturano per iterazioni guidate da test e misure. Questa e buona ingegneria, non indecisione."}
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
where current_mission.path_id in (
  'efc4432d-0eac-4ae8-aacb-d9bc1f7ef001',
  '8ce5b25d-3fd0-44b6-9e92-c58e8e5a9002'
)
on conflict do nothing;
