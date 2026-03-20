update public.topics
set
  estimated_minutes = 30,
  overview = 'Le equazioni differenziali sono il linguaggio naturale dei sistemi dinamici. Ogni volta che una grandezza evolve nel tempo in risposta a stato, ingressi e perturbazioni, stai gia lavorando con un modello differenziale anche se non lo scrivi esplicitamente. Meccanica, termica, circuiti, fluidi, popolazioni di carica e processi di controllo condividono questa struttura.

Il salto di qualita arriva quando smetti di vedere ogni dominio come materia separata e inizi a riconoscere il pattern comune: stato, dinamica, ingresso, uscita e disturbo. Lo state-space serve esattamente a questo. Ti permette di rappresentare sistemi multi-variabile in modo uniforme, di ragionare su stabilita, controllabilita, osservabilita e di progettare interconnessioni piu pulite.

Questo topic non punta a formalismo sterile, ma a creare una grammatica trasversale per modellare sistemi reali, collegando intuizione fisica e struttura matematica.',
  key_takeaways = array[
    'Le equazioni differenziali descrivono l evoluzione temporale di stati fisici e informativi.',
    'Lo state-space unifica domini diversi in una forma utile a modellazione, controllo e stima.',
    'Stato e una memoria minima del sistema, non solo una lista arbitraria di variabili.',
    'Stabilita e comportamento dinamico dipendono dalla struttura del modello, non solo dai parametri nominali.'
  ],
  study_blocks = '[
    {"title":"Perché lo stato conta","content":"Dire che un sistema ha stato significa dire che il suo futuro non dipende solo dall ingresso istantaneo, ma anche dalla memoria accumulata. In un circuito questa memoria vive in condensatori e induttori, in un corpo rigido in velocità e posizioni, in un sistema termico in temperature e gradienti. Scegliere bene le variabili di stato è il primo atto di modellazione seria."},
    {"title":"Dal dominio fisico alla forma matematica","content":"Una volta identificate le grandezze che accumulano energia, quantità di moto, carica o massa, puoi scrivere equazioni di bilancio e trasformarle in equazioni differenziali del primo ordine. Lo state-space nasce da questa operazione: x_dot = f(x, u). Non è una scorciatoia scolastica, ma il modo più generale di tenere insieme dinamica, ingressi e output."},
    {"title":"Linearizzazione e intorno operativo","content":"Molti sistemi reali sono non lineari. Eppure lavoriamo spesso con modelli lineari perché vogliamo capire il comportamento vicino a un punto di lavoro. Linearizzare non significa negare la realtà, ma costruire uno strumento locale utile per progettare controllo, osservatori e margini di stabilità."},
    {"title":"Dove diventa prodotto","content":"Uno schema state-space ben costruito rende più facile fare simulazione, tuning, diagnosi, sensor fusion e verifiche di sicurezza. Ti permette anche di capire quando un modello è troppo povero per catturare accoppiamenti, saturazioni o dinamiche lente che poi causano sorprese sul prototipo."}
  ]'::jsonb,
  formulas = '[
    {"label":"State-space","expression":"x_dot = A x + B u","note":"Forma lineare canonica per descrivere la dinamica di stato."},
    {"label":"Output equation","expression":"y = C x + D u","note":"L uscita osservabile dipende da stato e ingressi."},
    {"label":"Continuous solution intuition","expression":"x(t) = e^(At) x(0) + integral e^(A(t-tau)) B u(tau) dtau","note":"La dinamica libera e quella forzata convivono nella stessa soluzione."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT 16.30/31 - Feedback Control","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"Underactuated Robotics - Linear Systems","url":"https://underactuated.mit.edu/index.html","type":"handbook","source":"MIT"},
    {"title":"State Space Basics","url":"https://www.youtube.com/results?search_query=state+space+control+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"state-machine","title":"Sistema come stato","caption":"Il sistema evolve come trasformazione dello stato interno sotto ingressi e disturbi."},
    {"kind":"feedback-loop","title":"Modello e controllo","caption":"Un buon modello di stato alimenta stima, controllo e diagnostica nello stesso loop."}
  ]'::jsonb
where slug = 'differential-equations-and-state-space';

update public.topics
set
  estimated_minutes = 31,
  overview = 'Il controllo moderno nasce quando un PID non basta più a leggere bene il problema. Sistemi multi-variabile, vincoli, dinamiche accoppiate, stima incompleta dello stato e obiettivi concorrenti chiedono una lente più strutturata: osservabilità, controllabilità, feedback di stato, ottimizzazione e robustezza.

