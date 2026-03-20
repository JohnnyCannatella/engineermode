update public.topics
set
  estimated_minutes = 29,
  overview = 'Computer systems e reti diventano davvero interessanti quando smetti di vederli come livelli separati e inizi a seguirne il flusso completo: istruzioni, memoria, kernel, processi, IO, stack di rete e timing. Un software system credibile non vive solo nel codice applicativo, ma nell interazione continua tra hardware, sistema operativo e comunicazione.

La domanda matura non e solo “funziona?”, ma “dove spende tempo, dove spende memoria, dove blocca, dove perde isolamento, dove degrada sotto carico?”. Cache, scheduler, syscall, copie di memoria, interrupt, socket e buffering sono il vero terreno su cui performance e affidabilita si decidono.

Questo topic ti porta dal modello alto livello di computer e reti fino alla lettura sistemica di latenza, throughput, isolamento e fault propagation.',
  key_takeaways = array[
    'CPU, memoria, kernel e rete cooperano in una pipeline unica di esecuzione.',
    'Prestazione e affidabilita dipendono da scheduling, IO e gestione della memoria, non solo dall algoritmo.',
    'La rete introduce latenza, perdita e variabilita che cambiano il design software.',
    'Capire il percorso dei dati aiuta a progettare sistemi piu debuggabili e robusti.'
  ],
  study_blocks = '[
    {"title":"Dal processo alla macchina","content":"Ogni processo vive sopra una astrazione che nasconde dettagli fisici, ma quei dettagli contano. Contesto di esecuzione, stack, heap, page table, cache e syscall determinano tempo di risposta, isolamento e costo reale delle operazioni. Il software forte sa dove termina l illusione dell API semplice e dove inizia il comportamento del sistema."},
    {"title":"Memoria, concorrenza e IO","content":"Molti colli di bottiglia non sono computazionali ma di movimento dati. File system, socket, copie kernel-user, sincronizzazione, lock contention e cache invalidation cambiano drasticamente throughput e latenza. Per questo progettare bene richiede seguire il dato mentre attraversa memoria, disco e rete."},
    {"title":"Stack di rete come dinamica","content":"Una richiesta distribuita non attraversa solo endpoint logici ma code, buffer, politiche di ritrasmissione, handshake e scheduling di rete. RTT, jitter, packet loss e congestione non sono dettagli esterni: sono parte della semantica temporale del tuo sistema."},
    {"title":"Leggere il sistema sotto carico","content":"Un sistema sano a vuoto puo crollare quando carico, concorrenza e failure si combinano. Qui diventano cruciali profiling, metriche di coda, osservabilita, limiti di risorse e architettura di degrado, per evitare che un singolo collo di bottiglia diventi failure globale."}
  ]'::jsonb,
  formulas = '[
    {"label":"Little law intuition","expression":"L = lambda W","note":"Collega richieste in sistema, throughput e tempo medio di permanenza."},
    {"label":"Bandwidth-delay product","expression":"BDP = bandwidth * RTT","note":"Aiuta a intuire quanto dato può stare “in volo” su un collegamento."},
    {"label":"CPU utilization intuition","expression":"U = busy_time / total_time","note":"Una saturazione apparente va letta insieme a waiting, IO e scheduling."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT 6.033 Computer System Engineering","url":"https://ocw.mit.edu/courses/6-033-computer-system-engineering-spring-2018/","type":"video","source":"MIT OpenCourseWare"},
    {"title":"Operating Systems: Three Easy Pieces","url":"https://pages.cs.wisc.edu/~remzi/OSTEP/","type":"handbook","source":"University of Wisconsin"},
    {"title":"Stanford CS144 Computer Networking","url":"https://cs144.github.io/","type":"handbook","source":"Stanford"}
  ]'::jsonb,
  visuals = '[
    {"kind":"memory-map","title":"Percorso del dato","caption":"Il dato attraversa memoria, kernel, buffer e rete prima di sembrare una semplice chiamata API."},
    {"kind":"osi-stack","title":"Stack operativo","caption":"Ogni livello aggiunge utilità ma anche latenza, buffering e failure modes."}
  ]'::jsonb
where slug = 'computer-systems-and-networks';

update public.topics
set
  estimated_minutes = 31,
  overview = 'Dati, algoritmi e architettura distribuita si incontrano quando smetti di pensare in funzioni isolate e inizi a ragionare in stato condiviso, partizionamento, consistenza, complessita e recovery. La domanda non e solo come calcolare bene, ma come farlo quando il dato e grande, distribuito, concorrente e sotto failure.

