# Besvarelse på refleksjonspørsmålene

Ditt brukernavn på Oslomet: 

## Refleksjonsspørsmål Oppgave 1 

S1: Hva er fordelene med å lagre data i et slikt format (CSV - Comma Separated Values)?
- Ditt svar:
  
S2: Hva skjer hvis et av feltene, for eksempel et navn, inneholder et komma? Hvilke problemer skaper det for din parsing-logikk?
- Ditt svar: 

S3: Beregning av lagringsbehov

S3.1: La oss lage en forenklet modell for vår fil. Anta at hvert tegn (character) er 1 byte (dette er en forenkling, f.eks. husk UTF-8). Regn ut den omtrentlige størrelsen i bytes for én linje i din fil studenter.csv (f.eks., en linje er 101,Mickey,CS). Ikke glem å telle med kommaene og et tegn for linjeskift.
- Ditt svar:

S3.2 Basert på denne beregningen, hva ville den teoretiske filstørrelsen vært for 1 million studenter? Hvor stor for 1 milliard studenter? Uttrykk svarene i MB, GB eller TB.
- Ditt svar:

## Refleksjonsspørsmål Oppgave 2

S1: Sammenlign tidene fra de tre testene (liten fil, tidlig treff i stor fil, og sent treff i stor fil). Hva forteller dette deg om ytelsen til en lineær skanning?
- Ditt svar:
  
S2: Hvilken rolle spiller **BufferedWriter** (en klasse i Java standard I/O biblioteket), hvis den brukes i datageneratoren? Forklar konsepter fra forelesningen, som IO Blocks og bufring.
- Ditt svar: 

S3: Teoretisk lesetid:  

S3.1 Hva blir den faktiske filstørrelsen hvis det er 1 millioner rader i filen med brukerdata (format spesifisert i Oppgave 2.1).
- Ditt svar:
  
S3.2 Bruk tabellen i sliden *“Lagringsmedier – fra rask til billig”* fra forelesningen. Hva ville den teoretiske tiden vært for å lese hele denne filen (en full "scan") fra henholdsvis en **HDD (Hard Disk)** og en **High-end SSD**?
- Ditt svar: 

S3.3 Anta at følgende formel gjelder: 
```
Total Time \= AccessLatency \* M \+ DataSize/ScanThroughput 
```
For en full, sekvensiell skanning kan vi anta at M=1 (dataene leses som én stor, sammenhengende blokk). Sammenlign de teoretiske tidene med den faktiske tiden du målte i Oppgave 2.3 (Stor fil, sent treff). Hvorfor kan tidene være forskjellige? (Hint: Tenk på operativsystemets fil-caching, CPU-bruk for parsing i Java, etc.).
- Ditt svar:

## Refleksjonsspørsmål Oppgave 3

S1: Hvorfor er det mer effektivt å lese **studenter.csv** og **kurs.csv** inn i HashMap først, i stedet for å søke gjennom filene for hver eneste linje i **paameldinger.csv**?
- Ditt svar:
  
S2: Lagringsplass og minnebruk:

La oss si vi har 1 million studenter, 1000 kurs, og hver student tar i gjennomsnitt 5 kurs (totalt 5 millioner påmeldinger).

**Scenario A (Ikke-normalisert):** Vi lagrer \`studentID, fornavn, etternavn, kursID, kursnavn\` på hver linje. Anta at studentinfo trenger 100 bytes og kursinfo trenger 50 bytes for lagring. Hva blir den totale filstørrelsen for de 5 millioner påmeldingene?
- Ditt svar:

**Scenario B (Normalisert):** Vi har tre filer. Beregn den totale størrelsen for **studenter.csv** (1M rader), **kurs.csv** (1000 rader), og **paameldinger.csv** (5M rader, inneholder kun to ID-er, f.eks. 8 bytes totalt per rad).  
Sammenlign total lagringsplass i Scenario A og B. Hvor mye plass sparer vi på normalisering?
- Ditt svar: 

S3: I din Java-løsning lastet du data inn i RAM. Se på tabellen i sliden *“Lagringsmedier – fra rask til billig”*. Hva er den typiske kostnaden per TB for RAM sammenlignet med SSD og HDD? Hvorfor er det en viktig vurdering om en datastruktur (som din HashMap-indeks) passer i RAM eller ikke?
- Ditt svar: 

## Refleksjonsspørsmål Oppgave 4 

S1: Hva er den observerte tidsforskjellen mellom det lineære søket og det indekserte oppslaget? Hvorfor er forskjellen så enorm?
- Ditt svar:
- 
S2: Hvilken lagringstype (RAM, SSD, HDD) opererer HashMap\-oppslaget på, og hva er den tilhørende “Aksesstid” ifølge tabellen fra forelesningene i sliden *“Lagringsmedier – fra rask til billig”*?
- Ditt svar:
- 
Kostnaden ved en indeks:  
S3: Hvor stor ble din brukere.idx\-fil? Sammenlign størrelsen med brukere.csv.
- Ditt svar:
  
S4: En indeks er ikke gratis, den tar opp ekstra lagringsplass. Hvis indeksen din var 200 MB, hva ville den kostet å lagre den på en HDD? Hva med en SSD? Bruk tallene fra forelesningen, slide *“Lagringsmedier – fra rask til billig”*. Er dette en akseptabel kostnad for den ytelsesgevinsten du får? (Hint: *“tid/plass trade-off”*)
- Ditt svar: 



SLUTT.