La domanda chiave non è solo come ridurre l errore, ma quali stati puoi misurare, quali puoi influenzare e quanto margine hai rispetto a disturbi, saturazioni e incertezza di modello. Da qui nascono osservatori, LQR, MPC e approcci robusti: non come esercizi matematici, ma come strumenti per governare sistemi reali con compromessi espliciti.

Questo topic collega teoria dei sistemi, progettazione di feedback e decisione sotto vincoli, spostando il controllo dal tuning empirico alla sintesi architetturale.',
  key_takeaways = array[
    'Controllabilità e osservabilità definiscono cosa il sistema può davvero fare e quanto puoi saperne.',
    'Il feedback di stato permette di progettare dinamica chiusa in modo più consapevole di un tuning solo sull errore.',
    'Ottimizzazione e controllo si incontrano quando hai obiettivi multipli e vincoli operativi.',
    'Robustezza significa mantenere comportamento utile anche con modello imperfetto e disturbi reali.'
  ],
  study_blocks = '[
    {"title":"Oltre il PID","content":"Il PID resta prezioso, ma spesso nasconde la struttura del problema. Quando hai stati interni non misurati, attuatori accoppiati, limiti di input e obiettivi simultanei, serve una rappresentazione di stato e una sintesi più esplicita della dinamica desiderata."},
    {"title":"Controllabilità e osservabilità","content":"Un modo elegante per leggere un sistema è chiedere: posso portarlo dove mi serve con gli attuatori disponibili? Posso ricostruire gli stati che mi servono usando i sensori che ho? Se la risposta è parziale, il problema non è solo di controllo ma di architettura sistema-sensore-attuatore."},
    {"title":"Osservatori, LQR e MPC","content":"Gli osservatori stimano stati non misurati, LQR sceglie feedback ottimizzando uno scambio tra prestazione e sforzo di controllo, MPC pianifica online rispettando vincoli. Sono strumenti diversi ma condividono una mentalità: il controllo è una decisione strutturata nel tempo, non una sola correzione istantanea."},
    {"title":"Robustezza e fallimento elegante","content":"Un controller buono in simulazione ma fragile al rumore o alla saturazione non è buono. Devi ragionare su modelli incerti, margini, fallback e degradazione. Questo è il ponte tra teoria del controllo e ingegneria di sistema affidabile."}
  ]'::jsonb,
  formulas = '[
    {"label":"State feedback","expression":"u = -K x","note":"Il comando dipende direttamente dallo stato stimato o misurato."},
    {"label":"LQR cost","expression":"J = integral (x^T Q x + u^T R u) dt","note":"Bilancia errore di stato e sforzo di controllo."},
    {"label":"Observer intuition","expression":"x_hat_dot = A x_hat + B u + L(y - C x_hat)","note":"L osservatore corregge la stima usando l errore di misura."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT Underactuated - LQR and Estimation","url":"https://underactuated.mit.edu/","type":"handbook","source":"MIT"},
    {"title":"Stanford EE263 / Control notes","url":"https://web.stanford.edu/class/ee263/","type":"article","source":"Stanford"},
    {"title":"Modern Control overview","url":"https://www.youtube.com/results?search_query=modern+control+theory+overview","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"feedback-loop","title":"Stima e controllo","caption":"Sensori, osservatore e feedback di stato cooperano per chiudere il loop in sistemi complessi."},
    {"kind":"trade-study","title":"Prestazione vs robustezza","caption":"Spingere aggressività, consumo e margine richiede compromessi espliciti."}
  ]'::jsonb
where slug = 'modern-control-observability-and-optimization';

update public.topics
set
  estimated_minutes = 27,
  overview = 'L elettromagnetismo è la grammatica fisica di campi, antenne, motori, trasformatori, sensori, bus ad alta velocità e schermature. Se ti fermi al circuito ideale, perdi il momento in cui tensioni e correnti smettono di essere quantità concentrate e diventano distribuzioni nello spazio, con accoppiamenti, onde, induzione e interferenza.

Per un engineer il punto non è fare teoria elegante fine a sé stessa, ma capire quando il modello lumped non basta più. Linee lunghe, cavi rumorosi, EMI, accoppiamento induttivo, sensori magnetici e conversione elettromeccanica chiedono una lettura basata su campo e flusso, non solo su nodi e maglie.

Questo topic costruisce un ponte tra intuizione di circuito e intuizione di campo, così da leggere meglio potenza, comunicazioni e sensing.',
  key_takeaways = array[
    'Campi elettrici e magnetici spiegano molti fenomeni che il circuito ideale nasconde.',
    'Induzione, accoppiamento e propagazione diventano centrali quando frequenza e dimensioni crescono.',
    'EMI e integrità del segnale sono problemi di geometria, ritorni di corrente e campo, non solo di componenti.',
    'Motori, antenne e trasformatori condividono radici elettromagnetiche profonde.'
  ],
  study_blocks = '[
    {"title":"Dal lumped al distribuito","content":"Finché il sistema è piccolo rispetto alla lunghezza d onda e i tempi di propagazione sono trascurabili, il modello a parametri concentrati funziona bene. Quando non è più così, tensione e corrente iniziano a propagarsi nello spazio, compaiono riflessioni e il layout diventa parte attiva del comportamento."},
    {"title":"Campo, flusso e induzione","content":"Molti effetti utili o fastidiosi dell elettronica nascono dall accoppiamento tra campi e conduttori. L induzione spiega trasformatori e motori, ma anche cross-talk, loop parassiti e sensibilità ai disturbi. Qui il pensiero di campo diventa strumento pratico di design."},
    {"title":"Integrità del segnale e compatibilità elettromagnetica","content":"Un segnale veloce non è solo una forma d onda ideale: è un fenomeno elettromagnetico che viaggia con un percorso di ritorno. Se interrompi il ritorno o crei geometrie cattive, aumenti emissioni, suscettibilità e degrado del segnale. EMI/EMC sono architettura fisica del sistema."},
    {"title":"Dal campo all attuatore","content":"Motori, attuatori magnetici, sensori Hall, induttanze e sistemi RF mostrano che l elettromagnetismo è anche una via di conversione tra energia, informazione e movimento. Chi lo capisce legge meglio power electronics, embedded e meccatronica."}
  ]'::jsonb,
  formulas = '[
    {"label":"Faraday","expression":"emf = - d Phi_B / dt","note":"La variazione del flusso magnetico induce tensione."},
    {"label":"Ampere intuition","expression":"oint B · dl = mu I_enc","note":"La corrente genera campo magnetico lungo il percorso chiuso."},
    {"label":"Wave speed intuition","expression":"v = 1 / sqrt(mu epsilon)","note":"La propagazione elettromagnetica dipende dal mezzo."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT OCW - Electricity and Magnetism","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"EMC Fundamentals","url":"https://learnemc.com/","type":"handbook","source":"LearnEMC"},
    {"title":"Electromagnetism visual intuition","url":"https://www.youtube.com/results?search_query=electromagnetism+visual+intuition","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"signal-wave","title":"Segnale come campo","caption":"Un segnale veloce si propaga con campo e percorso di ritorno, non solo come numero su un filo."},
    {"kind":"circuit-loop","title":"Loop e accoppiamento","caption":"La geometria del loop decide quanta energia emetti, ricevi o perdi."}
  ]'::jsonb