Le strutture dati ti dicono come accedi all informazione. Gli algoritmi ti dicono quanto costa trasformarla. L architettura distribuita ti impone invece domande piu dure: dove vive lo stato, come converge, chi coordina, cosa succede sotto partizione, quali letture possono essere stale e quali no.

Questo topic costruisce una lettura unificata di complessita computazionale e complessita sistemica.',
  key_takeaways = array[
    'La struttura del dato condiziona sia complessita algoritmica sia scalabilita architetturale.',
    'Lo stato distribuito richiede compromessi espliciti tra latenza, coerenza e disponibilita.',
    'Replication, sharding e caching spostano il problema: non lo eliminano.',
    'Un sistema distribuito forte definisce cosa puo divergere, per quanto e con quali garanzie di recovery.'
  ],
  study_blocks = '[
    {"title":"Strutture dati come interfaccia al costo","content":"Array, alberi, hash table, heap e grafi non sono solo astrazioni scolastiche. Decidono latenza di accesso, pattern di memoria, facilità di ordinamento, merge, scansione e aggiornamento concorrente. Questa scelta locale si propaga fino al comportamento globale del sistema."},
    {"title":"Dal singolo nodo al cluster","content":"Appena il dataset o il traffico crescono, entra in gioco la distribuzione. Replicare, partizionare o cacheare significa ridistribuire costo, rischio e complessità. Il problema si sposta da “come calcolo?” a “dove vive il dato e chi lo considera vero?”."},
    {"title":"Concorrenza, consistenza e fault","content":"Transazioni, quorum, log append-only, leader election e reconciliation sono modi diversi di proteggere il significato del dato nel tempo. La parte difficile non è conoscere i nomi, ma capire in quali domini serve consistenza forte e dove invece è più razionale accettare convergenza controllata."},
    {"title":"Complessità reale","content":"Un algoritmo O(log n) inserito in un sistema con retry, serializzazione, storage remoto e coordinazione tra nodi può costare molto più di quanto suggerisca la teoria locale. L engineer maturo tiene insieme analisi asintotica e costo architetturale end-to-end."}
  ]'::jsonb,
  formulas = '[
    {"label":"Asymptotic intuition","expression":"T(n) = O(f(n))","note":"La crescita del costo dipende dalla dimensione del problema, ma non racconta da sola il costo distribuito."},
    {"label":"Availability intuition","expression":"A approx MTBF / (MTBF + MTTR)","note":"Disponibilità dipende sia da quanto raramente fallisci sia da quanto velocemente recuperi."},
    {"label":"Replication latency intuition","expression":"T_commit >= max(network, coordination, storage)","note":"Il commit distribuito eredita il costo del componente più lento nel percorso critico."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT 6.006 Introduction to Algorithms","url":"https://ocw.mit.edu/courses/6-006-introduction-to-algorithms-fall-2011/","type":"video","source":"MIT OpenCourseWare"},
    {"title":"Designing Data-Intensive Applications","url":"https://dataintensive.net/","type":"handbook","source":"O Reilly"},
    {"title":"MIT 6.824 Distributed Systems","url":"https://pdos.csail.mit.edu/6.824/","type":"handbook","source":"MIT"}
  ]'::jsonb,
  visuals = '[
    {"kind":"binary-tree","title":"Costo locale vs globale","caption":"Una buona struttura dati locale non garantisce da sola una buona architettura distribuita."},
    {"kind":"trade-study","title":"Consistency tradeoff","caption":"Coordinazione, latenza e disponibilità si redistribuiscono a ogni scelta di replica e commit."}
  ]'::jsonb
where slug = 'data-algorithms-and-distributed-architecture';

update public.topics
set
  estimated_minutes = 30,
  overview = 'L elettronica di potenza è il punto in cui energia e controllo si incontrano davvero. Convertitori DC-DC, inverter, driver di motori e attuazione elettromeccanica non trattano la corrente come quantità astratta, ma come flusso energetico che deve essere modulato con efficienza, stabilità termica e margine di sicurezza.

Il nodo concettuale forte è che commutare potenza significa sempre negoziare tra perdite di conduzione, perdite di switching, EMI, dimensione dei passivi, risposta dinamica e controllo del carico. Un buon schema non basta: serve leggere loop di corrente, percorsi di energia, transienti e failure modes.

