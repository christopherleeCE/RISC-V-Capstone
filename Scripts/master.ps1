#vibe-coded garbage :)

param(
    [int]$runs = 1
)

$ErrorActionPreference = "Stop"

# Get the current directory name
$currentDirName = Split-Path -Leaf (Get-Location)

if ($currentDirName -ne "Modules") {
    Write-Host "Error: Script must be run from the Modules folder. Current folder is $currentDirName"
    exit 1
}

$logFolder = "..\Logs\raw"
$masterLog = Join-Path $logFolder "master.log"

# Create the folder if it doesn't exist
if (-not (Test-Path $logFolder)) {
    New-Item -ItemType Directory -Path $logFolder | Out-Null
} else {
    # Remove all files in the folder
    Get-ChildItem $logFolder -File | Remove-Item -Force
}

Write-Host "Running from Modules folder, continuing..."

for($ii = 0; $ii -lt $runs; $ii++){

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
    & ..\Scripts\simulate_sv.ps1 -continue
    if ($LASTEXITCODE -ne 0) { exit 1 }

    Write-Host "Flow complete."

    # Copy temp.s and program.log to log folder with iteration number
    $tempSName = "temp_$ii.s"
    $simLogName = "sim_$ii.log"

    Copy-Item ".\temp.s" -Destination (Join-Path $logFolder $tempSName) -Force
    Copy-Item ".\sim.log" -Destination (Join-Path $logFolder $simLogName) -Force

    Write-Host "Saved logs for iteration $ii"

}

# Clear master log if it exists
if (Test-Path $masterLog) {
    Remove-Item $masterLog

}Add-Content -Path $masterLog "Begining of Master Log..."

# Initialize global trackers for the final verdict
$globalAnyErrors = $false
$globalAnyWarnings = $false

# Scan every sim_*.log file
$logFiles = Get-ChildItem -Path $logFolder -Filter "sim_*.log" | Sort-Object Name

foreach ($file in $logFiles) {
    $content = Get-Content $file.FullName
    $summaryLines = $content | Where-Object { $_ -match "Errors:\s*(?<err>\d+),\s*Warnings:\s*(?<warn>\d+)" }

    if ($summaryLines) {
        $fileErrors = 0
        $fileWarnings = 0

        foreach ($line in $summaryLines) {
            if ($line -match "Errors:\s*(?<err>\d+),\s*Warnings:\s*(?<warn>\d+)") {
                $fileErrors += [int]$Matches['err']
                $fileWarnings += [int]$Matches['warn']
            }
        }

        # Update global flags if any issues are found in this file
        if ($fileErrors -gt 0) {
            $globalAnyErrors = $true
            Add-Content -Path $masterLog "$($file.Name): FAIL (Errors: $fileErrors, Warnings: $fileWarnings)"
        }else{
            if($fileWarnings -gt 0){
                Add-Content -Path $masterLog "$($file.Name): PASS (Errors: $fileErrors, Warnings: $fileWarnings)"
            }else{
                Add-Content -Path $masterLog "$($file.Name): CLEAN PASS (Errors: $fileErrors, Warnings: $fileWarnings)"
            }
        }
        if ($fileWarnings -gt 0) { $globalAnyWarnings = $true }


        # Write the individual file line to the master log
        #Add-Content -Path $masterLog "$($file.Name): PASS (Errors: $fileErrors, Warnings: $fileWarnings)"
    } else {
        $globalAnyErrors = $true
        Add-Content -Path $masterLog "$($file.Name): No error/warning summary found, NOT A PASS"
    }
}

# Final Verdict Logic at the end of the file
Add-Content -Path $masterLog "" # Add a blank line for readability

if ($globalAnyErrors) {
    Add-Content -Path $masterLog "FAIL: Errors detected in one or more logs"
} elseif ($globalAnyWarnings) {
    Add-Content -Path $masterLog "PASS: Warnings present"
} else {
    Add-Content -Path $masterLog "CLEAN PASS: No warnings or errors"
}

Write-Host "Master log updated at $masterLog"


