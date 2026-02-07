$ErrorActionPreference = "Stop"

for($ii = 0; $ii -lt 2; $ii++){

    Write-Host "Generating random assembly..."
    python3 ..\Scripts\gen_random_prog.py
    if ($LASTEXITCODE -ne 0) { exit 1 }

    Write-Host "Assembling in WSL..."
    wsl bash -c "riscv64-unknown-elf-as -march=rv32im temp.s -o program_asm.o && riscv64-unknown-elf-objdump -d program_asm.o | tee program.log"
    if ($LASTEXITCODE -ne 0) { exit 1 }

    Write-Host "Writing instruction memory file..."
    python3 .\load_instr_mem_file.py
    if ($LASTEXITCODE -ne 0) { exit 1 }

    Write-Host "Running simulation..."
    & ..\Scripts\simulate_sv.ps1
    if ($LASTEXITCODE -ne 0) { exit 1 }

    Write-Host "Flow complete."

    # Copy temp.s and program.log to log folder with iteration number
    $tempSName = "temp_$ii.s"
    $simLogName = "sim_$ii.log"

    Copy-Item ".\temp.s" -Destination (Join-Path "..\Logs\" $tempSName) -Force
    Copy-Item ".\sim.log" -Destination (Join-Path "..\Logs\" $simLogName) -Force

    Write-Host "Saved logs for iteration $ii"

}

$logFolder = "..\Logs"
$masterLog = Join-Path $logFolder "master.log"

# Make sure log folder exists
if (-not (Test-Path $logFolder)) { New-Item -ItemType Directory -Path $logFolder | Out-Null }

# Clear master log if it exists
if (Test-Path $masterLog) { Remove-Item $masterLog }

# Loop over all .log files
Get-ChildItem "$logFolder\*.log" | ForEach-Object {
    $file = $_.FullName
    $fileName = $_.Name
    $found = $false

    # Read lines and look for "Errors: X, Warnings: Y"
    Get-Content $file | ForEach-Object {
        if ($_ -match "Errors:\s*(\d+),\s*Warnings:\s*(\d+)") {
            $errors = [int]$matches[1]
            $warnings = [int]$matches[2]

            if ($errors -ne 0 -or $warnings -ne 0) {
                $line = "[$fileName] Errors: $errors, Warnings: $warnings"
                Add-Content -Path $masterLog -Value $line
            }
            $found = $true
        }
    }

    # Optional: If no Errors/Warnings line found, you can note it
    if (-not $found) {
        Add-Content -Path $masterLog -Value "$fileName : No error/warning summary found."
    }
}

Write-Host "Master log written to $masterLog"



