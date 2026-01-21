﻿# Local Testing Script for Øving 1 (PowerShell version for Windows)

$ErrorActionPreference = "Continue"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$TestDataDir = Join-Path $ScriptDir "testdata"

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Local Testing Script - Øving 1" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $TestDataDir)) {
    Write-Host "Error: testdata directory not found!" -ForegroundColor Red
    Write-Host "Please download the test data from the course repository."
    exit 1
}

$Passed = 0
$Failed = 0

function Run-Test {
    param(
        [string]$TestName,
        [scriptblock]$Command
    )

    Write-Host -NoNewline "Testing: $TestName... "

    try {
        $result = & $Command

        if ($result) {
            Write-Host "✅ PASSED" -ForegroundColor Green
            $script:Passed++
        } else {
            Write-Host "❌ FAILED" -ForegroundColor Red
            $script:Failed++
        }
    } catch {
        Write-Host "❌ FAILED" -ForegroundColor Red
        $script:Failed++
        return $false
    }
}

# ============================================================
# OPPGAVE 1: CSV Parsing
# ============================================================

Write-Host ""
Write-Host "--- Oppgave 1: CSV Parsing ---" -ForegroundColor Yellow

$Oppgave1Dir = Join-Path $ScriptDir "oppgave1"
if (Test-Path $Oppgave1Dir) {
    Push-Location $Oppgave1Dir

    Write-Host -NoNewline "Compiling LesStudenter.java... "
    javac LesStudenter.java
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅" -ForegroundColor Green

        # Correct CSV
        Run-Test "Correct CSV" {
            # Run Java and capture output line by line
            $outputLines = & java LesStudenter "$TestDataDir\data\studenter_korrekt.csv" | ForEach-Object { $_.Trim() }

            # Read expected output line by line
            $expectedLines = Get-Content "$TestDataDir\expected\oppgave1_korrekt_output.txt" | ForEach-Object { $_.Trim() }

            # Compare arrays line by line
            if ($outputLines.Count -ne $expectedLines.Count) {
                return $false
            }

            for ($i = 0; $i -lt $outputLines.Count; $i++) {
                if ($outputLines[$i] -ne $expectedLines[$i]) {
                    return $false
                }
            }

            return $true

        }

        # Empty CSV
        Run-Test "Empty CSV" {
            # Capture output line by line
            $outputLines = & java LesStudenter "$TestDataDir\data\studenter_tom.csv" | ForEach-Object { $_.Trim() }

            # Remove any empty lines
            $outputLines = $outputLines | Where-Object { $_ -ne "" }

            # Pass if no non-empty lines
            return ($outputLines.Count -eq 0)
        }

        # Malformed CSV
        Run-Test "Malformed CSV" {


            $outputLines = & java LesStudenter "$TestDataDir\data\studenter_feilformat.csv" | ForEach-Object { $_.Trim() }
            $expectedLines = Get-Content "$TestDataDir\expected\oppgave1_feilformat_output.txt" | ForEach-Object { $_.Trim() }
            if ($outputLines.Count -ne $expectedLines.Count) {
                return $false
            }

            for ($i = 0; $i -lt $outputLines.Count; $i++) {
                if ($outputLines[$i] -ne $expectedLines[$i]) {
                    return $false
                }
            }

            return $true

        }
    } else {
        Write-Host "❌ Compilation failed" -ForegroundColor Red
        $Failed += 3
    }

    Pop-Location
} else {
    Write-Host "⚠️  Oppgave 1 directory not found" -ForegroundColor Yellow
}

# ============================================================
# OPPGAVE 2: Linear Search
# ============================================================

Write-Host ""
Write-Host "--- Oppgave 2: Linear Search ---" -ForegroundColor Yellow

