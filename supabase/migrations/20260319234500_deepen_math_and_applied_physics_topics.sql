update public.topics
set
  estimated_minutes = 30,
  overview = 'Calcolo e algebra lineare diventano davvero utili quando smetti di trattarli come prerequisiti astratti e li usi per descrivere sistemi che cambiano, si accoppiano e si trasformano. Derivate, integrali, matrici, autovalori, basi e trasformazioni lineari non sono un capitolo preparatorio: sono il linguaggio con cui leggi dinamica, controllo, simulazione, computer vision, robotica e power systems.

Il passaggio importante è riconoscere che quasi tutti i sistemi seri smettono presto di essere monovariabili. Appena hai più stati, più sensori o più attuatori, ti servono vettori e matrici per vedere struttura, direzioni dominanti, accoppiamenti e modi propri. Qui l algebra lineare non è scorciatoia notazionale, ma strumento di pensiero.

Questo topic trasforma la matematica da filtro accademico a kit operativo per modellare e ragionare.',
  key_takeaways = array[
    'Derivata e integrale descrivono variazione e accumulo nei sistemi reali.',
    'Vettori e matrici rendono leggibili sistemi multivariabili e trasformazioni di coordinate.',
    'Autovalori e autovettori aiutano a capire modi dominanti, stabilità e dinamiche accoppiate.',
    'La matematica forte serve a comprimere complessità fisica in modelli maneggevoli.'
  ],
  study_blocks = '[
    {"title":"Derivate come sensibilità","content":"La derivata non è solo pendenza di una curva, ma misura locale di sensibilità. Ti dice quanto una grandezza reagisce a un cambiamento di un altra. In controllo, termica, fluidi e meccanica, questa lettura è essenziale per capire se un sistema è lento, rigido, instabile o ben condizionato."},
    {"title":"Integrali come memoria e bilancio","content":"L integrale accumula effetti nel tempo e nello spazio. Energia assorbita, errore cumulato, flusso totale, carica immagazzinata e massa trasferita vivono tutti in una logica integrale. Questo è il ponte tra fisica di conservazione e calcolo."},
    {"title":"Spazi vettoriali e trasformazioni","content":"Appena un sistema ha più variabili, la geometria dello spazio delle soluzioni conta. Matrici e trasformazioni lineari permettono di vedere rotazioni, proiezioni, cambi di base e dinamiche accoppiate. Un problema che in scalare sembra confuso spesso diventa pulito quando lo esprimi nella base giusta."},
    {"title":"Autovalori, modi e struttura","content":"Gli autovalori rivelano tempi caratteristici, stabilità e dinamiche dominanti. In pratica sono un modo potente per capire quali parti del sistema guidano davvero il comportamento e quali invece sono effetti secondari o veloci."}
  ]'::jsonb,
  formulas = '[
    {"label":"Derivative","expression":"df/dx = lim (Delta f / Delta x)","note":"Misura locale della variazione di una funzione rispetto a una variabile."},
    {"label":"Linear map","expression":"y = A x","note":"Una matrice rappresenta come un vettore viene trasformato in un altro."},
    {"label":"Eigenvalue relation","expression":"A v = lambda v","note":"Identifica direzioni che la trasformazione conserva cambiando solo scala."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT 18.06 Linear Algebra","url":"https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/","type":"video","source":"MIT OpenCourseWare"},
    {"title":"MIT Calculus resources","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"3Blue1Brown - Essence of Linear Algebra","url":"https://www.3blue1brown.com/topics/linear-algebra","type":"video","source":"3Blue1Brown"}
  ]'::jsonb,
  visuals = '[
    {"kind":"state-machine","title":"Sistema come vettore","caption":"Lo stato di un sistema complesso si legge meglio come punto in uno spazio, non come lista sparsa di numeri."},
    {"kind":"trade-study","title":"Base giusta, problema giusto","caption":"Cambiare rappresentazione può rendere evidente una struttura che prima sembrava opaca."}
  ]'::jsonb
where slug = 'engineering-math-calculus-and-linear-algebra';

update public.topics
set
  estimated_minutes = 29,
  overview = 'Probabilità e incertezza diventano serie quando smetti di usarle solo per descrivere dispersione e inizi a usarle per decidere sotto informazione incompleta. Sensori rumorosi, modelli sbagliati, eventi rari, drift di componenti, dati parziali e ambienti imprevedibili trasformano ogni misura in una stima con confidenza, non in un valore assoluto.