where slug = 'electromagnetism-and-fields';

update public.topics
set
  estimated_minutes = 29,
  overview = 'Termodinamica e trasferimento di calore diventano seri quando smetti di pensarli come capitolo isolato e inizi a vederli come vincolo architetturale su ogni sistema reale. Batterie, attuatori, elettronica di potenza, strutture, fluidi e processi industriali vivono dentro bilanci di energia che impongono limiti, tempi caratteristici e rischi di failure.

Il punto chiave non è solo sapere che l energia si conserva, ma capire dove va, con che efficienza si converte, quanto rapidamente si accumula o si disperde e quali gradienti produce. Molti problemi di affidabilità non nascono dal regime nominale, ma da hot spot, cicli termici, inefficienze locali e cattiva gestione delle transizioni.

Questo topic porta la termica fuori dal ruolo di post-fix e la rende parte del modello di sistema.',
  key_takeaways = array[
    'Ogni sistema reale ha un bilancio energetico che limita prestazioni e durata.',
    'Conduzione, convezione e irraggiamento agiscono spesso insieme e su scale diverse.',
    'Transienti termici e hot spot sono spesso più pericolosi delle temperature medie.',
    'Pensare in resistenze e capacità termiche aiuta a modellare comportamento e margini.'
  ],
  study_blocks = '[
    {"title":"Bilanci di energia","content":"La domanda giusta non è solo quanta potenza entra, ma dove finisce. In ogni sistema energia utile, perdite, accumulo interno e scambio con l ambiente convivono. Un bilancio ben fatto aiuta a prevedere prestazioni, autonomia, warm-up, cooldown e failure termici."},
    {"title":"Conduzione, convezione, irraggiamento","content":"Il calore si muove per meccanismi diversi e spesso simultanei. Un buon engineer sa quando domina il contatto solido, quando il fluido esterno controlla lo scambio e quando la radiazione non è più trascurabile. Il design termico nasce da questa lettura multi-meccanismo."},
    {"title":"Transitori e reti termiche","content":"Le temperature non cambiano istantaneamente. Modelli a capacità e resistenza termica permettono di intuire tempi di risposta, accumulo locale e differenze tra picco e regime stazionario. Questo è cruciale per elettronica di potenza, batterie, attuatori e sistemi ciclici."},
    {"title":"Termica come safety e prestazione","content":"Una cattiva architettura termica degrada efficienza, precisione, durata e sicurezza. Gestione dei gradienti, scelta materiali, interfacce termiche, airflow e controllo della potenza sono parte del sistema, non accessori finali."}
  ]'::jsonb,
  formulas = '[
    {"label":"Heat equation intuition","expression":"Q_dot = -k A dT/dx","note":"La conduzione cresce con conducibilità, area e gradiente termico."},
    {"label":"Convection","expression":"Q_dot = h A (T_s - T_inf)","note":"Lo scambio convettivo dipende da coefficiente, area e differenza di temperatura."},
    {"label":"Thermal RC intuition","expression":"tau = R_th C_th","note":"La costante di tempo termica governa la velocità dei transitori."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT OCW - Thermodynamics and Heat Transfer","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"Heat transfer fundamentals","url":"https://www.youtube.com/results?search_query=heat+transfer+fundamentals","type":"video","source":"YouTube"},
    {"title":"NASA Thermal Control Overview","url":"https://www.nasa.gov/","type":"article","source":"NASA"}
  ]'::jsonb,
  visuals = '[
    {"kind":"pipeline-stages","title":"Percorso dell energia termica","caption":"Le perdite si generano localmente ma si propagano attraverso materiali, interfacce e ambiente."},
    {"kind":"trade-study","title":"Prestazione vs raffreddamento","caption":"Compattezza, silenzio, massa e margine termico raramente si ottengono insieme."}
  ]'::jsonb