Questo topic collega conversione di potenza, attuazione e comportamento reale del sistema sotto carico.',
  key_takeaways = array[
    'Un convertitore di potenza è una macchina di tradeoff tra efficienza, dinamica, EMI e massa.',
    'MOSFET, induttori, condensatori e controllo lavorano come un unico sottosistema energetico.',
    'L attuazione elettrica va letta insieme a carico meccanico, termica e sensing.',
    'Transienti, loop parasitici e layout sono centrali quanto lo schema elettrico.'
  ],
  study_blocks = '[
    {"title":"Conversione come gestione del flusso energetico","content":"Buck, boost, inverter e driver non fanno solo “cambiare tensione”. Spostano energia nel tempo usando switch, campi magnetici e capacità di accumulo. Per questo il loro comportamento dipende tanto dalla topologia quanto dal modo in cui controlli la commutazione."},
    {"title":"Perdite, EMI e passivi","content":"Ogni incremento di frequenza può ridurre dimensioni dei passivi ma aumentare perdite di switching e problemi elettromagnetici. Ogni scelta di MOSFET, gate drive, induttanza e layout redistribuisce efficienza, temperatura, ripple e rumore."},
    {"title":"Dal convertitore all attuatore","content":"Quando la potenza alimenta un motore o un attuatore, il problema diventa elettromeccanico. Corrente, coppia, back-EMF, inerzia del carico e controllo della corrente chiudono un loop tra energia elettrica e dinamica meccanica."},
    {"title":"Robustezza di sistema","content":"Undervoltage, overcurrent, dead time, shoot-through, saturazione magnetica e thermal derating sono failure modes da progettare in anticipo. La power electronics buona è quella che sopravvive bene ai transitori e degrada con logica chiara."}
  ]'::jsonb,
  formulas = '[
    {"label":"Average power","expression":"P = V I","note":"Base per leggere bilanci di potenza e perdite."},
    {"label":"Inductor law","expression":"V_L = L di/dt","note":"L induttore lega tensione applicata e velocità di variazione della corrente."},
    {"label":"Motor torque intuition","expression":"tau prop k_t I","note":"La corrente controllata si riflette direttamente nella coppia disponibile."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT OCW - Power Electronics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"Wurth Elektronik - DC/DC Handbook","url":"https://www.we-online.com/en/support/knowledge","type":"handbook","source":"Wurth Elektronik"},
    {"title":"Power electronics basics","url":"https://www.youtube.com/results?search_query=power+electronics+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"circuit-loop","title":"Switching power loop","caption":"Il percorso di corrente impulsiva decide ripple, perdita e rumore irradiato."},
    {"kind":"trade-study","title":"Efficienza vs dinamica","caption":"Più velocità di risposta e più compattezza spesso costano margine termico o EMI."}
  ]'::jsonb
where slug = 'power-electronics-and-actuation';

update public.topics
set
  estimated_minutes = 31,
  overview = 'Controllo a retroazione e real-time embedded diventano seri quando il software smette di essere solo logica e diventa parte della dinamica del sistema. Sampling, latenza, jitter, quantizzazione, interrupt e scheduling alterano direttamente stabilità, prestazioni e robustezza del loop.

Il punto chiave è che un controller non vive su carta: gira su hardware limitato, con sensori rumorosi, attuatori saturabili e tempi di esecuzione finiti. Questo rende il design real-time inseparabile dal controllo. Se perdi il budget temporale, cambi il comportamento fisico del sistema.

