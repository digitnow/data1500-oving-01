# Test Data for Øving 1

This directory contains all the necessary data and expected output files for the automated evaluation of Øving 1.

## Directory Structure

- `data/`: Contains the raw input files for the test cases.
- `expected/`: Contains the "fasit" output files that the students' programs should generate.

## File Descriptions

### `data/`

- **studenter_korrekt.csv**: Standard input for Task 1.
- **studenter_tom.csv**: Edge case for Task 1 (empty file).
- **studenter_feilformat.csv**: Edge case for Task 1 (malformed line).
- **brukere_100.csv**: Small dataset for testing Task 2 & 4 functionality.
- **brukere_10k.csv**: Medium dataset for testing Task 2 & 4 performance.
- **studenter.csv**: Normalized student table for Task 3.
- **kurs.csv**: Normalized course table for Task 3.
- **paameldinger.csv**: Enrollment linking table for Task 3.

### `expected/`

- **oppgave1_korrekt_output.txt**: Expected output for `studenter_korrekt.csv`.
- **oppgave1_feilformat_output.txt**: Expected output for `studenter_feilformat.csv` (should skip the bad line).
- **oppgave2_bruker5_output.txt**: Expected output when searching for `bruker5`.
- **oppgave2_bruker9999_output.txt**: Expected output when searching for `bruker9999`.
- **oppgave3_output.txt**: Expected output for the hash join in Task 3.

These files can be used in a CI/CD pipeline (like GitHub Actions) to automatically `diff` the student's output against the expected output.
