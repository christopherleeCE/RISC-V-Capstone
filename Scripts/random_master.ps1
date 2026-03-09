#vibe-coded garbage :)

param(
    [int]$runs = 1,
    [switch]$help,
    [switch]$only_gen_master_log,

    [switch]$golden_calc,
    [switch]$dut_dump,
    [switch]$golden_history,
    [switch]$verify_output,
    [switch]$no_verify,
    [switch]$v,
    [switch]$wave_dump
)

$startTime = Get-Date
$timer = [System.Diagnostics.Stopwatch]::StartNew()

$ErrorActionPreference = "Stop"
$runTime = 5000

if($help){
    Write-Output("
    -help: brings up this dialog
    -runs NUM:  sets the randomized testing to run NUM tests
    -only_gen_master_log: doesnt run any verification only generates a masterlog with the current contents of raw_random dirctory

    simulate.ps1 flags:
    -golden_calc:       shows the debug info for the golden values calculated on every posedge
    -dut_dump:          shows a dump of all dut on every negedge
    -golden_history:    shows dump of golden_history[] on every negedge
    -verify_output:     shows debug info of verify_row()'s
    -no_verify:         disable verification, script will verify if this argument is NOT given
    -v:                 enables -golden_calc -dut_dump -golden_history -verify_output -continue
    -wave_dump:         include if you need a wave dump, slows down simulation 

    For refrence my home computer (kinda beefy but not really) takes 7 minutes for 100 runs, 1000 took about 75
    This Script will generate a random .s file, simulate and validate it, and store the results
    in the <GITHOME/Logs/raw_random/> directory, along with a _master.log file that sumaraizes the
    results of all the iterations of the test
        ")

    exit(0)
}

$simScriptArgs = @{
    continue = $true;
    no_compile = $false
}

if ($golden_calc)       { $simScriptArgs.golden_calc = $true }
if ($dut_dump)          { $simScriptArgs.dut_dump = $true }
if ($golden_history)    { $simScriptArgs.golden_history = $true }
if ($verify_output)     { $simScriptArgs.verify_output = $true }
if ($no_verify)         { $simScriptArgs.no_verify = $true }
if ($v)                 { $simScriptArgs.v = $true }
if ($wave_dump)         { $simScriptArgs.wave_dump = $true }

# Get the current directory name
$currentDirName = Split-Path -Leaf (Get-Location)

if ($currentDirName -ne "Modules") {
    Write-Host "Error: Script must be run from the Modules folder. Current folder is $currentDirName" -ForegroundColor Red
    exit 1
}

$logFolder = "..\Logs\raw_random"
$masterLog = Join-Path $logFolder "_master.log"

# Create the folder if it doesn't exist
if (-not (Test-Path $logFolder)) {
    New-Item -ItemType Directory -Path $logFolder | Out-Null
} else {
    if(-not $only_gen_master_log){
    # Remove all files in the folder
    Get-ChildItem $logFolder -File | Remove-Item -Force
    }
}

Write-Host "Running from Modules folder, continuing..."
if(-not $only_gen_master_log){
    for($ii = 1; $ii -le $runs; $ii++){

        Write-Host "Generating random assembly..."
        python3 ..\Scripts\gen_random_prog.py
        if ($LASTEXITCODE -ne 0) { exit 1 }

        # Write-Host "Assembling in WSL..."
        # wsl bash -c "riscv64-unknown-elf-as -march=rv32im temp.s -o program_asm.o && riscv64-unknown-elf-objdump -d program_asm.o | tee program.log"
        # if ($LASTEXITCODE -ne 0) { exit 1 }

        # Write-Host "Writing instruction memory file..."
        # python3 .\load_instr_mem_file.py
        # if ($LASTEXITCODE -ne 0) { exit 1 }

        Write-Host "Assembling in WSL & Loading instruction_mem.txt and data_memory.txt..."
        wsl bash -c "dos2unix ../Scripts/my_gcc.sh"
        if ($LASTEXITCODE -ne 0) { exit 1 }
        wsl bash -c "../Scripts/my_gcc.sh temp.s -gas"
        if ($LASTEXITCODE -ne 0) { exit 1 }
        python3 .\hex2mif.py .\instruction_memory.hex instr.mif
        if ($LASTEXITCODE -ne 0) { exit 1 }
        python3 .\hex2mif.py .\data_memory.hex data.mif
        if ($LASTEXITCODE -ne 0) { exit 1 }
        Write-Host "Running simulation $($ii)/$runs..." -ForegroundColor Magenta

        & ..\Scripts\simulate_sv.ps1 @simScriptArgs -time $runTime
        if ($LASTEXITCODE -ne 0) { exit 1 }
        $simScriptArgs.no_compile = $true

        Write-Host "Flow complete."

        # Copy temp.s and program.log to log folder with iteration number
        $tempSName = "temp_$ii.s"
        $simLogName = "sim_$ii.log"

        Copy-Item ".\temp.s" -Destination (Join-Path $logFolder $tempSName) -Force
        Copy-Item ".\sim.log" -Destination (Join-Path $logFolder $simLogName) -Force

        Write-Host "Saved logs for iteration $ii"

    }
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
            Add-Content -Path $masterLog "FAIL (Errors: $fileErrors, Warnings: $fileWarnings): $($file.Name)"
        }else{
            if($fileWarnings -gt 0){
                Add-Content -Path $masterLog "PASS (Errors: $fileErrors, Warnings: $fileWarnings): $($file.Name)"
            }else{
                Add-Content -Path $masterLog "CLEAN PASS (Errors: $fileErrors, Warnings: $fileWarnings): $($file.Name)"
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

$timer.Stop()
$endTime = Get-Date
Add-Content -Path $masterLog "Verification Started: $($startTime.ToString('yyyy-MM-dd HH:mm:ss'))"
Add-Content -Path $masterLog "Verification Finished: $($endTime.ToString('yyyy-MM-dd HH:mm:ss'))"
Add-Content -Path $masterLog "Verification Time: $($timer.Elapsed.ToString('hh\:mm\:ss\.ff'))"

if($only_gen_master_log){
    Add-Content -Path $masterLog "`n`n<<<* WARNING *>>> No verification was done, only a masterlog was generated based on the leftover files in the raw_random directory"
}

Write-Host "Master log updated at $masterLog"

Write-Host "`n===============================================`n"
Get-Content $masterLog
Write-Host "`n===============================================`n"

if ($globalAnyErrors) {
    Write-Host "FAIL: Errors detected in one or more logs`n" -ForegroundColor Red
} elseif ($globalAnyWarnings) {
    Write-Host "PASS: " -ForegroundColor Green -NoNewline
    Write-Host "Warnings present`n" -ForegroundColor Yellow
} else {
    Write-Host "CLEAN PASS: No warnings or errors`n" -ForegroundColor Green
}