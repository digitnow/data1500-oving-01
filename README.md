# Øving 1
- **Oppgave 1:** Data som Tekst (ca. 1.5 timer)
  - Fokus: Representasjon, parsing, grunnleggende fil-I/O.
  - Beregne teoretisk lagringsstørrelse.

- **Oppgave 2:** Jakten på Data - Ytelse i Små og Store Filer (ca. 2.5 timer)
  - Fokus: Lineær skanning, ytelsesfall, bufring.
  - Beregne filstørrelse og teoretisk lesetid fra disk.

- **Oppgave 3:** Normalisering og "Joins" på Filer (ca. 2.5 timer)
  - Fokus: Dataredundans, `HashMap` for "joins" i minnet.
  - Analysere lagringsbesparelse og vurdere minnebruk (RAM).

- **Oppgave 4:** Kraften av Indeksering (ca. 1.5 timer + Bonus)
  - Fokus: Ytelsesgevinst ved indeksering.
  - Kvantifisere kostnaden (i lagring) av en indeks og koble ytelsesgevinsten til I/O-kostnadsmodellen.

### Oppgave 1: Min Første "Database" - Data som Tekst (ca. 1.5 timer)

1.  **Opprett datafilen:** `studenter.csv`
    ```csv
    101,Mickey,CS
    102,Daffy,EE
    103,Donald,CS
    104,Minnie,PSY
    ```
2.  **Lag en `Student`-klasse i Java.**
3.  **Skriv et Java-program (`LesStudenter.java`).**

**Refleksjonsspørsmål:**
*   Hva er fordelene med å lagre data i et slikt format?
*   Hva skjer hvis et av feltene, for eksempel et navn, inneholder et komma? Hvilke problemer skaper det for din parsing-logikk?
*   **Beregning av lagringsbehov:**
    *   Forelesningen viser et eksempel der en studentrad er 1024 bytes. La oss lage en forenklet modell for *vår* fil. Anta at hvert tegn (character) er 1 byte (dette er en forenkling, se UTF-8).
    *   Regn ut den omtrentlige størrelsen i bytes for én linje i din `studenter.csv`-fil (f.eks., for `101,Mickey,CS`). Ikke glem å telle med kommaene og et tegn for linjeskift.
    *   Basert på denne beregningen, hva ville den teoretiske filstørrelsen vært for **1 million** studenter? Hvor stor for **1 milliard** studenter? Uttrykk svarene i MB, GB eller TB. Sammenlign med eksempelet i forelesningen.

---

### Oppgave 2: Ytelsessjokket - Lineær Skanning (ca. 2.5 timer)

**(Oppgavebeskrivelse er uendret...)**

1.  **Lag en datagenerator (`DataGenerator.java`)** som lager `brukere.csv` med 5 millioner linjer (`userID,epost`).
2.  **Lag et søkeprogram (`FinnBruker.java`)** som måler tiden det tar å finne en bruker.
3.  **Utfør eksperimentet:** Test med liten fil, tidlig treff i stor fil, og sent treff i stor fil.

**Refleksjonsspørsmål:**
*   Sammenlign tidene fra de tre testene. Hva forteller dette deg om ytelsen til en lineær skanning?
*   Hvorfor var `BufferedWriter` så viktig i datageneratoren? Hvilket konsept fra forelesningen (IO Blocks, bufring) demonstrerer dette?
*   **Teoretisk lesetid:**
    *   Sjekk den faktiske filstørrelsen på din genererte `brukere.csv` (5 millioner rader). La oss si den er ca. 150 MB.
    *   Bruk tabellen "Basic system numbers" fra forelesningen. Hva ville den teoretiske tiden vært for å lese hele denne filen (en full "scan") fra henholdsvis en **HDD (Hard Disk)** og en **High-end SSD**?
    *   Formelen er `Total Time = AccessLatency * M + DataSize/ScanThroughput`. For en full, sekvensiell skanning kan vi anta at `M=1` (dataene leses som én stor, sammenhengende blokk).
    *   Sammenlign de teoretiske tidene med den faktiske tiden du målte i "Test 3 (Stor fil, sent treff)". Hvorfor kan tidene være forskjellige? (Hint: Tenk på operativsystemets fil-caching, CPU-bruk for parsing i Java, etc.).

---

### Oppgave 3: Unngå Redundans - Normalisering (ca. 2.5 timer)

**(Oppgavebeskrivelse er uendret...)**

1.  **Lag normaliserte datafiler:** `studenter.csv`, `kurs.csv`, `paameldinger.csv`.
2.  **Skriv et Java-program (`VisPaameldinger.java`)** som bruker `HashMap` for å slå sammen dataene og vise hvilke kurs studentene tar.