Questo topic unisce retroazione, embedded software e temporizzazione operativa in una singola lente.',
  key_takeaways = array[
    'Ogni loop di controllo reale è vincolato da frequenza di campionamento, latenza e jitter.',
    'Software embedded e dinamica fisica si influenzano a vicenda.',
    'Interrupt, scheduler e DMA sono parti del comportamento di controllo, non solo dell implementazione.',
    'Un sistema real-time robusto definisce priorità, margini e fallback sotto overload.'
  ],
  study_blocks = '[
    {"title":"Dal continuo al campionato","content":"Quando un controller passa dal modello continuo al firmware, entrano campionamento, zero-order hold, ritardo di calcolo e quantizzazione. Anche un buon controllo può degradare se il loop digitale è troppo lento o irregolare rispetto alla dinamica fisica."},
    {"title":"Tempi reali, non solo tempi medi","content":"Nel real-time non basta che il codice sia veloce in media. Conta il worst-case, la variabilità, la priorità tra task e l impatto di interrupt e accessi periferici. Il sistema fisico sente il ritardo peggiore, non il benchmark più bello."},
    {"title":"Embedded architecture del loop","content":"ADC, sensori, DMA, filtri, task di controllo, attuazione PWM e diagnostica devono concatenarsi con timing pulito. Una pipeline ben progettata rende il loop osservabile, stabile e debuggabile; una cattiva produce jitter invisibile e comportamento erratico."},
    {"title":"Safety e degradazione","content":"Se il microcontrollore è saturo, se un sensore salta o se il loop perde deadline, il sistema deve sapere cosa fare. Watchdog, limp modes, fallback a open-loop controllato e limiti di coppia sono elementi di architettura, non patch finali."}
  ]'::jsonb,
  formulas = '[
    {"label":"Sampling heuristic","expression":"f_s >= 10 f_bw","note":"Regola pratica per mantenere un loop digitale sufficientemente più rapido della banda controllata."},
    {"label":"Deadline budget","expression":"T_loop = T_acq + T_compute + T_act","note":"Il tempo totale del loop nasce dalla somma delle fasi del percorso critico."},
    {"label":"Discrete update intuition","expression":"x[k+1] = A_d x[k] + B_d u[k]","note":"Il controllo digitale opera su dinamica discretizzata."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT OCW - Feedback Systems","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"Real-Time Systems notes","url":"https://www.cs.cmu.edu/~410-s07/p4/p4.html","type":"article","source":"CMU"},
    {"title":"Embedded control basics","url":"https://www.youtube.com/results?search_query=embedded+control+systems+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"pid-controller","title":"Loop digitale","caption":"Misura, calcolo e attuazione vivono dentro una pipeline temporale che modifica il controllo reale."},
    {"kind":"verification-stack","title":"Real-time verification","caption":"Analisi temporale, test su bench e fault injection servono a validare il loop embedded."}
  ]'::jsonb
where slug = 'feedback-control-and-real-time-embedded';

update public.topics
set
  estimated_minutes = 29,
  overview = 'Le batterie sono sistemi elettrochimici accoppiati a termica, potenza e controllo. La loro utilità progettuale non si esaurisce in energia nominale e tensione media: contano resistenza interna, limiti di corrente, stato di carica, stato di salute, sicurezza, raffreddamento e strategia di gestione del pack.

Il vero salto mentale è passare dalla cella al battery system. Un pack reale introduce bilanciamento, mismatch tra celle, busbar, sensori, protezioni, BMS, contattori e logiche di derating. Qui capacità, potenza e durata diventano proprietà emergenti dell intero sistema, non numeri di brochure.

Questo topic porta l elettrochimica dentro l architettura energetica del prodotto.',
  key_takeaways = array[
    'La prestazione della batteria dipende da corrente, temperatura e strategia di gestione, non solo dalla capacità nominale.',
    'State of charge e state of health sono stime, non misure perfette.',
    'Il pack battery è un sistema con protezioni, sensing, termica e policy di utilizzo.',
    'Ageing, lithium plating e runaway termico vanno anticipati come rischi di sistema.'
  ],
  study_blocks = '[
    {"title":"Dalla chimica alla curva di scarica","content":"Una cella ha una tensione apparente che cambia con stato di carica, corrente, temperatura e chimica interna. La curva di scarica non è solo una caratteristica di marketing: determina autonomia utile, stabilità sotto carico e facilità di stima del SOC."},
    {"title":"Potenza, resistenza interna e calore","content":"Quando chiedi corrente, emergono drop interni e generazione di calore. La cella diventa così un problema contemporaneamente elettrochimico e termico. Il limite non è solo quanta energia hai, ma quanto rapidamente puoi estrarla o rigenerarla senza degradare il sistema."},
    {"title":"Dal cell al pack","content":"Serie e parallelo aumentano tensione e capacità, ma introducono mismatch, balancing, protezioni e failure di interconnessione. Il BMS esiste per stimare, proteggere e coordinare il pack, non solo per leggere tensioni."},
    {"title":"Degrado e safety lifecycle","content":"Calendar ageing, cycle ageing, stress termico, sovraccarica, undervoltage e runaway impongono margini operativi. Un design battery-first definisce limiti, raffreddamento, telemetry e policy di utilizzo già in fase architetturale."}
  ]'::jsonb,
  formulas = '[
    {"label":"Energy estimate","expression":"E approx V_nom Ah","note":"Stima utile ma incompleta della capacità energetica disponibile."},
    {"label":"Joule heating","expression":"P_loss = I^2 R","note":"Le perdite interne crescono quadraticamente con la corrente."},
    {"label":"C-rate","expression":"C_rate = I / Capacity","note":"Normalizza la corrente rispetto alla capacità nominale della cella o del pack."}
  ]'::jsonb,
  "references" = '[
    {"title":"Battery University","url":"https://batteryuniversity.com/","type":"handbook","source":"Battery University"},
    {"title":"MIT Electrochemical Energy Systems","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"BMS basics","url":"https://www.youtube.com/results?search_query=battery+management+system+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"trade-study","title":"Energia vs potenza vs vita","caption":"Chiedere più potenza oggi può costare temperatura, degrado e autonomia futura."},
    {"kind":"verification-stack","title":"Battery system stack","caption":"Cella, modulo, pack, BMS e termica devono essere validati come un unico sistema."}
  ]'::jsonb
