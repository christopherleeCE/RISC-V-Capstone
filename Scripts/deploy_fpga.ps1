param(
    [switch]$help,
    [string]$project_name,
    [switch]$y
)

$startTime = Get-Date
$timer = [System.Diagnostics.Stopwatch]::StartNew()

if($project_name -eq ""){
    Write-Host "Error: please give a quartus project name" -ForegroundColor Red
    exit -1
}

if($help){
    Write-Host "
    This script will update the .mif files in quartus, reassemble the quartus output files, and run the fpga programmer.
    Call from the project directory

    -help:          brings up this dialog
    -project_name:  define the project name, flag not needed but the argument is
    -y:             skip confirmation prompt before programming

    Usage Example: 
    PS C:\Users\Chris\Documents\Quartus\Quartus Projects\new_capstone> ..\..\Prototype\RISC-V-Capstone\Scripts\deploy_fpga.ps1 new_capstone
    "
    exit 0
}

#extract relative directory from the cmd line call
$projectName = $project_name
$scriptDir = $PSScriptRoot
$relativeScriptPath = Resolve-Path $scriptDir -Relative -ErrorAction SilentlyContinue

Write-Host "`nUsing project: $projectName" -ForegroundColor Blue
Write-Host "Relative path to .tcl files: $relativeScriptPath" -ForegroundColor Blue
Write-Host "Updating .mif's in Quartus and assembling...`n" -ForegroundColor Magenta

quartus_sh -t "$relativeScriptPath\assemble.tcl" $projectName
if ($LASTEXITCODE -ne 0) {Write-Host "`n'quartus_sh -t "$relativeScriptPath\assemble.tcl" $projectName' threw an error`n" -ForegroundColor Red}

if(-not $y){
    Write-Host "`nFinished assembling, Press the 'ANY KEY' to run the programmer... " -ForegroundColor Magenta -NoNewLine
    Read-Host

}Write-Host "`nFinished assembling, running the programmer... " -ForegroundColor Magenta

quartus_sh -t "$relativeScriptPath\program.tcl" $projectName
if ($LASTEXITCODE -ne 0) {Write-Host "`n'quartus_sh -t "$relativeScriptPath\program.tcl" $projectName' threw an error`n" -ForegroundColor Red}

$timer.Stop()
$endTime = Get-Date
Write-Host "`nScript Started: $($startTime.ToString('yyyy-MM-dd HH:mm:ss'))"
Write-Host "Script Finished: $($endTime.ToString('yyyy-MM-dd HH:mm:ss'))"
Write-Host "Script Runtime: $($timer.Elapsed.ToString('hh\:mm\:ss\.ff'))"

Write-Host ""
exit 0