Il punto forte non è ricordare formule isolate, ma capire cosa puoi credere, con quale margine e con quale costo di errore. Distribuzioni, covarianze, posteriori, errori di classificazione e code rare definiscono spesso il rischio reale più di quanto faccia il caso medio.

Questo topic ti abitua a ragionare in termini di fiducia, rischio e decisione robusta.',
  key_takeaways = array[
    'Una misura è sempre un numero accompagnato da incertezza, bias e variabilità.',
    'Varianza, covarianza e distribuzione cambiano il significato operativo dei dati.',
    'Gli eventi rari possono dominare rischio e safety più del comportamento medio.',
    'Decisioni robuste richiedono stima della fiducia, non solo stima del valore.'
  ],
  study_blocks = '[
    {"title":"Incertezza come proprietà del sistema","content":"Rumore e variabilità non sono disturbi esterni separati dal progetto: sono parte del dominio. Un sensore, un attuatore o una rete producono dati che vanno interpretati insieme alla loro dispersione, al bias e alla dipendenza dal contesto operativo."},
    {"title":"Distribuzioni e code","content":"Sapere il valore medio non basta se le code della distribuzione sono pericolose. In affidabilità, safety e anomaly detection, gli eventi rari contano perché spesso sono proprio quelli che causano i guasti peggiori o i falsi allarmi più costosi."},
    {"title":"Covarianza e dipendenza","content":"Due errori che si muovono insieme raccontano una storia diversa da due errori indipendenti. La covarianza aiuta a leggere accoppiamenti tra sensori, variabili di stato e fonti di rumore, ed è per questo centrale in filtri, stima e data fusion."},
    {"title":"Decisione sotto rischio","content":"Ogni soglia, classificatore o protezione si muove tra falsi positivi e falsi negativi. Il design maturo non cerca solo accuratezza media, ma costo complessivo dell errore, confidenza della stima e degradazione ragionata fuori distribuzione."}
  ]'::jsonb,
  formulas = '[
    {"label":"Variance","expression":"sigma^2 = E[(x - mu)^2]","note":"Misura dispersione attorno al valore medio."},
    {"label":"Bayes theorem","expression":"p(H|D) = p(D|H) p(H) / p(D)","note":"Aggiorna la credenza in un ipotesi alla luce di nuovi dati."},
    {"label":"Covariance","expression":"cov(x,y) = E[(x-mu_x)(y-mu_y)]","note":"Misura come due variabili si muovono insieme."}
  ]'::jsonb,
  "references" = '[
    {"title":"Khan Academy - Probability and Statistics","url":"https://www.khanacademy.org/math/statistics-probability","type":"article","source":"Khan Academy"},
    {"title":"MIT Probability resources","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"StatQuest probability playlist","url":"https://www.youtube.com/results?search_query=statquest+probability","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"signal-wave","title":"Dato con incertezza","caption":"Una misura utile porta con sé rumore, bias e confidenza, non solo un valore nominale."},
    {"kind":"trade-study","title":"False positive vs false negative","caption":"Ogni decisione sotto incertezza sposta rischio tra tipi diversi di errore."}
  ]'::jsonb
where slug = 'probability-noise-and-uncertainty';

update public.topics
set
  estimated_minutes = 31,
  overview = 'Segnali, sistemi e trasformate sono il punto in cui domini diversi rivelano la stessa struttura: ingresso, dinamica, risposta, rumore e banda. Vibrazioni meccaniche, correnti, misure, dati di rete e traiettorie possono tutti essere letti come segnali che attraversano sistemi con memoria e filtraggio.

Il vero salto avviene quando impari a cambiare dominio: il tempo ti mostra evoluzione e transitorio, la frequenza ti mostra risonanze, attenuazioni, ritardi e accoppiamenti. La trasformata non è un esercizio elegante, ma un cambio di lente che rende leggibili fenomeni altrimenti confusi.

