update public.topics
set
  estimated_minutes = 28,
  overview = 'La cinematica robotica non chiede prima di tutto quanta forza hai, ma come descrivi posizione, orientamento e vincoli di un corpo nello spazio. Quando ragioni su manipolatori, bracci, gimbal o end-effector, il vero salto mentale e passare da pezzi meccanici isolati a catene cinematiche con gradi di liberta, giunti, frame di riferimento e workspace.

La parte importante per un engineer non e memorizzare formalismi astratti, ma capire cosa rimane controllabile, osservabile e raggiungibile quando la geometria del sistema cambia. Jacobiani, singularities e inverse kinematics non sono matematica ornamentale: spiegano perche un robot a volte si muove bene, a volte diventa sensibile, inefficiente o quasi impossibile da comandare vicino a certe configurazioni.

Questo topic ti porta dal modello geometrico di base fino all intuizione progettuale: scegliere architettura del manipolatore, distribuire i gradi di liberta, ragionare su precisione, compliance e contatto con l ambiente.',
  key_takeaways = array[
    'Una catena cinematica trasforma coordinate dei giunti in posa dell end-effector.',
    'Le singularities non sono bug software: sono limiti geometrici del sistema.',
    'La scelta tra cinematica diretta e inversa cambia il modo in cui progetti controllo e task planning.',
    'Workspace, precisione e rigidezza dipendono insieme da geometria e attuazione.'
  ],
  study_blocks = '[
    {"title":"Frame, giunti e trasformazioni","content":"Ogni robot manipolatore e una composizione di frame di riferimento. Parti da basi, link e giunti; poi descrivi come una rotazione o una traslazione locale diventa posa globale. La chiave e non perdere mai il significato fisico delle coordinate: ogni matrice esiste per mantenere coerente il passaggio tra punti di vista diversi sullo stesso sistema."},
    {"title":"Forward e inverse kinematics","content":"La cinematica diretta ti dice dove va l end-effector date le coordinate dei giunti. La cinematica inversa fa il contrario: date posa e orientamento desiderati, chiede quali configurazioni dei giunti siano compatibili. Questo passaggio e il primo vero punto in cui il problema smette di essere intuitivo e diventa progettuale: possono esistere piu soluzioni, nessuna soluzione, o soluzioni pessime vicino ai limiti del meccanismo."},
    {"title":"Jacobiano, velocita e singularities","content":"Il Jacobiano collega velocita ai giunti e velocita dell end-effector. Se si degrada, piccoli comandi possono generare grandi velocita articolari o scarsa autorita in certe direzioni. Le singularities spiegano perche certi robot sembrano potenti su carta ma diventano fragili o inefficienti in punti specifici del workspace."},
    {"title":"Dal modello geometrico al prodotto","content":"Nel mondo reale non basta raggiungere un punto. Devi arrivarci con margine, stabilita, rigidezza e safety. Qui entrano gioco ridondanza, compliance, tolleranze, elasticita dei link, backlash e contatto. Il modello cinematico e l inizio della catena di decisioni, non la fine."}
  ]'::jsonb,
  formulas = '[
    {"label":"Forward kinematics","expression":"T_0_n = A_1 A_2 ... A_n","note":"Composizione delle trasformazioni dei singoli giunti lungo la catena."},
    {"label":"Differential kinematics","expression":"x_dot = J(q) q_dot","note":"Il Jacobiano collega velocita articolari e velocita dell end-effector."},
    {"label":"Static mapping","expression":"tau = J(q)^T F","note":"Le forze al contatto si riflettono in coppie richieste ai giunti."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT OCW - Underactuated Robotics","url":"https://underactuated.mit.edu/","type":"handbook","source":"MIT"},
    {"title":"Modern Robotics","url":"https://modernrobotics.northwestern.edu/","type":"handbook","source":"Northwestern"},
    {"title":"MIT OCW - Robotics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"}
  ]'::jsonb,
  visuals = '[
    {"kind":"free-body","title":"Catena cinematica","caption":"Ogni giunto aggiunge gradi di liberta ma anche limiti geometrici e sensibilita configurazionale."},
    {"kind":"trade-study","title":"Workspace vs precisione","caption":"Più estensione o più destrezza raramente arrivano gratis: la geometria redistribuisce precisione e forza."}
  ]'::jsonb
