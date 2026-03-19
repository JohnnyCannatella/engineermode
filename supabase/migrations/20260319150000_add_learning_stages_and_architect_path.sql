alter table public.learning_paths
  add column if not exists learning_stage text;

alter table public.learning_paths
  drop constraint if exists learning_paths_learning_stage_check;

alter table public.learning_paths
  add constraint learning_paths_learning_stage_check
  check (learning_stage in ('foundation', 'builder', 'inventor', 'architect'));

update public.learning_paths
set learning_stage = case slug
  when 'systems-foundations' then 'foundation'
  when 'electronics-basics' then 'builder'
  when 'mechanical-thinking' then 'builder'
  when 'software-systems' then 'builder'
  when 'energy-control' then 'inventor'
  when 'ai-simulation' then 'inventor'
  when 'materials-fabrication' then 'inventor'
  else coalesce(learning_stage, 'foundation')
end;

insert into public.learning_paths (
  title,
  slug,
  description,
  icon,
  color,
  order_index,
  mission_count,
  is_published,
  area_slug,
  learning_stage
)
values (
  'Systems Architecture',
  'systems-architecture',
  'Trade studies, interfacce, verification e integrazione per passare da builder a architect.',
  '🛰️',
  '#38bdf8',
  8,
  4,
  true,
  'systems-thinking',
  'architect'
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
  area_slug = excluded.area_slug,
  learning_stage = excluded.learning_stage;

with architect_path as (
  select id from public.learning_paths where slug = 'systems-architecture'
)
delete from public.missions
where path_id = (select id from architect_path);

with architect_path as (
  select id from public.learning_paths where slug = 'systems-architecture'
)
insert into public.missions (
  path_id,
  title,
  description,
  icon,
  xp_reward,
  estimated_minutes,
  order_index,
  is_published,
  difficulty_level,
  learning_objectives,
  review_after_days,
  steps
)
select
  architect_path.id,
  mission.title,
  mission.description,
  mission.icon,
  mission.xp_reward,
  mission.estimated_minutes,
  mission.order_index,
  true,
  'advanced',
  mission.learning_objectives,
  mission.review_after_days,
  mission.steps::jsonb
from architect_path
cross join (
  values
    (
      'Requirement Budgets e Trade Studies',
      'Definire budget, vincoli e criteri di scelta prima di scegliere componenti o algoritmi.',
      '📐',
      180,
      10,
      1,
      array['Tradurre obiettivi in budget misurabili', 'Leggere i tradeoff senza inseguire massimi locali', 'Usare trade study credibili'],
      5,
      '[
        {"type":"lesson","emoji":"📦","title":"I Budget Governano il Progetto","content":"Nei sistemi complessi non progetti per desideri astratti ma per budget: massa, potenza, latenza, temperatura, costo, volume, affidabilita. Ogni sottosistema consuma parte di questi budget, e se uno sfora mette in crisi l intera architettura.","key_points":["I budget trasformano obiettivi vaghi in limiti progettuali","Ogni sottosistema consuma massa, potenza, costo o complessita","Architettura significa distribuire risorse scarse"]},
        {"type":"lesson","emoji":"⚖️","title":"Trade Study","content":"Un trade study non sceglie la soluzione piu brillante in assoluto: confronta opzioni rispetto ai criteri che contano davvero. Una scelta forte rende esplicito cosa stai ottimizzando e cosa stai sacrificando.","key_points":["Ogni scelta forte esplicita criteri e compromessi","Massimizzare una sola metrica produce architetture fragili","La tabella decisionale e uno strumento, non una scusa"]},
        {"type":"design","title":"Design Review: Propulsione del Suit","brief":"Stai progettando una piattaforma volante compatta. Hai un budget termico stretto, massa totale limitata e autonomia minima da rispettare. Devi scegliere se privilegiare motori piu aggressivi o un sistema piu efficiente e modulare.","constraints":["Massa totale sotto 95 kg","Autonomia minima 11 minuti","Temperatura interna sotto soglia di sicurezza","Controllo stabile anche in hovering"],"question":"Qual e l impostazione di progetto piu matura?","options":["Massimizzare subito la spinta senza formalizzare i budget","Costruire un trade study che pesi spinta, efficienza, termica e controllo rispetto ai budget","Scegliere il componente piu costoso per ridurre il rischio","Separare completamente energia, controllo e termica per semplificare il lavoro"],"correct":1,"explanation":"Se non formalizzi i budget, l architettura collassa su massimi locali. La scelta matura confronta opzioni rispetto a vincoli di sistema, non a intuizioni isolate.","tradeoffs":["Piu spinta spesso significa piu consumo e piu dissipazione","Modularita aumenta controllabilita ma puo costare massa","I budget servono per negoziare tra sottosistemi, non per decorare un documento"]},
        {"type":"challenge","title":"Review con Jarvis","scenario":"Il team propone una batteria piu grande per recuperare autonomia, ma questo aumenta massa e carico sugli attuatori.","question":"Qual e la risposta architetturale corretta?","options":["Accettare la batteria piu grande perche l autonomia e la metrica principale","Rifare il trade study per verificare l impatto su massa, termica, controllo e struttura","Ignorare massa e controllo finche il prototipo non vola","Spostare il problema sul software di stabilizzazione"],"correct":1,"explanation":"Una modifica di un sottosistema cambia l equilibrio globale. La risposta corretta e rivalutare i budget, non inseguire una singola metrica."}
      ]'
    ),
    (
      'Interface Contracts e Failure Containment',
      'Progettare interfacce tra moduli e limitare la propagazione dei guasti.',
      '🔌',
      185,
      11,
      2,
      array['Definire interfacce tra sottosistemi', 'Ridurre accoppiamenti nascosti', 'Isolare failure mode'],
      6,
      '[
        {"type":"lesson","emoji":"🧩","title":"Le Interfacce Sono Architettura","content":"Due sottosistemi non si parlano soltanto tramite cavi o API. Condividono assunzioni su timing, formato dati, potenza disponibile, frequenze di aggiornamento, modalita di fallback e limiti operativi. Le interfacce sono il luogo dove l architettura diventa reale.","key_points":["Interfaccia significa contratto, non solo collegamento","Timing, energia e semantica fanno parte della stessa interfaccia","Interfacce ambigue moltiplicano i failure mode"]},
        {"type":"lesson","emoji":"🛡️","title":"Failure Containment","content":"In un sistema maturo un modulo che fallisce non deve contagiare tutti gli altri. Contenere un guasto significa limitare propagazione, degrado e comportamenti incontrollati attraverso isolamento, watchdog, limiti e modalita sicure.","key_points":["Non tutti i guasti devono diventare guasti globali","Isolare e degradare bene e meglio che inseguire l invulnerabilita","I confini di failure sono parte della progettazione"]},
        {"type":"design","title":"Design Review: Bus di Sensori e Flight Controller","brief":"Hai radar, IMU, visione e attuatori collegati a un controller di volo. Alcuni moduli possono perdere pacchetti o ritardare. Devi decidere come definire il contratto tra sensing e controllo.","constraints":["Il loop di controllo non puo attendere dati indefinitamente","Una misura assente non deve bloccare l intero sistema","Le modalita degradate devono restare esplicite","Il debug dei fault deve essere leggibile"],"question":"Qual e il contratto piu solido?","options":["Il controller aspetta sempre tutti i sensori per avere informazione completa","Ogni interfaccia dichiara frequenza, timeout, qualita del dato e comportamento in assenza di misura","I sensori pubblicano dati quando capita e il controllo si adatta","Si fondono tutti i dati nello stesso task senza separazione di responsabilita"],"correct":1,"explanation":"Un contratto forte esplicita timing, qualita e fallback. Questo rende il sistema osservabile e limita la propagazione dei fault.","tradeoffs":["Sincronizzazione perfetta aumenta latenza e fragilita","Timeout e data quality migliorano robustezza ma richiedono progettazione intenzionale","Un interfaccia leggibile accelera anche il debug"]},
        {"type":"quiz","question":"Qual e il segno di una buona interfaccia di sistema?","options":["Nasconde i limiti per semplificare la demo","Dichiara assunzioni, vincoli e modalita di degrado","Riduce tutto a un unico canale generico","Massimizza il throughput senza definire fallback"],"correct":1,"explanation":"Un interfaccia matura rende esplicite le assunzioni e definisce cosa succede quando le cose vanno male."}
      ]'
    ),
    (
      'Verification, Test Matrix e HIL',
      'Verificare un sistema complesso con prove progressive, strumentazione e hardware-in-the-loop.',
      '🧪',
      190,
      12,
      3,
      array['Distinguere test di componente, integrazione e sistema', 'Usare HIL per ridurre rischio', 'Pensare in verification matrix'],
      6,
      '[
        {"type":"lesson","emoji":"✅","title":"Verification vs Demo","content":"Una demo mostra che qualcosa funziona una volta. La verification dimostra che il sistema soddisfa requisiti osservabili su una gamma di condizioni rilevanti. La differenza tra i due mondi e enorme.","key_points":["Demo non equivale a verification","Testare significa mappare condizioni e criteri di accettazione","La verification richiede tracciabilita verso i requisiti"]},
        {"type":"lesson","emoji":"🎛️","title":"Hardware-in-the-Loop","content":"Con HIL fai girare il software reale contro modelli o banchi controllati che simulano parte del mondo fisico. Questo permette di validare timing, fault handling e integrazione prima del test pienamente reale.","key_points":["HIL riduce rischio e costo dei test sul campo","Permette fault injection e casi rari","Il banco di test e parte dell architettura di sviluppo"]},
        {"type":"design","title":"Design Review: Piano di Verifica del Suit","brief":"Stai validando un sistema con sensing, controllo, attuazione e gestione termica. Il team vuole andare subito al test completo di volo per risparmiare tempo.","constraints":["Un fallimento in prova completa e costoso","Serve identificare failure mode per sottosistema","Il software reale deve essere testato sotto timing credibili","Devi produrre evidenza riutilizzabile"],"question":"Qual e la strategia piu forte?","options":["Andare subito al test integrato completo per vedere cosa succede","Costruire una matrice di verifica con test progressivi di componente, integrazione e HIL prima del test pieno","Concentrarsi solo sui test software perche il resto emergera dopo","Provare solo i casi nominali per accelerare il rilascio"],"correct":1,"explanation":"La verification matura riduce ambiguita e costo dei failure mode, costruendo evidenza progressiva prima del test piu rischioso.","tradeoffs":["Test integrati troppo precoci rendono opachi i failure mode","HIL costa preparazione ma accelera l apprendimento","Una matrice di verifica connette requisiti, prove ed evidenze"]},
        {"type":"challenge","title":"Banco Prove Reattore","scenario":"Un modulo termico si comporta bene isolato ma degrada quando gira insieme a controllo e attuazione.","question":"Cosa rivela questo problema?","options":["Che i test isolati sono inutili","Che servono livelli diversi di test e una verifica di integrazione ben strumentata","Che il problema e certamente software","Che basta aumentare le soglie di sicurezza"],"correct":1,"explanation":"I test per sottosistema sono necessari ma non sufficienti. L integrazione va verificata con strumenti e criteri espliciti."}
      ]'
    ),
    (
      'Capstone: Architettura dell Arc Reactor',
      'Integrare energia, controllo, sensing, AI e safety in una decisione architetturale coerente.',
      '🧠',
      240,
      14,
      4,
      array['Integrare sottosistemi in una visione unica', 'Esplicitare tradeoff architetturali', 'Pensare in sicurezza, verifica e manutenibilita'],
      7,
      '[
        {"type":"lesson","emoji":"🌐","title":"Architettura come Coerenza Globale","content":"Il systems architect non sceglie soltanto componenti forti. Costruisce una storia coerente tra potenza, informazione, controllo, struttura, termica, safety e verification. L architettura forte e quella che rimane credibile quando i sottosistemi iniziano a litigare tra loro.","key_points":["Architettura = coerenza globale sotto vincoli","I conflitti tra sottosistemi non sono eccezioni, sono il lavoro","Le decisioni vanno giustificate nel sistema completo"]},
        {"type":"lesson","emoji":"🧭","title":"Decisione Finale","content":"Arriva sempre il momento in cui non puoi piu rimandare la scelta: devi congelare un architettura abbastanza buona da costruire e abbastanza robusta da evolvere. Questo richiede priorita chiare, margini e piani di fallback.","key_points":["Una buona architettura accetta compromessi intenzionali","Serve margine per l ignoto, non solo ottimismo","Fallback e testability sono criteri di primo livello"]},
        {"type":"design","title":"Capstone Review: Mk IV Reactor Stack","brief":"Devi definire l architettura di una piattaforma avanzata con bus di potenza, conversione locale, flight control, sensor fusion, visione assistita da ML, raffreddamento attivo e modalita degradate. Il sistema deve restare controllabile anche con fault parziali e deve poter essere verificato in banco prima del dispiegamento.","constraints":["Massa e termica sono fortemente limitate","Il sistema deve continuare in modalita degradata sotto fault parziali","Ogni interfaccia deve essere testabile e osservabile","La catena di verifica deve esistere prima del test finale"],"question":"Qual e l architettura piu matura?","options":["Massimizzare ogni sottosistema singolarmente e integrare in seguito","Scegliere un architettura modulare con contratti espliciti, budget condivisi, fallback e piano di verification progressiva","Concentrare tutto in un singolo super-controller per ridurre complessita apparente","Prioritizzare solo la potenza di picco e affidarsi al tuning successivo"],"correct":1,"explanation":"L architettura matura non vince su una sola metrica. Coordina budget, interfacce, fallback e verification in una struttura integrabile e manutenibile.","tradeoffs":["Maggiore modularita migliora test e isolamento ma introduce overhead di interfaccia","Potenza di picco senza budget condivisi distrugge termica e affidabilita","Il piano di verification fa parte dell architettura, non del post-processing"]},
        {"type":"challenge","title":"Design Freeze","scenario":"Il team e diviso: alcuni vogliono piu autonomia, altri piu agilita, altri piu AI locale. Nessuna opzione massimizza tutto.","question":"Qual e la postura da systems architect?","options":["Scegliere il modulo piu spettacolare e adattare il resto","Formalizzare priorita, margini e tradeoff architetturali prima di congelare il design","Rimandare tutte le decisioni al prototipo finale","Lasciare che ogni team ottimizzi localmente il proprio modulo"],"correct":1,"explanation":"Il systems architect rende esplicite le priorita globali e accetta compromessi coerenti. Senza questa regia, i team ottimizzano localmente e il sistema peggiora."}
      ]'
    )
) as mission(title, description, icon, xp_reward, estimated_minutes, order_index, learning_objectives, review_after_days, steps);

with architect_missions as (
  select id, order_index
  from public.missions
  where path_id = (select id from public.learning_paths where slug = 'systems-architecture')
)
insert into public.mission_prerequisites (mission_id, prerequisite_mission_id)
select current_mission.id, previous_mission.id
from architect_missions current_mission
join architect_missions previous_mission
  on current_mission.order_index = previous_mission.order_index + 1
on conflict do nothing;
