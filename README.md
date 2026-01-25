# Oppgavesett 1.1

## Oversikt

Oppgavesettet 1.1 består av 4 deloppgaver. Nummerering “1.1” tolkes slik at den første “1” betyr første del av grunnpensum (se Veikart i Canvas) og den andre “1” betyr nummer til oppgaven inn i et oppgavesett.   
   
Tiden er grovt estimert og avhenger av, blant annet, tidligere kjennskap til temaene, kjennskap til hjelpeverktøy og motivasjon. Bruk gjerne LLM, men det er viktig å forstå hva koden gjør.

**Oppgave 1:** Data som Tekst (ca. 1.5 timer)  
  \- Fokus: Representasjon, parsing, grunnleggende fil-I/O.  
  \- Beregne teoretisk lagringsstørrelse.

**Oppgave 2:** Jakten på Data \- Ytelse i Små og Store Filer (ca. 2.5 timer)  
  \- Fokus: Lineær skanning, ytelsesfall, bufring.  
  \- Beregne filstørrelse og teoretisk lesetid fra disk.

**Oppgave 3:** Normalisering og "Joins" på Filer (ca. 2.5 timer)  
  \- Fokus: Dataredundans, \`HashMap\` for "joins" i minnet.  
  \- Analysere lagringsbesparelse og vurdere minnebruk (RAM).

**Oppgave 4:** Kraften av Indeksering (ca. 1.5 timer)  
  \- Fokus: Ytelsesgevinst ved indeksering.  
  \- Kvantifisere kostnaden (i lagring) av en indeks og koble ytelsesgevinsten til I/O-kostnadsmodellen.

## Programmeringsmiljø og testing

Viktige momenter:
- For å utføre koden må `java` være installert. Under utvikling av denne oppgaven ble `openjdk 25.0.1` på en `macOS Sonoma 14.3.1` brukt. 
- Man kan selv velge om man ønsker å bruke en IDE (Integrated Development Environment) eller en frittstående editor (Sublime Text ble brukt under utviklingen av oppgaven).
- Denne repository-en inneholder en skript for "autograding", dvs. at tester på koden utføres, hver gang man gjør en "commit" fra sin lokale datamaskin. En "commit" betyr at man kopierer koden fra sin lokale datamaskin til repository-en i Github (den består av tre steg: `git add`, `git commit` og `git push`). Hver "commit" vil starte en prosess (Github actions) i en nettsky, som krever en god del energi for å bli utført. Derfor, er det sterkt anbefalt å teste koden før man gjør en "commit" til Github. I denne repository-en finnes det 3 skript-filer:
  - `test-local.sh` (for macOS og Linux)
  - `test-local.bat` (for MS Windows, kaller opp test-local.psi)
  - `test-local.psi` (for MS Windows Powershell)

Du må selv sørge for at skript-filen har de nødvendige rettighetene for å kunne bli utført. På macOS og Linux skal man utføre følgende kommandoer:
```
$ git clone <repository_med_oppgaven>
$ cd <repository_navn>
$ chmod 755 test-local.sh
```


## Deloppgaver

### Oppgave 1: Min Første "Database" \- Data som Tekst (ca. 1.5 timer)

1\. Opprett datafilen **studenter.csv** og skriv inn følgende fire linjer:
```
101,Mickey,CS  
102,Daffy,EE  
103,Donald,CS  
104,Minnie,PSY
```
2\.  Lag en **Student**\-klasse i Java. Klassen skal være en indre klasse (en. inner class), som defineres på lik nivå med hovedklassen og i samme fil som hovedklassen.

3\.  Skriv resten av et Java-program i filen **LesStudenter.java**, som finner og leser all data fra filen **studenter.csv**, legger inn hver linje i en instanse av klassen **Student** og skriver ut hvert objekti til **stdout**. Filnavn skal leses inn fra kommandolinje (vha. args parameter i metoden main).

Utskriften til **stdout** (output) skal være følgende:
```
Student{id=101, navn='Mickey', program='CS'}  
Student{id=102, navn='Daffy', program='EE'}  
Student{id=103, navn='Donald', program='CS'}  
Student{id=104, navn='Minnie', program='PSY'}
```
#### Refleksjonsspørsmål:

S1: Hva er fordelene med å lagre data i et slikt format (CSV \- Comma Separated Values)?

S2: Hva skjer hvis et av feltene, for eksempel et navn, inneholder et komma? Hvilke problemer skaper det for din parsing-logikk?

S3: Beregning av lagringsbehov

S3.1: La oss lage en forenklet modell for vår fil. Anta at hvert tegn (character) er 1 byte (dette er en forenkling, f.eks. husk UTF-8). Regn ut den omtrentlige størrelsen i bytes for én linje i din fil **studenter.csv** (f.eks., en linje er 101,Mickey,CS). Ikke glem å telle med kommaene og et tegn for linjeskift.

S3.2 Basert på denne beregningen, hva ville den teoretiske filstørrelsen vært for **1 million** studenter? Hvor stor for **1 milliard** studenter? Uttrykk svarene i MB, GB eller TB.   
\---

### Oppgave 2: Ytelsessjokket \- Lineær Skanning (ca. 2.5 timer)

1\. Lag en datagenerator **DataGenerator.java**, som lager en CSV-fil, for eksempel **brukere.csv** med følgende format for hver post: 
```
1,bruker1@epost.no,Navn Navnesen 1
```
Kommandoen for å generere filen skal være på følgende format og lese inn 2 argumenter fra kommandolinje: 
```
java DataGenerator *\<navn\_ny\_fil\_med\_brukerdata\>* *\<antall\_poster\_i\_ny\_fil\>*
```
hvor det første argumentet *\<navn\_ny\_fil\_med\_brukerdata\>* er filnavn til den nye filen og det andre argumentet *\<antall\_poster\_i\_ny\_fil\>* er antall linjer/poster i filen som blir generert.

2\.  Lag et søkeprogram **FinnBruker.java**, som måler tiden det tar for å finne data for en bruker basert på brukerens epostadressen, og også skriver ut disse dataene, f. eks. for  bruker1@epost.no. 

Kommandoen skal lese inn 2 argumenter fra kommandolinje:
```
java FinnBruker *\<navn\_fil\_med\_brukerdata\>* *\<epost\_adressen\>*
```
hvor det første arugmentet *\<navn\_fil\_med\_brukerdata\>* er filnavn, som inneholder informasjon om brukere (som vi kan betrakte som en database), og det andre argumentet er teksten vi søker etter, i dette tilfeller en epostadresse. 

3\. Utfør eksperimentet: test **FinnBruker** med liten fil, tidlig treff i stor fil, og sent treff i stor fil.  
```
java DataGenerator brukere\_100.csv 100  
java FinnBruker brukere\_100.csv bruker55@epost.no  
java DataGenerator brukere\_10000.csv 10000  
java FinnBruker brukere\_10000.csv bruker10@epost.no  
java FinnBruker brukere\_10000.csv bruker9999@epost.no
```
#### Refleksjonsspørsmål:

S1: Sammenlign tidene fra de tre testene (liten fil, tidlig treff i stor fil, og sent treff i stor fil). Hva forteller dette deg om ytelsen til en lineær skanning?

S2: Hvilken rolle spiller **BufferedWriter** (en klasse i Java standard I/O biblioteket), hvis den brukes i datageneratoren? Forklar konsepter fra forelesningen, som IO Blocks og bufring.

S3: Teoretisk lesetid:  
S3.1 Hva blir den faktiske filstørrelsen hvis det er 1 millioner rader i filen med brukerdata (format spesifisert i Oppgave 2.1).

S3.2 Bruk tabellen i sliden *“Lagringsmedier – fra rask til billig”* fra forelesningen. Hva ville den teoretiske tiden vært for å lese hele denne filen (en full "scan") fra henholdsvis en **HDD (Hard Disk)** og en **High-end SSD**?

S3.3 Anta at følgende formel gjelder: 
```
Total Time \= AccessLatency \* M \+ DataSize/ScanThroughput 
```
For en full, sekvensiell skanning kan vi anta at M=1 (dataene leses som én stor, sammenhengende blokk). Sammenlign de teoretiske tidene med den faktiske tiden du målte i Oppgave 2.3 (Stor fil, sent treff). Hvorfor kan tidene være forskjellige? (Hint: Tenk på operativsystemets fil-caching, CPU-bruk for parsing i Java, etc.).

\---

### Oppgave 3: Unngå Redundans \- Normalisering (ca. 2.5 timer)

Med normalisering menes å splitte opp data i flere deler. Formålet er å gjøre søket i data (lesing) mer effektivt og gjøre oppdateringer (skriving) på en måte som eliminerer diverse anomalier, som redundans (samme data lagret mange steder i minne) osv. Vi kommer til å snakke mer om dette gjennom hele semesteret, så foreløpig kun en kort forklaring.

En måte å strukturere data om studenter, kurs (emner) og hvilke emner hver student er påmeldt i kan være: 
```
101, Mickey, CS, DATA1500, Intro to Databases  
102, Daffy, EE, DATA1500, Intro to Databases  
101, Mickey, CS, MATH2000, Calculus
```
Utfordringen er at data i dette eksemplet blir duplisert (redundans) og ytelsen for både lesing og skriving til lagrede data blir ikke optimal. 

1\.  Lag normaliserte datafiler: **studenter.csv**, **kurs.csv**, **paameldinger.csv**.  
      
**studenter.csv**
```
101,Mickey,CS  
102,Daffy,EE  
103,Donald,CS  
104,Minnie,PSY  
```
**kurs.csv** 
```
DATA1500,Intro to Databases  
PROG1001,Programming 1  
MATH2000,Calculus  
PHYS1500,Physics  
```
**paameldinger.csv** 
```
101,DATA1500  
101,PROG1001  
101,MATH2000  
102,DATA1500  
102,PHYS1500  
103,DATA1500  
103,PROG1001  
104,MATH2000  
105,PROG1001  
105,PHYS1500
```
      
2\.  Fullfør Java-programmet **HashJoin.java** som bruker HashMap for å slå sammen dataene og vise hvilke kurs studentene tar. Må bruke en HashMap objekt for studenter og en for kurs. Så kan man gå sekvensielt gjennom påmeldinger og bruke HashMap objektet for å finne studentnavn og kursnavn og skrive ut  følgende linje for hver påmelding:

*\<studentnavn\>* er påmeldt *\<kursnavn\>*

Filnavn (**studenter.csv**, **kurs.csv**, **paameldinger.csv**) skal leses inn som argumenter på kommandolinje:
```
java VisPaameldinger *\<arg1\>* *\<arg2\>* *\<arg3\>* 
```
hvor 
- *\<arg1\>* er studenter.csv  
- *\<arg2\>* er kurs.csv  
- *\<arg3\>* er paameldinger.csv

Output skal være på 10 linjer: 
```
Mickey er påmeldt Intro to Databases  
Mickey er påmeldt Programming 1  
Mickey er påmeldt Calculus  
Daffy er påmeldt Intro to Databases  
Daffy er påmeldt Physics  
Donald er påmeldt Intro to Databases  
Donald er påmeldt Programming 1  
Minnie er påmeldt Calculus  
Goofy er påmeldt Programming 1  
Goofy er påmeldt Physics
```
#### Refleksjonsspørsmål:

S1: Hvorfor er det mer effektivt å lese **studenter.csv** og **kurs.csv** inn i HashMap først, i stedet for å søke gjennom filene for hver eneste linje i **paameldinger.csv**?

S2: Lagringsplass og minnebruk:

La oss si vi har 1 million studenter, 1000 kurs, og hver student tar i gjennomsnitt 5 kurs (totalt 5 millioner påmeldinger).

**Scenario A (Ikke-normalisert):** Vi lagrer \`studentID, fornavn, etternavn, kursID, kursnavn\` på hver linje. Anta at studentinfo trenger 100 bytes og kursinfo trenger 50 bytes for lagring. Hva blir den totale filstørrelsen for de 5 millioner påmeldingene?

**Scenario B (Normalisert):** Vi har tre filer. Beregn den totale størrelsen for **studenter.csv** (1M rader), **kurs.csv** (1000 rader), og **paameldinger.csv** (5M rader, inneholder kun to ID-er, f.eks. 8 bytes totalt per rad).  
Sammenlign total lagringsplass i Scenario A og B. Hvor mye plass sparer vi på normalisering?

S3: I din Java-løsning lastet du data inn i RAM. Se på tabellen i sliden *“Lagringsmedier – fra rask til billig”*. Hva er den typiske kostnaden per TB for RAM sammenlignet med SSD og HDD? Hvorfor er det en viktig vurdering om en datastruktur (som din HashMap-indeks) passer i RAM eller ikke?

\---

### Oppgave 4: Snarveien til Data \- Indeksering (ca. 1.5 timer)

1\. Generer en fil **brukere.csv** med 1 million brukere ved hjelp av **DataGenerator** fra Oppgave 2\.

2\. Generer en indeksfil **brukere.idx** basert på **brukere.csv**. Skriv koden i filen **IndeksBygger.java**.

Filnavn skal leses inn fra kommandolinje:
```
java IndeksBygger *\<brukerfilen\>* *\<indeksfilen\>*
```
3\. Lag et indeksert søkeprogram **SokMedIndeks.java** som laster indeksen inn i en HashMap og måler kun oppslagstiden (ikke tiden det tar å overføre data fra disk til RAM, dvs. å fylle inn HashMap\-objektet). Søk etter tekststrengen *\<søkeuttrykk\>*, for eksempel bruker999999@epost.no

Filnavn skal leses inn fra kommandolinje:
```
java SokMedIndeks *\<brukerfilen\>* *\<indeksfilen\> \<søkeuttrykk\>*
```
Output må inneholde søkeuttrykket (f. eks. `bruker999999@epost.no`) for å passere test. 

4\. Sammenlign den lineære søketiden fra Oppgave 2 med den indekserte oppslagstiden.

**Eksempel ($ \- er prompt-tegn på kommandolinje):**

Oppgave 2  
```
$ java FinnBruker brukere\_1million.csv bruker999999@epost.no  
Fant epost: bruker4999999@epost.no  
Tid brukt: 521 ms.
```
Oppgave 4:
```
$ java SokMedIndeks bruker999999@epost.no  
Fant linje: 4999999,bruker999999@epost.no,Navn Navnesen 999999  
Søket med indeks tok 1002000 nanos (1 ms).
```
#### Refleksjonsspørsmål:

S1: Hva er den observerte tidsforskjellen mellom det lineære søket og det indekserte oppslaget? Hvorfor er forskjellen så enorm?

S2: Hvilken lagringstype (RAM, SSD, HDD) opererer HashMap\-oppslaget på, og hva er den tilhørende “Aksesstid” ifølge tabellen fra forelesningene i sliden *“Lagringsmedier – fra rask til billig”*?

Kostnaden ved en indeks:  
S3: Hvor stor ble din brukere.idx\-fil? Sammenlign størrelsen med brukere.csv.

S4: En indeks er ikke gratis, den tar opp ekstra lagringsplass. Hvis indeksen din var 200 MB, hva ville den kostet å lagre den på en HDD? Hva med en SSD? Bruk tallene fra forelesningen, slide *“Lagringsmedier – fra rask til billig”*. Er dette en akseptabel kostnad for den ytelsesgevinsten du får? (Hint: *“tid/plass trade-off”*)

\---

SLUTT.
