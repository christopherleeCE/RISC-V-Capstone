
param(
    [switch]$help,
    [switch]$no_rand
)

$startTime = Get-Date
$timer = [System.Diagnostics.Stopwatch]::StartNew()

if($help){
    Write-Host "
    -help:      brings up this dialog
    -no_rand:   skips the randomized testing at the end, use if you only need the directed testing

    run this before any commit, do not push without getting a pass from all of the tests (including random).
    The script will run a test, display the results, and prompt you to press ENTER to continue onto the next test,
    on my home desktop it takes about 10 minutes, (2 if you exclude random)
    "
    exit 0
}

#check if we are in /modules/
$currentDirName = Split-Path -Leaf (Get-Location)
if ($currentDirName -ne "Modules") {
    Write-Host "`nError: Script must be run from the Modules folder. Current folder is $currentDirName`n" -ForegroundColor Red
    exit 1
}

../Scripts/directed_master.ps1 #-mem_dump
if ($LASTEXITCODE -ne 0) {Write-Host "`n'../Scripts/directed_master.ps1' threw an error, FAIL`n" -ForegroundColor Red}
Write-Host "Finished running '../Scripts/directed_master.ps1'" -ForegroundColor Blue
Write-Host "Press Enter to continue to the next test " -ForegroundColor Yellow -NoNewLine
Read-Host

../Scripts/directed_master.ps1 -directory opt #-mem_dump
if ($LASTEXITCODE -ne 0) {Write-Host "`n'../Scripts/directed_master.ps1 -directory opt' threw an error, FAIL`n" -ForegroundColor Red}
Write-Host "Finished running '../Scripts/directed_master.ps1 -directory opt'" -ForegroundColor Blue
Write-Host "Press Enter to continue to the next test " -ForegroundColor Yellow -NoNewLine
Read-Host

../Scripts/directed_master.ps1 -directory opt -compile #-mem_dump
if ($LASTEXITCODE -ne 0) {Write-Host "`n'../Scripts/directed_master.ps1 -directory opt -compile' threw an error, FAIL`n" -ForegroundColor Red}
Write-Host "Finished running '../Scripts/directed_master.ps1 -directory opt -compile'" -ForegroundColor Blue
Write-Host "Press Enter to continue to the next test " -ForegroundColor Yellow -NoNewLine
Read-Host

../Scripts/directed_master.ps1 -directory functional_s #-mem_dump
if ($LASTEXITCODE -ne 0) {Write-Host "`n'../Scripts/directed_master.ps1 -directory functional_s' threw an error, FAIL`n" -ForegroundColor Red}
Write-Host "Finished running '../Scripts/directed_master.ps1 -directory functional_s'" -ForegroundColor Blue
Write-Host "Press Enter to continue to the next test " -ForegroundColor Yellow -NoNewLine
Read-Host

../Scripts/directed_master.ps1 -directory functional_c -compile #-mem_dump
if ($LASTEXITCODE -ne 0) {Write-Host "`n'../Scripts/directed_master.ps1 -directory functional_c -compile' threw an error, FAIL`n" -ForegroundColor Red}
Write-Host "Finished running '../Scripts/directed_master.ps1 -directory functional_c -compile'" -ForegroundColor Blue
Write-Host "Press Enter to continue to the next test " -ForegroundColor Yellow -NoNewLine
Read-Host

if(-not $no_rand){
    ../Scripts/random_master.ps1 -runs 100 #-mem_dump
    if ($LASTEXITCODE -ne 0) {Write-Host "`n'../Scripts/random_master.ps1 -runs 100' threw an error, FAIL`n" -ForegroundColor Red}
    Write-Host "Finished running '../Scripts/random_master.ps1 -runs 100'" -ForegroundColor Blue
    Write-Host "Press Enter to continue to the next test " -ForegroundColor Yellow -NoNewLine
    Read-Host
}

Write-Host "Regresssion testing complete, press Enter to finish..." -ForegroundColor Magenta
Read-Host


$timer.Stop()
$endTime = Get-Date
Write-Host "Verification Started: $($startTime.ToString('yyyy-MM-dd HH:mm:ss'))"
Write-Host "Verification Finished: $($endTime.ToString('yyyy-MM-dd HH:mm:ss'))"
Write-Host "Verification Time: $($timer.Elapsed.ToString('hh\:mm\:ss\.ff'))"

Write-Host ""
exit 0