where slug = 'thermodynamics-heat-transfer-and-energy-systems';

update public.topics
set
  estimated_minutes = 27,
  overview = 'La scienza dei materiali diventa utile quando collega microstruttura, ambiente e carico al comportamento osservabile del componente. Corrosione, cricche, creep, fatica, delaminazione e invecchiamento non sono sfortune casuali: emergono da meccanismi fisico-chimici che puoi spesso prevedere o almeno governare.

Molte decisioni di prodotto sembrano riguardare forma o prestazione immediata, ma falliscono mesi dopo per incompatibilità chimica, trattamenti sbagliati, cicli termici, ambienti aggressivi o processi produttivi che alterano la microstruttura. Qui nasce il vero valore di una lente materials-first.

Questo topic costruisce una visione più rigorosa di degrado, selezione materiali e progettazione per durata.',
  key_takeaways = array[
    'Le proprietà macroscopiche emergono da microstruttura, processo e ambiente.',
    'Corrosione e failure sono spesso il risultato di interazioni multi-fisiche e non di una sola causa.',
    'La selezione materiali deve includere fabbricazione, vita utile e ambiente operativo.',
    'Progettare per durata richiede anticipare meccanismi di danno, non solo resistenza nominale.'
  ],
  study_blocks = '[
    {"title":"Materiale come sistema","content":"Un materiale non è solo un numero di modulo elastico o conducibilità. È una struttura con fasi, difetti, grani, interfacce e storia di processo. Questa storia determina come il componente risponde a carico, temperatura, umidità e tempo."},
    {"title":"Corrosione e interazione con l ambiente","content":"Molti fallimenti nascono dall ambiente: umidità, sali, potenziali elettrochimici, solventi, UV o temperatura. La corrosione diventa quindi un problema di design del sistema, delle interfacce e dei trattamenti, non solo del materiale base."},
    {"title":"Fatigue, creep e danno progressivo","content":"Un componente può fallire a carichi molto inferiori al carico massimo statico se il tempo o i cicli sono la variabile dominante. Fatica e creep insegnano a pensare in accumulo di danno, non solo in resistenza istantanea."},
    {"title":"Dal datasheet alla vita reale","content":"I dati di targa servono poco se ignori processi produttivi, saldature, rivestimenti, tolleranze e ambiente reale. La progettazione matura combina selezione materiali, validazione sperimentale e analisi dei meccanismi di failure."}
  ]'::jsonb,
  formulas = '[
    {"label":"Stress-life intuition","expression":"sigma_a^m N = C","note":"Forma qualitativa per ricordare il tradeoff tra ampiezza di sforzo e vita a fatica."},
    {"label":"Corrosion rate intuition","expression":"rate prop current density","note":"La velocità di corrosione cresce con i processi elettrochimici attivi."},
    {"label":"Creep intuition","expression":"epsilon_dot prop sigma^n e^(-Q/RT)","note":"Il creep dipende da sforzo e temperatura su tempi lunghi."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT OCW - Materials Science","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"ASM Materials failure resources","url":"https://www.asminternational.org/","type":"handbook","source":"ASM"},
    {"title":"Fatigue and failure basics","url":"https://www.youtube.com/results?search_query=fatigue+failure+materials+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"complexity-scale","title":"Dal difetto al failure","caption":"Microstruttura, ambiente e carico si sommano fino a generare danni macroscopici."},
    {"kind":"trade-study","title":"Prestazione vs durata","caption":"Il materiale migliore in prestazione specifica non è sempre il migliore in producibilità o vita utile."}
  ]'::jsonb