where slug = 'robot-kinematics-and-manipulation';

update public.topics
set
  estimated_minutes = 30,
  overview = 'Percezione robotica e autonomy stack iniziano da un fatto semplice: il mondo non ti si presenta come stato vero, ma come segnali rumorosi, incompleti e in ritardo. SLAM, sensor fusion e planning esistono per trasformare misure locali in una rappresentazione utile del mondo e in decisioni coerenti sotto incertezza.

Il cuore del problema non e solo capire dove sei, ma quanto puoi fidarti della tua stima. Una buona architettura di percezione tiene insieme sensori, modelli, latenza, failure modes, mappe e policy decisionali. Se una di queste parti viene trattata come modulo separato, il sistema inizia a degradare in modo opaco.

Questo topic collega probabilita, stima, map building e motion planning in un unico flusso: sensing, belief update, world model, action selection, replanning.',
  key_takeaways = array[
    'Percezione significa stimare stato e ambiente sotto incertezza, non leggere direttamente la realta.',
    'SLAM unisce localizzazione e mappatura perche i due problemi si vincolano a vicenda.',
    'Planning utile richiede costi, vincoli e modelli del mondo coerenti con la qualita della percezione.',
    'Latenza, occlusioni e data association sono problemi architetturali, non dettagli implementativi.'
  ],
  study_blocks = '[
    {"title":"Dal sensore alla belief state","content":"Ogni sensore produce osservazioni parziali e rumorose. La percezione robusta nasce quando trasformi misure grezze in una belief: una rappresentazione probabilistica dello stato del robot e dell ambiente. Il punto non e eliminare l incertezza, ma gestirla in modo esplicito."},
    {"title":"SLAM come problema congiunto","content":"In simultaneous localization and mapping, robot e mappa si stimano a vicenda. Se la posa e sbagliata, anche la mappa lo e; se la mappa e fragile, peggiora la localizzazione. Questo legame rende chiaro perche loop closure, osservabilita e data association sono cosi delicati."},
    {"title":"Planning sotto vincoli reali","content":"Pianificare un percorso o una sequenza d azioni non significa cercare solo una traiettoria breve. Devi rispettare dinamica, ostacoli, sicurezza, energia, tempo di calcolo e confidenza sulla percezione. Un planner forte e utile solo se si innesta bene nel ciclo sensing-estimation-control."},
    {"title":"Architettura di autonomia","content":"I sistemi maturi separano livelli: stima, world model, comportamento, planning locale, controllo, monitoraggio e fallback. Questo permette di degradare con eleganza quando visione, GPS o odometria diventano fragili, invece di fallire in modo binario."}
  ]'::jsonb,
  formulas = '[
    {"label":"Bayes update","expression":"p(x|z) prop p(z|x) p(x)","note":"La stima a posteriori combina prior e misura."},
    {"label":"State transition","expression":"x_k = f(x_k-1, u_k) + w_k","note":"Il modello dinamico propaga lo stato sotto controllo e rumore di processo."},
    {"label":"Measurement model","expression":"z_k = h(x_k) + v_k","note":"La misura osservata deriva dallo stato con rumore e distorsioni sensoriali."}
  ]'::jsonb,
  "references" = '[
    {"title":"Probabilistic Robotics","url":"https://mitpress.mit.edu/9780262201629/probabilistic-robotics/","type":"handbook","source":"MIT Press"},
    {"title":"MIT Underactuated - State Estimation","url":"https://underactuated.mit.edu/state_estimation.html","type":"article","source":"MIT"},
    {"title":"SLAM for Dummies","url":"https://www.youtube.com/watch?v=I6n8nLh6y1w","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"feedback-loop","title":"Perception loop","caption":"Misura, stima, mappa, decisione e controllo formano un ciclo chiuso che si corregge continuamente."},
    {"kind":"state-machine","title":"Autonomy stack","caption":"La percezione non e un blocco unico: produce stato, confidenza e vincoli per il planner."}
  ]'::jsonb