Questo topic rende segnali e sistemi una grammatica trasversale per elettronica, controllo, meccanica e sensing.',
  key_takeaways = array[
    'Tempo e frequenza descrivono lo stesso fenomeno da prospettive complementari.',
    'La risposta di un sistema dipende dalla sua dinamica e dalla banda delle sue componenti.',
    'Convoluzione, filtri e trasformate compaiono in quasi tutti i sistemi che trattano informazione fisica.',
    'Risonanze, rumore e ritardo diventano molto più chiari nel dominio giusto.'
  ],
  study_blocks = '[
    {"title":"Segnale come portatore di struttura","content":"Un segnale non è solo una sequenza di valori: contiene scale temporali, periodicità, eventi impulsivi, correlazioni e rumore. Capire quale parte del segnale rappresenta davvero il fenomeno fisico e quale invece è artefatto è il primo passo per qualsiasi sistema di misura o controllo."},
    {"title":"Sistemi lineari e risposta","content":"Molti sistemi utili si lasciano descrivere bene tramite risposta all impulso, convoluzione e funzione di trasferimento. Questo permette di prevedere come un ingresso verrà attenuato, ritardato, amplificato o deformato prima ancora di fare esperimenti completi."},
    {"title":"Dal tempo alla frequenza","content":"La frequenza rende evidenti banda utile, risonanza, rumore ad alta frequenza e ritardo di fase. Un sistema che nel tempo sembra solo oscillare “male” in frequenza può mostrare chiaramente il picco dominante o il filtro mancante."},
    {"title":"Dove diventa prodotto","content":"Filtri sensoriali, controllo, compressione, telecomunicazioni, vibrazioni strutturali e diagnostica predittiva condividono questa stessa lente. Chi padroneggia segnali e sistemi guadagna una lingua comune per leggere moltissimi problemi complessi."}
  ]'::jsonb,
  formulas = '[
    {"label":"Convolution","expression":"y(t) = x(t) * h(t)","note":"L output nasce dall ingresso filtrato dalla dinamica del sistema."},
    {"label":"Fourier transform","expression":"X(f) = integral x(t) e^(-j 2 pi f t) dt","note":"Rappresenta un segnale nel dominio delle frequenze."},
    {"label":"Transfer function","expression":"H(s) = Y(s) / X(s)","note":"Collega ingresso e uscita in forma compatta nel dominio trasformato."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT 6.003 Signals and Systems","url":"https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/","type":"video","source":"MIT OpenCourseWare"},
    {"title":"Signals and systems notes","url":"https://see.stanford.edu/Course/EE102","type":"article","source":"Stanford"},
    {"title":"3Blue1Brown - Fourier intuition","url":"https://www.3blue1brown.com/topics/fourier-transform","type":"video","source":"3Blue1Brown"}
  ]'::jsonb,
  visuals = '[
    {"kind":"signal-wave","title":"Tempo e frequenza","caption":"Lo stesso fenomeno mostra facce diverse a seconda del dominio in cui lo osservi."},
    {"kind":"feedback-loop","title":"Segnale nel loop","caption":"Ogni filtro o ritardo cambia ciò che il controllo può vedere e correggere."}
  ]'::jsonb
where slug = 'signals-systems-and-transforms';

update public.topics
set
  estimated_minutes = 30,
  overview = 'Trasporto di massa, fluidi e propulsione richiedono di leggere il sistema come scambio continuo di quantità di moto, pressione, portata, energia e miscelazione. Fluidi e gas non si limitano a “passare” dentro condotti: accumulano inerzia, dissipano energia, generano instabilità e cambiano radicalmente comportamento al variare di scala, geometria e regime di flusso.

Il punto ingegneristico forte è capire quando la fluidodinamica governa il sistema: raffreddamento, alimentazione, iniezione, aerodinamica, pompaggio, propulsione e controllo di processo. Qui portata, caduta di pressione, turbolenza e diffusione non sono capitoli separati ma aspetti della stessa architettura fisica.

