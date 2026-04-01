param(
    [switch]$build,
    [switch]$deploy
)

$OldPath = Get-Location
Set-Location "C:\Users\Chris\Documents\Quartus\Projects\new_capstone"

if($build){
    & "..\..\Questa Projects\Prototype\Git_Home\Scripts\build_quartus.ps1" new_capstone 
}if($deploy){
    & "..\..\Questa Projects\Prototype\Git_Home\Scripts\deploy_fpga.ps1" new_capstone -y
}

Set-Location $OldPath