where slug = 'robot-perception-planning-and-slam';

update public.topics
set
  estimated_minutes = 27,
  overview = 'Locomozione robotica richiede una forma di intelligenza fisica: non basta spostare un corpo, bisogna mantenere equilibrio, generare forze utili al contatto e reagire a superfici, attrito e perturbazioni. Camminare, correre o stabilizzare un sistema mobile significa governare dinamica, support polygon, centro di massa e ground reaction forces.

La difficolta vera e che il contatto cambia il problema ad ogni istante. Una ruota che slitta, un piede che perde aderenza o una sospensione che entra in una zona non lineare trasformano il comportamento globale del sistema. Per questo locomozione e balance sono un punto d incontro tra meccanica, controllo, sensing e powertrain.

Questo topic ti abitua a leggere il moto non come traiettoria ideale, ma come scambio continuo di energia e forze con l ambiente.',
  key_takeaways = array[
    'La stabilita dinamica dipende da centro di massa, contatto e tempi del controllo.',
    'La locomozione e un problema di forza e impulso prima ancora che di geometria.',
    'Attrito, compliance e terreno cambiano qualitativamente il comportamento del robot.',
    'Un sistema mobile robusto richiede co-progettazione di meccanica, sensing e controllo.'
  ],
  study_blocks = '[
    {"title":"Statico vs dinamico","content":"La stabilita statica chiede se la proiezione del centro di massa rimane nella base di supporto. Ma robot e veicoli mobili reali operano spesso in stabilita dinamica, dove velocita, accelerazione e timing del controllo contano quanto la geometria."},
    {"title":"Contatto e attrito","content":"Ogni passo o ruota scarica forze nel terreno. Se il cono di attrito viene violato, compaiono slittamento e perdita di autorita. Per questo il problema della locomozione non si risolve solo con buone traiettorie: devi sapere quanta forza e fisicamente trasferibile."},
    {"title":"Equilibrio, compliance e disturbi","content":"Nel mondo reale il robot incontra urti, pendenze, backlash, elasticita e sensori rumorosi. La compliance puo aiutare ad assorbire energia e ad adattarsi al suolo, ma rende il controllo piu delicato. La locomozione robusta vive nella gestione di questo compromesso."},
    {"title":"Dal laboratorio al campo","content":"Una demo su suolo perfetto non vale come architettura affidabile. Devi ragionare su recovery behavior, saturazioni di coppia, densita di potenza, battery drain e fallback quando il terreno o il payload cambiano."}
  ]'::jsonb,
  formulas = '[
    {"label":"Moment balance","expression":"sum M = I alpha","note":"La rotazione del corpo dipende dal bilancio dei momenti rispetto al baricentro o al contatto."},
    {"label":"Friction limit","expression":"F_t <= mu F_n","note":"La forza tangenziale trasferibile e limitata dal contatto normale e dal coefficiente di attrito."},
    {"label":"Inverted pendulum intuition","expression":"omega = sqrt(g / l)","note":"Scala caratteristica usata per intuire tempi e stabilita di sistemi bilanciati."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT Underactuated - Legged Robots","url":"https://underactuated.mit.edu/","type":"handbook","source":"MIT"},
    {"title":"ETH Zurich - Legged Robotics","url":"https://rsl.ethz.ch/robots-media.html","type":"article","source":"ETH Zurich"},
    {"title":"Agility Robotics talks","url":"https://www.youtube.com/results?search_query=agility+robotics+locomotion","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"free-body","title":"Contatto e supporto","caption":"La locomozione vive nel bilancio tra peso, forze di reazione e margine di attrito."},
    {"kind":"feedback-loop","title":"Balance loop","caption":"Sensori, stima dello stato e controllo di coppia chiudono il ciclo che mantiene il robot in piedi."}
  ]'::jsonb
where slug = 'robot-locomotion-balance-and-contact';

update public.topics
set
  estimated_minutes = 26,
  overview = 'L ottica di un sistema di imaging non e un accessorio davanti a un sensore: e il primo stadio di elaborazione dell informazione. Apertura, lunghezza focale, diffrazione, profondita di campo, aberrazioni e rumore fotonico decidono cosa il sistema puo vedere prima che qualsiasi algoritmo entri in gioco.

Chi progetta sistemi visivi maturi deve ragionare in pipeline: scena, illuminazione, ottica, sensore, conversione, elaborazione, decisione. Se una parte della pipeline e debole, il software non puo recuperare arbitrariamente l informazione perduta.

Questo topic ti allena a leggere un sistema ottico come catena di trasferimento dell informazione, utile tanto per computer vision quanto per sensing, metrologia, targeting e telecomunicazioni ottiche.',
  key_takeaways = array[
    'Risoluzione utile dipende da ottica, sensore, illuminazione e rumore insieme.',
    'La luce trasporta informazione ma anche limiti fisici su banda, energia e precisione.',
    'Field of view, apertura e profondita di campo sono compromessi progettuali legati.',
    'Un buon sistema di imaging si valuta sull intera pipeline, non solo sul modello AI.'
  ],
  study_blocks = '[
    {"title":"Formazione dell immagine","content":"Un sistema di imaging raccoglie luce emessa o riflessa dalla scena e la proietta su un sensore. Lunghezza focale e geometria dell ottica determinano ingrandimento, field of view e sensibilita a defocus. Ogni scelta sull obiettivo modifica direttamente il contenuto informativo che arriva al sensore."},
    {"title":"Risoluzione, diffrazione e campionamento","content":"La risoluzione non e solo questione di pixel. Se l apertura ottica e piccola, la diffrazione allarga il punto immagine; se il pixel e troppo grande o troppo piccolo rispetto all ottica, il campionamento introduce altri limiti. La vera prestazione nasce dal matching tra lente e sensore."},
    {"title":"Rumore, esposizione e dynamic range","content":"Photon shot noise, rumore di lettura, saturazione e quantizzazione limitano la qualita dell acquisizione. Per questo esposizione e gain non sono slider estetici ma decisioni su rapporto segnale-rumore e robustezza della misura."},
    {"title":"Dal sensore alla decisione","content":"In robotica e sistemi autonomi, la camera non serve solo a vedere ma a stimare profondita, tracking, pose e anomalie. Il punto chiave e capire quale informazione fisica viene preservata e quale no lungo la catena ottica ed elettronica."}
  ]'::jsonb,
  formulas = '[
    {"label":"Diffraction limit","expression":"theta approx 1.22 lambda / D","note":"Scala il dettaglio minimo risolvibile da un apertura circolare."},
    {"label":"Thin lens","expression":"1 / f = 1 / d_o + 1 / d_i","note":"Relazione base tra focale, distanza oggetto e distanza immagine."},
    {"label":"Photon shot noise","expression":"SNR approx N / sqrt(N) = sqrt(N)","note":"Il rumore fotonico cresce come radice del numero di fotoni raccolti."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT OCW - Optics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"Stanford - Computational Imaging","url":"https://web.stanford.edu/class/ee367/","type":"article","source":"Stanford"},
    {"title":"3Blue1Brown - Lenses","url":"https://www.youtube.com/results?search_query=3blue1brown+lenses","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"signal-wave","title":"Pipeline ottica","caption":"La luce subisce attenuazione, sfocatura e rumore prima ancora di diventare immagine digitale."},
    {"kind":"trade-study","title":"FOV, luce, dettaglio","caption":"Campo visivo, sensibilita e precisione si scambiano continuamente margine progettuale."}
  ]'::jsonb
