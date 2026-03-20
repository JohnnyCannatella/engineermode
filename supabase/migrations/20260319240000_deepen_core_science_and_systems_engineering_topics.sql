update public.topics
set
  estimated_minutes = 31,
  overview = 'La fisica moderna applicata ai semiconduttori serve quando vuoi capire non solo che un dispositivo funziona, ma perché funziona, dove smette di farlo e quali limiti derivano dalla sua fisica interna. Band gap, mobilità, scattering, giunzioni, accumulo di carica e trasporto non sono concetti ornamentali: spiegano soglie, perdite, leakage, velocità e affidabilità.

Il salto concettuale forte è trattare il semiconduttore come materiale ingegnerizzato, non come simbolo sullo schema. Una scelta di tecnologia, drogaggio, geometria o materiale redistribuisce prestazione elettrica, sensibilità termica, rumore e robustezza ai campi. Questo vale per logica, potenza, imaging e sensing.

Questo topic consolida la base fisica necessaria per leggere dispositivi avanzati in modo non superficiale.',
  key_takeaways = array[
    'Band structure e trasporto spiegano comportamento, limiti e prestazioni dei dispositivi.',
    'Drogaggio, campo e temperatura modificano in profondità la dinamica dei portatori.',
    'Leakage, breakdown e rumore hanno radici fisiche precise e leggibili.',
    'La tecnologia del materiale influenza direttamente efficienza, velocità e affidabilità del sistema.'
  ],
  study_blocks = '[
    {"title":"Bande e portatori","content":"Conduttori, semiconduttori e isolanti si distinguono per la struttura delle bande energetiche. Questo quadro spiega perché alcuni materiali conducono facilmente, altri solo sotto certe condizioni e altri quasi per nulla. Nei semiconduttori il comportamento nasce dall equilibrio tra portatori, gap di banda e condizioni operative."},
    {"title":"Drogaggio e giunzioni","content":"Il drogaggio modifica la densità di portatori e costruisce regioni con comportamento elettrico diverso. Quando queste regioni si incontrano, compaiono giunzioni, campi interni e zone di svuotamento che permettono rettificazione, controllo di canale e rilevazione ottica."},
    {"title":"Trasporto, rumore e limiti","content":"La conduzione reale non è perfetta: scattering, trappole, temperatura e difetti introducono limiti di mobilità, leakage e rumore. Per questo un dispositivo ad alte prestazioni va sempre letto anche come compromesso tra trasporto efficiente e robustezza del materiale."},
    {"title":"Dal dispositivo al sistema","content":"Un transistor o un fotodiodo non vive isolato. La sua fisica si riflette in switching loss, dissipazione, sensibilità termica, accuratezza di sensing e compatibilità con il resto dell architettura. Chi capisce questo livello legge meglio anche il sistema superiore."}
  ]'::jsonb,
  formulas = '[
    {"label":"Intrinsic carriers","expression":"n_i prop e^(-E_g / 2kT)","note":"La popolazione intrinseca dipende fortemente da gap di banda e temperatura."},
    {"label":"Current density","expression":"J = q n mu E","note":"La corrente dipende da carica, densità di portatori, mobilità e campo."},
    {"label":"Diode law","expression":"I = I_s (e^(V / nV_T) - 1)","note":"Mostra la natura esponenziale della conduzione di giunzione."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT Solid State Chemistry and Physics","url":"https://ocw.mit.edu/","type":"article","source":"MIT OpenCourseWare"},
    {"title":"Semiconductor Fundamentals","url":"https://ecee.colorado.edu/~bart/book/book/","type":"handbook","source":"University of Colorado"},
    {"title":"Semiconductor device physics","url":"https://www.youtube.com/results?search_query=semiconductor+device+physics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"mosfet-symbol","title":"Dal simbolo al materiale","caption":"Un dispositivo elettronico eredita il suo comportamento da bande, portatori e campi interni."},
    {"kind":"trade-study","title":"Velocità vs robustezza","caption":"Tecnologia, materiale e geometria redistribuiscono prestazione, leakage e resistenza ai limiti fisici."}
  ]'::jsonb
where slug = 'modern-physics-quantum-and-semiconductor-foundations';

update public.topics
set
  estimated_minutes = 29,
  overview = 'Plasma e sistemi estremi sono utili a un engineer non perché tutto il prodotto lavori in quei regimi, ma perché insegnano quando i modelli nominali smettono di valere. Campi intensi, alta temperatura, ionizzazione, scariche e densità di potenza elevate cambiano qualitativamente il comportamento della materia e dei componenti.

Il valore pratico è nel riconoscere l uscita dal regime lineare o ordinario: breakdown, archi, erosione superficiale, isolamento insufficiente, stress termico e interazioni con il plasma. Questo cambia il modo in cui progetti margini, contenimento, materiali e safety instrumentation.

Questo topic rende i regimi estremi meno esotici e più leggibili come casi limite dell ingegneria reale.',
  key_takeaways = array[
    'I regimi estremi richiedono modelli diversi da quelli nominali o a piccolo segnale.',
    'Breakdown e ionizzazione sono failure mode fisici, non semplici anomalie di misura.',
    'Materiali, geometrie e isolamento diventano parte critica dell architettura in alta energia.',
    'Pensare ai limiti estremi migliora anche il design prudente dei sistemi ordinari.'
  ],
  study_blocks = '[
    {"title":"Quando il sistema esce dal suo dominio","content":"Molti modelli ingegneristici funzionano bene finché le grandezze restano in range ordinari. Ma al crescere di campo, temperatura o densità di potenza emergono scariche, non linearità forti, instabilità e danni materiali. Il problema non è solo quantitativo: il regime cambia qualità fisica."},
    {"title":"Plasma come stato utile da capire","content":"Un plasma è un mezzo ionizzato in cui cariche e campi interagiscono collettivamente. Non serve dominarne tutta la teoria per trarne valore: basta riconoscere quando un sistema entra in un dominio dove conduttività, interfacce e trasporto energetico smettono di comportarsi come in un gas neutro o in un isolante ideale."},
    {"title":"Isolamento e contenimento","content":"In sistemi ad alta tensione o alta energia, distanze, superfici, impurità e punte geometriche influenzano fortemente il rischio di breakdown. Questo rende packaging, isolamento, derating e sensoristica parti strutturali del progetto."},
    {"title":"Architetture per regimi severi","content":"I sistemi forti non negano il rischio dei regimi estremi: lo delimitano. Redundancy, containment, thermal monitoring, interlock e materiali adeguati servono a evitare che un evento locale si trasformi in failure catastrofico."}
  ]'::jsonb,
  formulas = '[
    {"label":"Power density","expression":"rho_P = P / V","note":"Scala utile per intuire quando l energia è concentrata in modo severo."},
    {"label":"Electric energy density","expression":"u_E = 1/2 epsilon E^2","note":"L energia immagazzinata nel campo cresce rapidamente con E."},
    {"label":"Arc power","expression":"P = V I","note":"Una scarica combina alta tensione e corrente in potenze localmente distruttive."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT Plasma Science and Fusion Center","url":"https://www.psfc.mit.edu/","type":"article","source":"MIT"},
    {"title":"NASA Glenn Electric Propulsion","url":"https://www.nasa.gov/glenn/research/space-flight-systems/electric-propulsion/","type":"article","source":"NASA"},
    {"title":"Plasma engineering basics","url":"https://www.youtube.com/results?search_query=plasma+engineering+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"complexity-scale","title":"Regime estremo","caption":"Superate certe soglie, il sistema entra in domini fisici qualitativamente diversi."},
    {"kind":"verification-stack","title":"Containment strategy","caption":"Materiali, isolamento, sensing e limiti operativi cooperano per confinare il rischio."}
  ]'::jsonb
where slug = 'plasma-high-energy-and-extreme-systems';

update public.topics
set
  estimated_minutes = 30,
  overview = 'Verification, rischio e MBSE diventano fondamentali quando il sistema è troppo complesso per essere gestito solo con memoria informale e test finali. Requisiti, modelli, interfacce, casi di test e rischi devono rimanere collegati lungo tutto il ciclo, altrimenti l integrazione produce sorprese che arrivano troppo tardi e costano troppo.

Il valore del model-based thinking non è la burocrazia del diagramma, ma la capacità di mantenere coerenza: cosa deve fare il sistema, come lo modelli, come lo verifichi, quali margini hai, quali failure mode stai coprendo e quali restano aperti. La gestione del rischio è il meccanismo che prioritizza questa energia.

Questo topic porta MBSE e verification fuori dal linguaggio astratto e li rende strumenti decisionali concreti.',
  key_takeaways = array[
    'Ogni requisito serio dovrebbe avere una traccia verso modello, rischio e metodo di verifica.',
    'La verification planning riduce costo e incertezza se entra presto nel design.',
    'MBSE serve a mantenere coerenza tra viste diverse dello stesso sistema.',
    'Il rischio va collegato a margini, test e decisioni architetturali, non tenuto in un registro separato.'
  ],
  study_blocks = '[
    {"title":"Tracciabilità utile","content":"Un sistema matura quando puoi seguire un filo continuo tra esigenza di missione, requisito, interfaccia, modello, rischio e verifica. Questa catena rende leggibili impatti di modifica, zone scoperte e assunzioni implicite che altrimenti emergerebbero solo durante l integrazione."},
    {"title":"Verification by design","content":"Test, analisi, ispezione e dimostrazione non andrebbero scelti a valle in modo opportunistico. Un requisito nasce più forte se già sai come pensi di verificarlo, con quali margini e a quale livello del sistema."},
    {"title":"MBSE come compressione di complessità","content":"Modelli e viste architetturali permettono di gestire complessità multi-dominio senza affidarsi a documenti scollegati o memoria orale. Il loro valore vero è mantenere sincronizzati comportamento, struttura, interfacce e verifiche."},
    {"title":"Rischio come motore di priorità","content":"Non tutto può essere verificato con la stessa intensità. Il rischio aiuta a decidere dove concentrare test, ridondanza, margine e simulazione. Un processo maturo usa il rischio per guidare il design, non per commentarlo a posteriori."}
  ]'::jsonb,
  formulas = '[
    {"label":"Risk exposure intuition","expression":"Exposure approx probability * consequence","note":"Stima qualitativa utile per priorizzare i rischi."},
    {"label":"Margin","expression":"Margin = capability - requirement","note":"Il margine rende visibile quanto buffer reale ha il sistema."},
    {"label":"Coverage intuition","expression":"Coverage = verified_items / total_items","note":"Indicatore semplice di copertura della verifica, da leggere con attenzione al peso dei casi."}
  ]'::jsonb,
  "references" = '[
    {"title":"NASA Systems Engineering Handbook","url":"https://www.nasa.gov/reference/systems-engineering-handbook/","type":"handbook","source":"NASA"},
    {"title":"INCOSE Systems Engineering Handbook","url":"https://www.incose.org/products-and-publications/se-handbook","type":"handbook","source":"INCOSE"},
    {"title":"MBSE basics","url":"https://www.youtube.com/results?search_query=mbse+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"verification-stack","title":"Verification flow","caption":"Analisi, test, ispezione e dimostrazione devono collegarsi ai requisiti che intendono chiudere."},
    {"kind":"interface-contract","title":"Traceability map","caption":"Un modello utile collega requisiti, interfacce, rischi e verifiche nello stesso spazio decisionale."}
  ]'::jsonb
