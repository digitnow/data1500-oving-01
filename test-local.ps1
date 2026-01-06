# Local Testing Script for Øving 1 (PowerShell version for Windows)
# This script allows students to test their solutions locally before pushing to GitHub

$ErrorActionPreference = "Continue"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$TestDataDir = Join-Path $ScriptDir "testdata"

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Local Testing Script - Øving 1" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Check if testdata exists
if (-not (Test-Path $TestDataDir)) {
    Write-Host "Error: testdata directory not found!" -ForegroundColor Red
    Write-Host "Please download the test data from the course repository."
    exit 1
}

$Passed = 0
$Failed = 0

# Function to run a test
function Run-Test {
    param(
        [string]$TestName,
        [scriptblock]$Command
    )
    
    Write-Host -NoNewline "Testing: $TestName... "
    
    try {
        $result = & $Command 2>&1
        if ($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq $null) {
            Write-Host "✅ PASSED" -ForegroundColor Green
            $script:Passed++
            return $true
        } else {
            Write-Host "❌ FAILED" -ForegroundColor Red
            $script:Failed++
            return $false
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
    
    # Compile
    Write-Host -NoNewline "Compiling LesStudenter.java... "
    $compileResult = javac LesStudenter.java 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅" -ForegroundColor Green
        
        # Test with correct CSV
        Run-Test "Correct CSV" {
            $output = java LesStudenter "$TestDataDir\data\studenter_korrekt.csv" 2>&1
            $expected = Get-Content "$TestDataDir\expected\oppgave1_korrekt_output.txt" -Raw
            if ($output -replace "`r`n", "`n" -eq $expected -replace "`r`n", "`n") {
                exit 0
            } else {
                exit 1
            }
        }
        
        # Test with empty CSV
        Run-Test "Empty CSV" {
            java LesStudenter "$TestDataDir\data\studenter_tom.csv" 2>&1 | Out-Null
            exit $LASTEXITCODE
        }
        
        # Test with malformed CSV
        Run-Test "Malformed CSV" {
            $output = java LesStudenter "$TestDataDir\data\studenter_feilformat.csv" 2>&1
            $expected = Get-Content "$TestDataDir\expected\oppgave1_feilformat_output.txt" -Raw
            if ($output -replace "`r`n", "`n" -eq $expected -replace "`r`n", "`n") {
                exit 0
            } else {
                exit 1
            }
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
    
    # Compile DataGenerator
    Write-Host -NoNewline "Compiling DataGenerator.java... "
    $compileResult = javac DataGenerator.java 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅" -ForegroundColor Green
        
        # Test generator
        Run-Test "DataGenerator (1000 lines)" {
            java DataGenerator test.csv 1000 2>&1 | Out-Null
            $lineCount = (Get-Content test.csv).Count
            Remove-Item test.csv -ErrorAction SilentlyContinue
            if ($lineCount -eq 1000) {
                exit 0
            } else {
                exit 1
            }
        }
    } else {
        Write-Host "❌ Compilation failed" -ForegroundColor Red
        $Failed++
    }
    
    # Compile FinnBruker
    Write-Host -NoNewline "Compiling FinnBruker.java... "
    $compileResult = javac FinnBruker.java 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅" -ForegroundColor Green
        
        # Test search
        Run-Test "Search for bruker5" {
            $output = java FinnBruker "$TestDataDir\data\brukere_10k.csv" "bruker5@epost.no" 2>&1
            if ($output -match "bruker5@epost.no") {
                exit 0
            } else {
                exit 1
            }
        }
        
        Run-Test "Search for bruker9999" {
            $output = java FinnBruker "$TestDataDir\data\brukere_10k.csv" "bruker9999@epost.no" 2>&1
            if ($output -match "bruker9999@epost.no") {
                exit 0
            } else {
                exit 1
            }
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
    
    # Compile
    Write-Host -NoNewline "Compiling HashJoin.java... "
    $compileResult = javac HashJoin.java 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅" -ForegroundColor Green
        
        # Test join
        Run-Test "Hash Join" {
            $output = java HashJoin "$TestDataDir\data\studenter.csv" "$TestDataDir\data\kurs.csv" "$TestDataDir\data\paameldinger.csv" 2>&1
            $outputSorted = ($output -split "`r?`n" | Sort-Object) -join "`n"
            $expected = Get-Content "$TestDataDir\expected\oppgave3_output.txt"
            $expectedSorted = ($expected | Sort-Object) -join "`n"
            
            if ($outputSorted -eq $expectedSorted) {
                exit 0
            } else {
                exit 1
            }
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
    
    # Compile IndeksBygger
    Write-Host -NoNewline "Compiling IndeksBygger.java... "
    $compileResult = javac IndeksBygger.java 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅" -ForegroundColor Green
        
        # Build index
        Run-Test "Build index" {
            java IndeksBygger "$TestDataDir\data\brukere_10k.csv" brukere.idx 2>&1 | Out-Null
            if (Test-Path brukere.idx) {
                exit 0
            } else {
                exit 1
            }
        }
    } else {
        Write-Host "❌ Compilation failed" -ForegroundColor Red
        $Failed++
    }
    
    # Compile SokMedIndeks
    Write-Host -NoNewline "Compiling SokMedIndeks.java... "
    $compileResult = javac SokMedIndeks.java 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅" -ForegroundColor Green
        
        # Test indexed search
        Run-Test "Indexed search" {
            $output = java SokMedIndeks "$TestDataDir\data\brukere_10k.csv" brukere.idx "bruker9999@epost.no" 2>&1
            if ($output -match "bruker9999@epost.no") {
                exit 0
            } else {
                exit 1
            }
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