where slug = 'optics-photonics-and-imaging-systems';

update public.topics
set
  estimated_minutes = 29,
  overview = 'La fisica moderna entra nell ingegneria ogni volta che i modelli classici diventano insufficienti a spiegare trasporto elettronico, band structure, emissione luminosa, dispositivi a semiconduttore o sensori avanzati. Non serve trasformare l app in un corso di fisica teorica, ma serve una base che renda leggibili transistor, fotodiodi, materiali elettronici e componenti ad alte prestazioni.

Il passaggio concettuale cruciale e che l elettrone non va pensato solo come pallina in un filo. Nei solidi conta la struttura energetica del materiale, la disponibilita di stati, la presenza di gap di banda e il modo in cui drogaggio, temperatura e campi elettrici modificano la conduzione.

Questo topic ti da una lettura pragmatica: abbastanza profonda da togliere magia ai dispositivi moderni, abbastanza orientata al progetto da restare utile.',
  key_takeaways = array[
    'Band gap, doping e mobilita spiegano il comportamento dei semiconduttori molto meglio di una metafora circuitale pura.',
    'La fisica quantistica entra nei dispositivi come struttura energetica, non solo come formalismo astratto.',
    'Temperatura, difetti e materiali cambiano prestazioni, leakage e affidabilita.',
    'Molti sensori e dispositivi optoelettronici derivano direttamente da fenomeni di fisica moderna.'
  ],
  study_blocks = '[
    {"title":"Dagli atomi alle bande","content":"Quando gli atomi si organizzano in un solido, i livelli energetici si distribuiscono in bande. Valence band, conduction band e band gap definiscono se un materiale si comporta come conduttore, semiconduttore o isolante. Questo e il fondamento fisico che rende sensato parlare di transistor e giunzioni."},
    {"title":"Drogaggio e trasporto","content":"Drogare un semiconduttore significa alterare la popolazione di portatori disponibili e quindi il comportamento elettrico del materiale. La conduzione non dipende solo da quanti portatori hai, ma da quanto velocemente possono muoversi, da scattering, temperatura e struttura del materiale."},
    {"title":"Giunzioni e dispositivi","content":"Metti insieme materiali o regioni con proprieta diverse e ottieni barriere, regioni di svuotamento, campi interni e comportamenti rettificanti o amplificanti. Diodi, BJT, MOSFET e fotodiodi discendono da questa logica fisica di base."},
    {"title":"Perche serve a un systems engineer","content":"Capire il livello fisico aiuta a leggere leakage, breakdown, soglie, velocita di commutazione, rumore e limiti termici come effetti della tecnologia del dispositivo, non solo come numeri di datasheet."}
  ]'::jsonb,
  formulas = '[
    {"label":"Intrinsic carrier concentration intuition","expression":"n_i prop e^(-E_g / 2kT)","note":"Il gap di banda e la temperatura influenzano fortemente la popolazione di portatori."},
    {"label":"Drift current intuition","expression":"J = q n mu E","note":"La densita di corrente cresce con carica, portatori, mobilita e campo elettrico."},
    {"label":"Diode law","expression":"I = I_s (e^(V / nV_T) - 1)","note":"Forma base che mostra la natura esponenziale della giunzione."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT OCW - Solid State Chemistry and Physics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"Semiconductor Fundamentals","url":"https://ecee.colorado.edu/~bart/book/book/","type":"handbook","source":"University of Colorado"},
    {"title":"Neso Academy - Semiconductor Physics","url":"https://www.youtube.com/results?search_query=neso+academy+semiconductor+physics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"mosfet-symbol","title":"Dal simbolo alla fisica","caption":"Dietro un MOSFET ci sono bande, carica, campi e canali di conduzione modulati dal gate."},
    {"kind":"trade-study","title":"Materiale vs prestazione","caption":"Gap di banda, mobilita e stabilita termica redistribuiscono efficienza, velocita e robustezza."}
  ]'::jsonb