$Oppgave2Dir = Join-Path $ScriptDir "oppgave2"
if (Test-Path $Oppgave2Dir) {
    Push-Location $Oppgave2Dir

    # DataGenerator
    Write-Host -NoNewline "Compiling DataGenerator.java... "
    javac DataGenerator.java
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅" -ForegroundColor Green

        Run-Test "DataGenerator (1000 lines)" {
            java DataGenerator test.csv 1000 | Out-Null
            $lineCount = (Get-Content test.csv).Count
            Remove-Item test.csv -ErrorAction SilentlyContinue
            return ($lineCount -eq 1000)
        }
    } else {
        Write-Host "❌ Compilation failed" -ForegroundColor Red
        $Failed++
    }

    # FinnBruker
    Write-Host -NoNewline "Compiling FinnBruker.java... "
    javac FinnBruker.java
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅" -ForegroundColor Green

        Run-Test "Search for bruker5" {
            $output = & java FinnBruker "$TestDataDir\data\brukere_10k.csv" "bruker5@epost.no"
            return ($output -match "bruker5@epost.no")
        }

        Run-Test "Search for bruker9999" {
            $output = & java FinnBruker "$TestDataDir\data\brukere_10k.csv" "bruker9999@epost.no"
            return ($output -match "bruker9999@epost.no")
        }
    } else {
        Write-Host "❌ Compilation failed" -ForegroundColor Red
        $Failed += 2
    }

    Pop-Location
} else {
    Write-Host "⚠️  Oppgave 2 directory not found" -ForegroundColor Yellow
}

# ============================================================
# OPPGAVE 3: Hash Join
# ============================================================

Write-Host ""
Write-Host "--- Oppgave 3: Hash Join ---" -ForegroundColor Yellow

$Oppgave3Dir = Join-Path $ScriptDir "oppgave3"
if (Test-Path $Oppgave3Dir) {
    Push-Location $Oppgave3Dir

    Write-Host -NoNewline "Compiling HashJoin.java... "
    javac HashJoin.java
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅" -ForegroundColor Green

        Run-Test "Hash Join" {
            $output = & java HashJoin "$TestDataDir\data\studenter.csv" "$TestDataDir\data\kurs.csv" "$TestDataDir\data\paameldinger.csv"
            $outputSorted = ($output -split "`r?`n" | Sort-Object) -join "`n"
            $expected = Get-Content "$TestDataDir\expected\oppgave3_output.txt"
            $expectedSorted = ($expected | Sort-Object) -join "`n"
            return ($outputSorted -eq $expectedSorted)
        }
    } else {
        Write-Host "❌ Compilation failed" -ForegroundColor Red
        $Failed++
    }

    Pop-Location
} else {
    Write-Host "⚠️  Oppgave 3 directory not found" -ForegroundColor Yellow
}

# ============================================================
# OPPGAVE 4: Indexing
# ============================================================

Write-Host ""
Write-Host "--- Oppgave 4: Indexing ---" -ForegroundColor Yellow

$Oppgave4Dir = Join-Path $ScriptDir "oppgave4"
if (Test-Path $Oppgave4Dir) {
    Push-Location $Oppgave4Dir

    Write-Host -NoNewline "Compiling IndeksBygger.java... "
    javac IndeksBygger.java
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅" -ForegroundColor Green

        Run-Test "Build index" {
            java IndeksBygger "$TestDataDir\data\brukere_10k.csv" brukere.idx | Out-Null
            return (Test-Path brukere.idx)
        }
    } else {
        Write-Host "❌ Compilation failed" -ForegroundColor Red
        $Failed++
    }

    Write-Host -NoNewline "Compiling SokMedIndeks.java... "
    javac SokMedIndeks.java
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅" -ForegroundColor Green

        Run-Test "Indexed search" {
            $output = & java SokMedIndeks "$TestDataDir\data\brukere_10k.csv" brukere.idx "bruker9999@epost.no"
            return ($output -match "bruker9999@epost.no")
        }
    } else {
        Write-Host "❌ Compilation failed" -ForegroundColor Red
        $Failed++
    }

    Remove-Item brukere.idx -ErrorAction SilentlyContinue
    Pop-Location
} else {
    Write-Host "⚠️  Oppgave 4 directory not found" -ForegroundColor Yellow
}

# ============================================================
# Summary
# ============================================================

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Test Summary" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Passed: $Passed" -ForegroundColor Green
Write-Host "Failed: $Failed" -ForegroundColor Red
Write-Host ""

if ($Failed -eq 0) {
    Write-Host "🎉 All tests passed! Your code is ready to submit." -ForegroundColor Green
    exit 0
} else {
    Write-Host "⚠️  Some tests failed. Please review your code." -ForegroundColor Red
    exit 1
}