where slug = 'verification-risk-and-mbse';

update public.topics
set
  estimated_minutes = 30,
  overview = 'Requisiti, budget e interfacce sono il luogo in cui l architettura diventa governabile. Un sistema complesso si rompe spesso non perché i sottosistemi siano tutti sbagliati, ma perché nessuno ha reso esplicito chi possiede quale margine, quali ipotesi reggono l interfaccia e cosa succede se un budget viene sforato.

Il punto forte non è scrivere più requisiti, ma scriverli in modo che aiutino decisioni, decomposizione e integrazione. Un budget di massa, potenza, latenza, accuratezza o termica è una forma di disciplina architetturale: rende visibili i compromessi prima che si materializzino in colli di bottiglia o instabilità.

Questo topic porta requisiti e interfacce al livello di strumenti di pensiero architetturale.',
  key_takeaways = array[
    'Un buon requisito è misurabile, testabile e collegato alla missione del sistema.',
    'I budget trasformano conflitti impliciti in tradeoff espliciti e governabili.',
    'Le interfacce devono definire anche timing, qualità del dato, ownership e fallback.',
    'Molti problemi di integrazione nascono da contratti tecnici incompleti, non da singoli componenti difettosi.'
  ],
  study_blocks = '[
    {"title":"Requirement flowdown serio","content":"Un obiettivo di sistema va scomposto in requisiti di sottosistema coerenti, misurabili e compatibili. Se il flowdown è debole, i conflitti riemergono tardi durante integrazione e test, quando ogni modifica costa di più."},
    {"title":"Budget come disciplina","content":"Massa, energia, banda, latenza, costo, margine termico e accuratezza non sono solo numeri di tabella: sono vincoli di design che devono essere allocati, monitorati e rinegoziati. Un budget forte costringe a trattare l architettura come sistema finito, non come desiderio illimitato."},
    {"title":"Interfacce come contratti dinamici","content":"Un interfaccia buona specifica segnali, unità, rate, qualità, ownership, fault behavior e fallback. Questo evita che due team “abbiano entrambi ragione” localmente ma producano insieme un sistema ingestibile."},
    {"title":"Conflitto produttivo","content":"Requisiti e budget servono anche a far emergere conflitti in tempo utile. Il loro valore non è eliminare il compromesso, ma farlo emergere quando è ancora negoziabile e non quando è già un bug di sistema."}
  ]'::jsonb,
  formulas = '[
    {"label":"Budget closure intuition","expression":"sum allocated <= total available","note":"Ogni budget deve chiudere entro il limite di sistema disponibile."},
    {"label":"Latency chain","expression":"T_total = sum T_i","note":"La latenza end-to-end nasce dalla somma dei contributi di sottosistema."},
    {"label":"Power margin","expression":"Margin = P_available - P_required","note":"Rende leggibile quanto margine reale resta dopo allocazione."}
  ]'::jsonb,
  "references" = '[
    {"title":"INCOSE Systems Engineering Handbook","url":"https://www.incose.org/products-and-publications/se-handbook","type":"handbook","source":"INCOSE"},
    {"title":"NASA Systems Engineering Handbook","url":"https://www.nasa.gov/reference/systems-engineering-handbook/","type":"handbook","source":"NASA"},
    {"title":"Requirements engineering basics","url":"https://www.youtube.com/results?search_query=requirements+engineering+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"interface-contract","title":"Contratto di interfaccia","caption":"Ogni confine tra sottosistemi deve rendere espliciti dati, timing, margini e failure behavior."},
    {"kind":"trade-study","title":"Budget architecture","caption":"Ogni budget allocato riduce libertà locale ma aumenta governabilità di sistema."}
  ]'::jsonb