where slug = 'modern-physics-quantum-and-semiconductor-foundations';

update public.topics
set
  estimated_minutes = 25,
  overview = 'La chimica generale diventa utile per un engineer quando smette di essere lista di formule da laboratorio e diventa modello di trasformazione della materia. Legami, equilibrio, cinetica, reazioni redox, acidita e struttura molecolare determinano come si comportano batterie, coating, adesivi, combustibili, corrosione e processi produttivi.

Molti problemi che sembrano meccanici o elettrici hanno in realta una radice chimica: un materiale si degrada, una superficie perde adesione, una batteria invecchia, un fluido reagisce, un trattamento termico cambia microstruttura. Senza una base chimica, il progetto si ferma al sintomo.

Questo topic costruisce una grammatica minima ma seria per leggere trasformazioni e processi dei materiali in chiave ingegneristica.',
  key_takeaways = array[
    'Struttura atomica e legami chimici influenzano proprieta macroscopiche e processi produttivi.',
    'Equilibrio e cinetica spiegano non solo se una reazione avviene, ma a quale ritmo e con quali limiti.',
    'Ossidazione, corrosione e invecchiamento sono problemi chimici con effetti sistemici sul prodotto.',
    'Una base chimica migliora la lettura di batterie, coating, adesivi, polimeri e materiali avanzati.'
  ],
  study_blocks = '[
    {"title":"Legami, stati e proprieta","content":"Il tipo di legame tra atomi influenza durezza, conducibilita, fragilita, stabilita termica e compatibilita chimica. Metalli, ceramiche, polimeri e compositi si comportano diversamente perche la loro struttura microscopica e chimica non e la stessa."},
    {"title":"Equilibrio e cinetica","content":"Una reazione puo essere termodinamicamente favorita ma troppo lenta per essere utile, oppure molto rapida ma difficile da controllare. Questa distinzione e fondamentale per leggere curing, corrosione, combustione, degradazione e processi elettrochimici."},
    {"title":"Redox, superfici e corrosione","content":"Molte interazioni materiali-ambiente sono governate da trasferimenti di elettroni. Corrosione, passivazione, plating e degrado superficiale diventano leggibili quando ragioni in termini di potenziale, ambiente e film protettivi."},
    {"title":"Chimica nei sistemi reali","content":"Batterie, adesivi strutturali, coating, polimeri ingegneristici e processi di fabbricazione richiedono un pensiero chimico integrato con meccanica e termica. Questo e il punto in cui la chimica smette di essere materia ancillare e diventa design tool."}
  ]'::jsonb,
  formulas = '[
    {"label":"Arrhenius","expression":"k = A e^(-E_a / RT)","note":"La velocita di reazione cresce con la temperatura e dipende dalla barriera energetica."},
    {"label":"Nernst intuition","expression":"E = E^0 - (RT / nF) ln Q","note":"Collega condizioni chimiche e potenziale elettrochimico."},
    {"label":"Mass action intuition","expression":"K = [products] / [reactants]","note":"Forma semplificata per intuire equilibrio e spinta di reazione."}
  ]'::jsonb,
  "references" = '[
    {"title":"Khan Academy - Chemistry","url":"https://www.khanacademy.org/science/chemistry","type":"article","source":"Khan Academy"},
    {"title":"MIT OCW - Introduction to Solid State Chemistry","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"Electrochemistry basics","url":"https://www.youtube.com/results?search_query=electrochemistry+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"trade-study","title":"Processo chimico e prodotto","caption":"Reazioni e trattamenti cambiano proprietà, durata, sicurezza e producibilità."},
    {"kind":"complexity-scale","title":"Dal legame al sistema","caption":"Una scelta chimica locale può alterare comportamento meccanico, elettrico e termico del prodotto finale."}
  ]'::jsonb