where slug = 'electrochemistry-batteries-and-degradation';

update public.topics
set
  estimated_minutes = 27,
  overview = 'Comunicazione, informazione e codifica contano davvero quando il dato deve attraversare canali rumorosi, reti congestionate o bus embedded sotto vincoli di energia e latenza. Non basta spedire bit: bisogna capire quanta informazione utile sopravvive, quanta ridondanza conviene introdurre e come si bilanciano throughput, errori e ritardo.

Il punto ingegneristico forte è che ogni scelta di protocollo o codifica modifica il comportamento del sistema: più ridondanza aumenta robustezza ma costa banda e tempo; meno ridondanza riduce overhead ma espone il controllo e la coordinazione a errori o perdita di pacchetti.

Questo topic ti abitua a leggere la comunicazione come budget di informazione e affidabilità.',
  key_takeaways = array[
    'Informazione utile e bit trasmessi non coincidono sempre.',
    'Ridondanza e codifica sono strumenti di robustezza con costi reali di latenza e banda.',
    'Canale, protocollo e applicazione vanno progettati insieme nei sistemi cyber-fisici.',
    'Jitter, perdita e corruzione dei dati possono alterare direttamente controllo e coordinazione.'
  ],
  study_blocks = '[
    {"title":"Dal simbolo al significato","content":"Trasmettere dati non significa solo muovere sequenze binarie. Serve preservare significato sotto rumore, sincronizzazione incerta e errori di interpretazione. Per questo framing, clock recovery, codifica e verifica di integrità sono parti di uno stesso problema."},
    {"title":"Ridondanza come scelta progettuale","content":"Checksum, CRC, FEC e ritrasmissione aumentano robustezza ma cambiano tempo e costo del canale. La domanda giusta non è “più protezione possibile?”, ma quale livello di protezione serve davvero per il dominio applicativo e il suo rischio operativo."},
    {"title":"Banda, latenza e affidabilità","content":"In telemetria, controllo distribuito o bus embedded, il valore del dato dipende dal fatto che arrivi entro una finestra temporale utile. Un pacchetto perfetto ma in ritardo può essere meno utile di uno leggermente rumoroso ma tempestivo."},
    {"title":"Architetture comunicative mature","content":"I sistemi forti definiscono gerarchie di dato: cosa è critico, cosa è loss-tolerant, cosa richiede conferma, cosa può essere campionato o compresso. Questo trasforma la comunicazione da dettaglio infrastrutturale a parte del design di sistema."}
  ]'::jsonb,
  formulas = '[
    {"label":"Shannon intuition","expression":"C = B log2(1 + S/N)","note":"Capacità teorica del canale come funzione di banda e rapporto segnale-rumore."},
    {"label":"Bit rate","expression":"R_b = symbols_per_sec * bits_per_symbol","note":"La velocità dipende sia dal clock simbolico sia dall informazione per simbolo."},
    {"label":"Packet success intuition","expression":"P_success = (1 - BER)^N","note":"La probabilità di successo cala con la lunghezza del pacchetto se il BER resta fisso."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT OCW - Information Theory","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"Stanford EE376A Information Theory","url":"https://web.stanford.edu/class/ee376a/","type":"article","source":"Stanford"},
    {"title":"Communication systems basics","url":"https://www.youtube.com/results?search_query=communication+systems+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"osi-stack","title":"Dato protetto","caption":"Ogni strato contribuisce a integrità, latenza e recupero dell informazione."},
    {"kind":"signal-wave","title":"Canale rumoroso","caption":"La qualità della comunicazione dipende da banda, rumore, codifica e tempo utile del dato."}
  ]'::jsonb
where slug = 'communication-information-and-encoding';