where slug = 'system-requirements-and-interfaces';

update public.topics
set
  estimated_minutes = 31,
  overview = 'Machine learning, decisione e autonomia diventano maturi quando smetti di chiedere solo quanto il modello sia accurato e inizi a chiedere come prende decisioni sotto incertezza, quali failure mode introduce, come si degrada, quando deve cedere controllo e come si inserisce nel safety case del sistema.

Il nodo importante è che autonomia non significa eliminare il controllo umano o simbolico, ma distribuire responsabilità tra stima, decisione, pianificazione, monitoraggio e fallback. Qui il rischio non è solo sbagliare una predizione, ma trasformare un errore di percezione o generalizzazione in un azione fisica sbagliata.

Questo topic rende l autonomia leggibile come architettura decisionale sotto vincoli, non come magia statistica.',
  key_takeaways = array[
    'Un sistema autonomo deve sapere agire ma anche sapere quando non sa.',
    'ML e decisione vivono dentro limiti di dati, distribuzione, latenza e safety.',
    'Monitoraggio, confidence estimation e fallback sono parte del comportamento autonomo.',
    'L autonomia matura nasce da integrazione tra modelli, regole, verifica e degradazione controllata.'
  ],
  study_blocks = '[
    {"title":"Dal modello alla policy","content":"Un classificatore o un policy network non decide da solo in modo affidabile. Serve un contesto architetturale che definisca quali input riceve, con quale confidenza, sotto quali vincoli opera e quali atti del mondo può davvero comandare."},
    {"title":"Out-of-distribution e uncertainty","content":"Molti sistemi autonomi falliscono non nel caso medio ma quando incontrano condizioni non viste, dati ambigui o conflitti tra segnali. Qui la capacità di riconoscere bassa confidenza e passare a una modalità più prudente è più importante della prestazione media nominale."},
    {"title":"Decisione come compromesso","content":"Pianificare una decisione significa bilanciare obiettivi concorrenti: velocità, sicurezza, costo energetico, missione, robustezza. Questo rende l autonomia un problema di ottimizzazione e gestione del rischio, non solo di inferenza."},
    {"title":"Safe autonomy","content":"Un sistema autonomo forte combina percezione, stima, controllo, monitoraggio e fallback. La parte difficile non è muoversi quando tutto va bene, ma degradare in modo sensato quando sensori, modelli o attuatori non sono più affidabili."}
  ]'::jsonb,
  formulas = '[
    {"label":"Expected cost intuition","expression":"J = E[cost(action, state)]","note":"Una decisione razionale minimizza costo atteso sotto incertezza."},
    {"label":"Confidence threshold","expression":"act if p(confident) > tau","note":"Semplifica l idea di attivare azioni solo sopra una certa fiducia."},
    {"label":"Belief update intuition","expression":"belief_new prop likelihood * belief_old","note":"La decisione autonoma vive spesso su credenze aggiornate, non su stato certo."}
  ]'::jsonb,
  "references" = '[
    {"title":"MIT Underactuated - Planning and Decision Making","url":"https://underactuated.mit.edu/","type":"handbook","source":"MIT"},
    {"title":"Safe and Robust AI resources","url":"https://hai.stanford.edu/","type":"article","source":"Stanford HAI"},
    {"title":"Autonomy and safety basics","url":"https://www.youtube.com/results?search_query=autonomy+safety+basics","type":"video","source":"YouTube"}
  ]'::jsonb,
  visuals = '[
    {"kind":"feedback-loop","title":"Decision loop","caption":"Percezione, stima, scelta e fallback convivono in un ciclo chiuso che deve restare sicuro."},
    {"kind":"trade-study","title":"Autonomia vs supervisione","caption":"Più autonomia utile richiede più attenzione a confidenza, monitoraggio e degradazione."}
  ]'::jsonb
where slug = 'ml-decision-and-autonomy';