where slug = 'chemistry-foundations-reactions-and-material-processes';

update public.topics
set
  estimated_minutes = 24,
  overview = 'Plasma, archi, scariche, ambienti estremi e sistemi ad alta densita di potenza appartengono a un dominio in cui i modelli nominali iniziano a rompersi. Temperature elevate, campi intensi, ionizzazione e trasporto energetico fuori scala cambiano il comportamento della materia e trasformano anche decisioni di progetto apparentemente semplici.

Questo non e un topic per memorizzare fisica esotica. E un topic per imparare a riconoscere quando un sistema sta uscendo dal regime ordinario: breakdown elettrico, materiali sotto forte stress termico, propulsione avanzata, scariche, isolamento ad alta tensione, ambienti di plasma o test ad alta energia.

Il valore progettuale e soprattutto architetturale: capire quando il modello standard non vale piu e servono margini, materiali, geometrie e strategie di safety differenti.',
  key_takeaways = array[
    'I sistemi estremi richiedono modelli diversi da quelli usati nel regime nominale.',
    'Campo elettrico, temperatura e densita di potenza possono innescare fenomeni qualitativamente nuovi.',
    'Breakdown, ionizzazione e danno termico sono failure modes da progettare, non solo da misurare dopo.',
    'Pensare in regimi estremi allena a costruire margini e safety case più robusti.'
  ],
  study_blocks = '[
    {"title":"Quando il modello collassa","content":"Molti sistemi vengono progettati usando linearita, piccoli segnali e condizioni nominali. Ma se temperatura, campo o densita di energia superano certe soglie, compaiono ionizzazione, non linearita forti, archi, danni di superficie e trasporto anomalo. Qui il modello semplice smette di essere affidabile."},
    {"title":"Plasma come stato fisico utile","content":"Un plasma e un gas ionizzato in cui cariche libere, campi elettromagnetici e collisioni generano comportamento collettivo. Non serve dominarne tutta la fisica per trarne valore: basta capire perche scariche, propulsori, fusion concepts o trattamenti al plasma richiedono una lettura diversa da quella di un gas neutro."},
    {"title":"Materiali e interfacce sotto stress","content":"Isolanti, elettrodi, coating e strutture esposte a regimi estremi possono erodersi, carbonizzarsi, cambiare fase o perdere integrita. Questo crea una forte connessione tra fisica estrema, scienza dei materiali e design per affidabilita."},
    {"title":"Progettazione prudente","content":"Il punto utile per il prodotto e riconoscere i segnali che richiedono derating, distance design, controllo termico, schermatura, contenimento e safety instrumentation. Le architetture forti non negano i regimi estremi: li delimitano."}
  ]'::jsonb,
  formulas = '[
    {"label":"Power density","expression":"rho_P = P / V","note":"Una scala utile per intuire quando un sistema entra in regimi termici o energetici severi."},
    {"label":"Stored electric energy","expression":"u_E = 1/2 epsilon E^2","note":"L energia elettrica per unita di volume cresce rapidamente con il campo."},
    {"label":"Arc intuition","expression":"P = V I","note":"Una scarica combina tensione e corrente in livelli di potenza localmente estremi."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT Plasma Science and Fusion Center","url":"https://www.psfc.mit.edu/","type":"article","source":"MIT"},
    {"title":"NASA Glenn - Electric Propulsion","url":"https://www.nasa.gov/glenn/research/space-flight-systems/electric-propulsion/","type":"article","source":"NASA"},
    {"title":"Plasma basics","url":"https://www.youtube.com/results?search_query=plasma+physics+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"complexity-scale","title":"Uscita dal regime nominale","caption":"Al crescere di campo, temperatura o densità di potenza, il sistema entra in domini fisici qualitativamente diversi."},
    {"kind":"verification-stack","title":"Safety per sistemi estremi","caption":"Materiali, geometrie, isolamento, sensori e limiti operativi lavorano insieme per contenere il rischio."}
  ]'::jsonb
where slug = 'plasma-high-energy-and-extreme-systems';
