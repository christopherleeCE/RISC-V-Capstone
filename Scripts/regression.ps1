param(
    [switch]$help
)

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
Write-Host "Press Enter to continue to the next test" -ForegroundColor Yellow
Read-Host

../Scripts/directed_master.ps1 -directory functional_s
Write-Host "Press Enter to continue to the next test" -ForegroundColor Yellow
Read-Host

../Scripts/directed_master.ps1 -directory functional_c -compile
Write-Host "Press Enter to continue to the next test" -ForegroundColor Yellow
Read-Host

../Scripts/random_master.ps1 -runs 100
Write-Host "Press Enter to finish" -ForegroundColor Yellow
Read-Host