Questo topic alza la fluidica da intuizione qualitativa a lente progettuale seria.',
  key_takeaways = array[
    'Portata, pressione e velocità descrivono aspetti diversi ma accoppiati dello stesso flusso.',
    'Le perdite e il regime di flusso cambiano prestazione, efficienza e controllabilità.',
    'Trasporto di massa e trasporto di quantità di moto si intrecciano in molti sistemi reali.',
    'La propulsione è un bilancio tra spinta, efficienza, stabilità e integrazione col resto del sistema.'
  ],
  study_blocks = '[
    {"title":"Bilanci di massa e quantità di moto","content":"Un sistema fluido si legge bene partendo da bilanci: quanta massa entra, quanta esce, quanta si accumula e come cambia la quantità di moto. Questa impostazione unifica tubazioni, scambiatori, ugelli, pompe e camere di combustione sotto la stessa grammatica."},
    {"title":"Regimi di flusso e perdite","content":"Flusso laminare e turbolento non sono etichette decorative. Cambiano attrito, mixing, scambio termico, rumore e stabilità del sistema. La stessa geometria può comportarsi in modo radicalmente diverso a seconda del Reynolds e delle condizioni di contorno."},
    {"title":"Trasporto di specie e diffusione","content":"Quando non ti interessa solo muovere fluido ma anche trasferire una sostanza, entrano in gioco gradiente di concentrazione, diffusione, boundary layer e miscelazione. Questo è centrale in batterie, raffreddamento, processi chimici, respirazione artificiale e propulsione."},
    {"title":"Propulsione come architettura","content":"Generare spinta significa trasformare energia in quantità di moto utile con limiti di efficienza, controllo e integrazione strutturale. Ugelli, eliche, ventole, pompe e thruster vanno letti come sistemi, non solo come componenti isolati."}
  ]'::jsonb,
  formulas = '[
    {"label":"Continuity","expression":"Q = A v","note":"Portata volumetrica come area per velocità media."},
    {"label":"Bernoulli intuition","expression":"p + 1/2 rho v^2 + rho g h = const","note":"Bilancio semplificato tra pressione, velocità e quota."},
    {"label":"Reynolds number","expression":"Re = rho v L / mu","note":"Aiuta a intuire il regime di flusso e la natura delle perdite."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT OCW - Fluid Mechanics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"MIT OCW - Transport Processes","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"Fluid mechanics basics","url":"https://www.youtube.com/results?search_query=fluid+mechanics+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"pipeline-stages","title":"Percorso del fluido","caption":"Il flusso accumula perdite e cambia stato lungo ogni tratto della pipeline."},
    {"kind":"trade-study","title":"Spinta vs efficienza","caption":"Aumentare portata o velocità utile redistribuisce consumo, rumore e controllo."}
  ]'::jsonb
where slug = 'mass-transfer-fluids-and-propulsion';

update public.topics
set
  estimated_minutes = 28,
  overview = 'RF, antenne e comunicazioni embedded chiedono un cambio di mentalità: il segnale non è più confinato in un filo ma vive nello spazio, dentro campi che si propagano, riflettono, attenuano e interferiscono. A quel punto protocollo e software non bastano più a spiegare il comportamento del sistema.

Il valore pratico di questo topic sta nel capire perché link budget, impedenza, matching, polarizzazione, path loss, multipath e rumore di fondo cambiano affidabilità, autonomia e prestazione di un sistema mobile o distribuito. Una radio robusta è sempre un compromesso tra fisica, elettronica, antenna e protocollo.

Questo topic porta la comunicazione wireless fuori dal vago e la rende leggibile come sistema energetico e informativo.',
  key_takeaways = array[
    'Un link RF dipende da antenna, ambiente, frequenza, potenza e geometria del sistema.',
    'Matching e impedenza influenzano direttamente quanta energia viene irradiata o riflessa.',
    'Multipath, fading e interferenza rendono il canale variabile nel tempo e nello spazio.',
    'La robustezza wireless nasce da co-progettazione tra fisica del link e stack di comunicazione.'
  ],
  study_blocks = '[
    {"title":"Dal conduttore allo spazio libero","content":"Quando il segnale lascia la linea e passa all antenna, cambia natura del problema. Non stai più gestendo solo tensione e corrente locali, ma onde che si propagano, si diffondono e interagiscono con l ambiente. Questo è il primo cambio di paradigma importante."},
    {"title":"Antenna come interfaccia energetica","content":"L antenna non è un accessorio passivo ma il convertitore tra segnale guidato e campo irradiato. Matching, polarizzazione, pattern e guadagno definiscono quanta informazione ed energia riesci davvero a portare nel canale."},
    {"title":"Link budget e canale reale","content":"Il link budget ti dà una prima lettura energetica del collegamento, ma il canale reale aggiunge fading, shadowing, ostacoli e interferenze. Questo rende la comunicazione wireless un problema dinamico, non un conto statico una tantum."},
    {"title":"RF embedded nel prodotto","content":"Schermature, ground plane, posizione dell antenna, routing, enclosure e vicinanza di batterie o motori possono distruggere o migliorare il link. Per questo la RF non si risolve solo scegliendo il modulo radio giusto."}
  ]'::jsonb,
  formulas = '[
    {"label":"Friis intuition","expression":"P_r prop P_t G_t G_r (lambda / 4 pi R)^2","note":"Stima base della potenza ricevuta in spazio libero."},
    {"label":"VSWR intuition","expression":"VSWR = (1 + |Gamma|) / (1 - |Gamma|)","note":"Misura qualitativamente il grado di mismatch dell antenna."},
    {"label":"Link margin","expression":"Margin = P_rx - Sensitivity","note":"Margine energetico tra segnale ricevuto e soglia utile del ricevitore."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT Electromagnetics and Applications","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"ARRL antenna basics","url":"https://www.arrl.org/what-is-ham-radio","type":"handbook","source":"ARRL"},
    {"title":"RF basics for embedded systems","url":"https://www.youtube.com/results?search_query=rf+basics+embedded+systems","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"signal-wave","title":"Link nello spazio","caption":"Il segnale si propaga attraverso un ambiente che ne modifica ampiezza, fase e affidabilità."},
    {"kind":"trade-study","title":"Potenza vs autonomia vs robustezza","caption":"Migliorare il link RF costa energia, spazio o complessità di integrazione."}
  ]'::jsonb
