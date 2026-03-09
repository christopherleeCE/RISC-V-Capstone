
param(
    [switch]$help,
    [switch]$no_rand
)

$startTime = Get-Date
$timer = [System.Diagnostics.Stopwatch]::StartNew()

if($help){
    Write-Host "
    -help:  brings up this dialog

    run this b4 any commit, do not push without getting a pass from all 4 of the tests
    "
}

#check if we are in /modules/
$currentDirName = Split-Path -Leaf (Get-Location)
if ($currentDirName -ne "Modules") {
    Write-Host "`nError: Script must be run from the Modules folder. Current folder is $currentDirName`n" -ForegroundColor Red
    exit 1
}

../Scripts/directed_master.ps1
Write-Host "Finished running ../Scripts/directed_master.ps1" -ForegroundColor Blue
Write-Host "Press Enter to continue to the next test" -ForegroundColor Yellow
Read-Host

../Scripts/directed_master.ps1 -directory functional_s
Write-Host "Finished running ../Scripts/directed_master.ps1 -directory functional_s" -ForegroundColor Blue
Write-Host "Press Enter to continue to the next test" -ForegroundColor Yellow
Read-Host

../Scripts/directed_master.ps1 -directory functional_c -compile
Write-Host "Finished running ../Scripts/directed_master.ps1 -directory functional_c -compile" -ForegroundColor Blue
Write-Host "Press Enter to continue to the next test" -ForegroundColor Yellow
Read-Host

../Scripts/directed_master.ps1 -directory opt
Write-Host "Finished running ../Scripts/directed_master.ps1 -directory opt" -ForegroundColor Blue
Write-Host "Press Enter to continue to the next test" -ForegroundColor Yellow
Read-Host

../Scripts/directed_master.ps1 -directory opt -compile
Write-Host "Finished running ../Scripts/directed_master.ps1 -directory opt -compile" -ForegroundColor Blue
Write-Host "Press Enter to continue to the next test" -ForegroundColor Yellow
Read-Host

if(-not $no_rand){
    ../Scripts/random_master.ps1 -runs 100
    Write-Host "Finished running ../Scripts/random_master.ps1 -runs 100" -ForegroundColor Blue
    Write-Host "Press Enter to continue to the next test" -ForegroundColor Yellow
    Read-Host
}

Write-Host "Regresssion testing complete, press Enter to finish..." -ForegroundColor Magenta
Read-Host


$timer.Stop()
$endTime = Get-Date
Write-Host "Verification Started: $($startTime.ToString('yyyy-MM-dd HH:mm:ss'))"
Write-Host "Verification Finished: $($endTime.ToString('yyyy-MM-dd HH:mm:ss'))"
Write-Host "Verification Time: $($timer.Elapsed.ToString('hh\:mm\:ss\.ff'))"