where slug = 'materials-chemistry-corrosion-and-failure';

update public.topics
set
  estimated_minutes = 28,
  overview = 'La meccatronica è l arte di progettare sistemi che non possono essere capiti separando meccanica, elettronica, sensing, software e controllo. Appena un prodotto deve percepire, decidere e agire nel mondo fisico, nasce un problema cyber-physical: ritardi, quantizzazione, attrito, flessibilità, rumore, saturazioni e failure si distribuiscono su più domini contemporaneamente.

Il salto progettuale non è saper costruire ogni sottosistema da solo, ma saperli integrare senza che si danneggino a vicenda. Un controllo aggressivo su meccanica cedevole, un cablaggio rumoroso su sensori deboli o una struttura rigida ma termicamente instabile possono compromettere tutto il sistema.

Questo topic sposta il focus dall ottimizzazione locale all integrazione architetturale.',
  key_takeaways = array[
    'I sistemi meccatronici falliscono spesso nelle interfacce tra domini, non nei singoli blocchi.',
    'L integrazione cyber-physical richiede budget di latenza, energia, rigidità, rumore e potenza.',
    'Sensing, attuazione e software vanno co-progettati con struttura e dinamica meccanica.',
    'Una buona architettura separa livelli ma mantiene coerenza tra fisica e controllo.'
  ],
  study_blocks = '[
    {"title":"Perché l integrazione è difficile","content":"Ogni dominio porta tempi caratteristici e limiti diversi. La meccanica ha inerzia e compliance, l elettronica ha banda e rumore, il software introduce campionamento e scheduling, il controllo vive di modelli approssimati. La meccatronica è il punto in cui questi tempi devono convivere senza produrre instabilità o inefficienza."},
    {"title":"Interfacce vere, non solo connettori","content":"Tra due sottosistemi non scambiamo solo segnali: scambiamo energia, vincoli, rumore e aspettative di temporizzazione. Per questo un interfaccia meccatronica ben progettata include alimentazione, massa, timing, sensori, safety states e fallback, non solo pinout."},
    {"title":"Budget e compromessi","content":"Ogni sistema integrato vive dentro budget: potenza disponibile, latenza ammessa, massa, rigidezza, costo computazionale, precisione sensoriale. Il design maturo non massimizza un singolo asse, ma distribuisce margine in modo coerente con la missione del prodotto."},
    {"title":"Verification di sistema","content":"La meccatronica si verifica bene solo chiudendo il loop tra simulazione, prototipi e test sul campo. Hardware-in-the-loop, logging, test di fault e osservabilità del sistema diventano essenziali per capire se l integrazione regge davvero."}
  ]'::jsonb,
  formulas = '[
    {"label":"Sampled control intuition","expression":"f_s >> f_system","note":"Il campionamento deve essere sufficientemente rapido rispetto alla dinamica dominante."},
    {"label":"Mechanical power","expression":"P = tau omega","note":"La conversione elettromeccanica lega coppia e velocità alla potenza utile."},
    {"label":"Latency budget intuition","expression":"T_total = T_sensor + T_compute + T_actuation","note":"La latenza totale nasce dalla somma delle fasi della pipeline."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT Mechatronics resources","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"Underactuated Robotics","url":"https://underactuated.mit.edu/","type":"handbook","source":"MIT"},
    {"title":"Mechatronics design overview","url":"https://www.youtube.com/results?search_query=mechatronics+design+overview","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"interface-contract","title":"Interfaccia cyber-physical","caption":"Ogni blocco scambia segnali, energia, timing e vincoli con gli altri domini."},
    {"kind":"verification-stack","title":"Validation loop","caption":"Simulazione, bench test e field test devono chiudersi sullo stesso modello di sistema."}
  ]'::jsonb
where slug = 'mechatronics-integration-and-cyber-physical-design';
