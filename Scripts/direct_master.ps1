#vibe-coded garbage :)

param(
    [Parameter(Position = 0)]
    [string]$program_file_name = '',
    [switch]$help
)

$ErrorActionPreference = "Stop"

if($help){
    Write-Output("
    Usage: GITHOME/Modules >> ../Scripts/direct_master.ps1 myProgram.s -optional_flags

    myProgram.s must be a program in the Programs/directed/ directory. The script will run validation using that program
    if you do not give it a myProgram.s when calling the script, it will run vaidation on all of the programs in the
    Programs/directed/ directory. Regardless a _master.log summary file is created. The individual results, and the 
    _master.log will be moved into the Logs/raw_directed/ directory, and will get cleared whenver this script run

    -help:  Brings up this dialog
    ")

    exit(0)
}

# Get the current directory name
$currentDirName = Split-Path -Leaf (Get-Location)

if ($currentDirName -ne "Modules") {
    Write-Host "`nError: Script must be run from the Modules folder. Current folder is $currentDirName`n"
    exit 1
}

if (-not (Test-Path "../Programs/directed/passing/$program_file_name")) {
    Write-Host "`nError: File <$program_file_name> does not exist in ../Programs/directed/passing/`n"
    exit(1)
}

$logFolder = "..\Logs\raw_directed"
$masterLogName = "_master.log"
$masterLog = Join-Path $logFolder $masterLogName

# Create the folder if it doesn't exist
if (-not (Test-Path $logFolder)) {
    New-Item -ItemType Directory -Path $logFolder | Out-Null
} else {
    #Remove all files in the folder
    Get-ChildItem $logFolder -File | Remove-Item -Force
}

Write-Host "Running from Modules folder, continuing..."

if($program_file_name -eq ''){
    foreach($file in Get-ChildItem -Path ..\Programs\directed\passing\ -Filter *.s -File) {

        $wslPath = "../Programs/directed/passing/$($file.name)"
        Write-Host $wslPath
        Write-Host "Testing $wslPath..."

        Write-Host "Assembling in WSL..."
        wsl bash -c "riscv64-unknown-elf-as -march=rv32im $wslPath -o program_asm.o && riscv64-unknown-elf-objdump -d program_asm.o | tee program.log"
        if ($LASTEXITCODE -ne 0) { exit 1 }

        Write-Host "Writing instruction memory file..."
        python3 .\load_instr_mem_file.py
        if ($LASTEXITCODE -ne 0) { exit 1 }

        Write-Host "Running simulation..."
        & ..\Scripts\simulate_sv.ps1 -continue -time 15 #most likely long enuf, will give error if not
        if ($LASTEXITCODE -ne 0) { exit 1 }

        Write-Host "Moving results..."
        Copy-Item $wslPath -Destination (Join-Path $logFolder $file.name) -Force
        Copy-Item ".\sim.log" -Destination (Join-Path $logFolder "$($file.BaseName).log") -Force

        Write-Host "Finished testing all programs.."
    }
}else{

    $file = Get-Item "..\Programs\directed\passing\$program_file_name"

    $wslPath = "../Programs/directed/passing/$($file.name)"
    Write-Host $wslPath
    Write-Host "Testing $wslPath..."

    Write-Host "Assembling in WSL..."
    wsl bash -c "riscv64-unknown-elf-as -march=rv32im $wslPath -o program_asm.o && riscv64-unknown-elf-objdump -d program_asm.o | tee program.log"
    if ($LASTEXITCODE -ne 0) { exit 1 }

    Write-Host "Writing instruction memory file..."
    python3 .\load_instr_mem_file.py
    if ($LASTEXITCODE -ne 0) { exit 1 }

    Write-Host "Running simulation..."
    & ..\Scripts\simulate_sv.ps1 -continue -time 15 #most likely long enuf, will give error if not
    if ($LASTEXITCODE -ne 0) { exit 1 }

    Write-Host "Moving results..."
    Copy-Item $wslPath -Destination (Join-Path $logFolder $file.name) -Force
    Copy-Item ".\sim.log" -Destination (Join-Path $logFolder "$($file.BaseName).log") -Force

    Write-Host "Finished testing all programs.."

}

# Clear master log if it exists
if (Test-Path $masterLog) {
    Remove-Item $masterLog

}Add-Content -Path $masterLog "Begining of Master Log..."

# Initialize global trackers for the final verdict
$globalAnyErrors = $false
$globalAnyWarnings = $false

$logFiles = Get-ChildItem -Path $logFolder -Filter "*.log" -File |
            Where-Object { $_.Name -ne $masterLogName } |
            Sort-Object Name

foreach ($tempFile in $logFiles) {

    $content = Get-Content $tempFile.FullName
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
            Add-Content -Path $masterLog "$($tempFile.Name): FAIL (Errors: $fileErrors, Warnings: $fileWarnings)"
        }else{
            if($fileWarnings -gt 0){
                Add-Content -Path $masterLog "$($tempFile.Name): PASS (Errors: $fileErrors, Warnings: $fileWarnings)"
            }else{
                Add-Content -Path $masterLog "$($tempFile.Name): CLEAN PASS (Errors: $fileErrors, Warnings: $fileWarnings)"
            }
        }
        if ($fileWarnings -gt 0) { $globalAnyWarnings = $true }

    } else {
        $globalAnyErrors = $true
        Add-Content -Path $masterLog "$($tempFile.Name): No error/warning summary found, NOT A PASS"
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