**Refleksjonsspørsmål:**
*   Hvorfor er det mer effektivt å lese `studenter.csv` og `kurs.csv` inn i HashMaps først, i stedet for å søke gjennom filene for hver eneste linje i `paameldinger.csv`?
*   **Lagringsplass og minnebruk:**
    *   La oss si vi har 1 million studenter, 1000 kurs, og hver student tar i gjennomsnitt 5 kurs (totalt 5 millioner påmeldinger).
    *   **Scenario A (Ikke-normalisert):** Vi lagrer `studentID, fornavn, etternavn, kursID, kursnavn` på hver linje. Anta at studentinfo er 100 bytes og kursinfo er 50 bytes. Hva blir den totale filstørrelsen for de 5 millioner påmeldingene?
    *   **Scenario B (Normalisert):** Vi har tre filer. Beregn den totale størrelsen for `studenter.csv` (1M rader), `kurs.csv` (1000 rader), og `paameldinger.csv` (5M rader, inneholder kun to ID-er, f.eks. 8 bytes totalt per rad).
    *   Sammenlign total lagringsplass i Scenario A og B. Hvor mye plass sparer vi på normalisering?
    *   I din Java-løsning lastet du data inn i RAM. Se på tabellen "Basic system numbers". Hva er den typiske kostnaden per TB for RAM sammenlignet med SSD og HDD? Hvorfor er det en viktig vurdering om en datastruktur (som din HashMap-indeks) passer i RAM eller ikke?

---

### Oppgave 4: Snarveien til Data - Indeksering (ca. 1.5 timer)

**(Oppgavebeskrivelse er uendret...)**

1.  **Utvid datageneratoren** til å lage en indeksfil `epost_idx.csv`.
2.  **Lag et indeksert søkeprogram (`FinnBrukerIndeksert.java`)** som laster indeksen inn i en `HashMap` og måler kun oppslagstiden.
3.  **Sammenlign** den lineære søketiden fra Oppgave 2 med den indekserte oppslagstiden.

**Refleksjonsspørsmål:**
*   Hva er den observerte tidsforskjellen mellom det lineære søket og det indekserte oppslaget? Hvorfor er forskjellen så enorm?
*   ** I/O-kostnadsmodellen i praksis:**
    *   Se på eksempelet "Find ‘Daffy’ from a DB of billion students" i forelesningen, spesielt "Design 2" (Data in HDD; rows in random spots) vs "Design 3" (Data in 64MB-Blocks in HDD).
    *   Et lineært søk (som i Oppgave 2) ligner på "Design 3": `Total Time = AccessLatency * M + ScanThroughput`. Her er `M` relativt lite fordi OS leser filen i store, sekvensielle blokker.
    *   Et søk uten indeks der du må hente hver rad individuelt fra disk, ville lignet "Design 2", der `M` er lik antall rader. Dette er ekstremt tregt.
    *   Hvordan passer vårt indekserte søk (med `HashMap` i minnet) inn i denne modellen? Hvilken lagringstype (RAM, SSD, HDD) opererer `HashMap`-oppslaget på, og hva er den tilhørende `AccessLatency` ifølge tabellen? Dette forklarer hvorfor det er så raskt.
*   **[Systems Primer] Kostnaden ved en indeks:**
    *   Hvor stor ble din `epost_idx.csv`-fil? Sammenlign størrelsen med `brukere.csv`.
    *   En indeks er ikke gratis; den tar opp ekstra lagringsplass. Bruk kostnadstallene fra forelesningen (`Cost/TB` for SSD/HDD). Hvis indeksen din var 100 MB, hva ville den kostet å lagre på en HDD? Hva med en SSD? Er dette en akseptabel kostnad for den ytelsesgevinsten du får?

---

### Bonusoppgave for de ivrige: Implementering i Rust (Valgfritt)
#### Mål:

    Løse et av de samme problemene i et systemspråk som gir mer kontroll over minne og ytelse.
    Se hvordan konsepter som feilhåndtering og ressursstyring (f.eks. lukking av filer) håndteres annerledes.

#### Oppgave:
Implementer Oppgave 2 (Ytelsessjokket) i Rust.
  - data_generator/: Lag et nytt Rust-prosjekt for å generere brukere.csv-filen med 5 millioner linjer. Bruk std::fs::File og std::io::BufWriter.
  - searcher/: Lag et nytt Rust-prosjekt som utfører det lineære søket.
    - Bruk std::fs::File og std::io::BufReader for å lese filen linje for linje.
    - Bruk std::time::Instant for å måle tiden.
    - Søk etter bruker4999999@example.com og skriv ut resultatet og tiden det tok.

#### Tips for studenten:
  - Rusts feilhåndtering med Result og ?-operatoren er annerledes enn Javas try-catch.
  - Rusts "ownership"-modell garanterer at filer lukkes automatisk når de går ut av scope, likt Javas try-with-resources, men håndhevet av kompilatoren.
  - Du kan installere Rust fra rust-lang.org.

#### Refleksjonsspørsmål for bonusoppgaven:
- Hvilke likheter og forskjeller la du merke til mellom Java- og Rust-koden for filhåndtering?
- Føltes Rusts tilnærming til feilhåndtering tryggere eller mer omstendelig?

SLUTT. 