where slug = 'rf-antennas-and-embedded-communications';

update public.topics
set
  estimated_minutes = 30,
  overview = 'Ottica, fotonica e imaging diventano profonde quando smetti di vedere la camera come sensore isolato e inizi a leggere l intera catena di formazione dell informazione: sorgente luminosa, ottica, interazione con la scena, sensore, rumore, campionamento ed elaborazione. Ogni passo può guadagnare o perdere struttura utile.

Il punto ingegneristico forte è capire che risoluzione, contrasto, dynamic range, profondità di campo e sensibilità spettrale non sono feature indipendenti. Sono compromessi fisici tra apertura, geometria, sensore, illuminazione e tempo di esposizione. Questo vale per machine vision, lidar, microscopia, metrologia e visione autonoma.

Questo topic spinge l imaging oltre la UI del sensore e dentro la fisica della misura.',
  key_takeaways = array[
    'L informazione ottica nasce da una pipeline fisica, non solo da un sensore digitale.',
    'Diffrazione, aberrazioni, esposizione e rumore limitano il contenuto utile dell immagine.',
    'Scena, luce, ottica e algoritmo vanno letti come un unico sistema di misura.',
    'La progettazione ottica richiede scelte esplicite su risoluzione, robustezza e condizioni operative.'
  ],
  study_blocks = '[
    {"title":"Formazione fisica dell immagine","content":"Un immagine è il risultato di come la scena emette o riflette luce, di come l ottica la raccoglie e di come il sensore la converte. Ogni passaggio distorce, filtra e limita l informazione. Per questo un immagine “bella” e una misura utile non coincidono sempre."},
    {"title":"Risoluzione e limiti fisici","content":"Diffrazione, aberrazioni, pixel size, fill factor e profondità di campo si intrecciano. Non puoi massimizzare dettaglio, sensibilità e robustezza a focus o movimento senza pagare prezzo in qualche altra dimensione del sistema."},
    {"title":"Spettro, illuminazione e contrasto","content":"Molti problemi di visione non si risolvono con più rete neurale ma con migliore illuminazione, selezione spettrale o contrasto ottico. La scena e la sorgente luminosa fanno parte attiva dell architettura percettiva."},
    {"title":"Imaging come misura","content":"In robotica e metrologia, l immagine serve a stimare pose, difetti, profondità o condizioni di superficie. Il punto centrale è chiedere quale informazione fisica resta difendibile dopo tutta la pipeline, non solo quale immagine sembra più nitida."}
  ]'::jsonb,
  formulas = '[
    {"label":"Thin lens","expression":"1/f = 1/d_o + 1/d_i","note":"Relazione base tra focale, distanza oggetto e piano immagine."},
    {"label":"Diffraction limit","expression":"theta approx 1.22 lambda / D","note":"Limite fondamentale della risoluzione angolare di un apertura."},
    {"label":"Radiometric intuition","expression":"Signal prop photons collected","note":"La qualità del segnale dipende dal numero di fotoni utili raccolti."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT OCW - Optics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"Stanford Computational Imaging","url":"https://web.stanford.edu/class/ee367/","type":"article","source":"Stanford"},
    {"title":"Optics and imaging basics","url":"https://www.youtube.com/results?search_query=optics+and+imaging+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"signal-wave","title":"Catena di imaging","caption":"La luce viene trasformata, attenuata e campionata prima di diventare dato utilizzabile."},
    {"kind":"trade-study","title":"Dettaglio vs sensibilità","caption":"Più dettaglio, più profondità di campo e più robustezza alla luce scarsa raramente arrivano insieme."}
  ]'::jsonb
where slug = 'optics-photonics-and-imaging-systems';
