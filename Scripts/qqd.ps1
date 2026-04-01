param(
    [switch]$build,
    [switch]$deploy
)

$OldPath = Get-Location
Set-Location "C:\Users\Chris\Documents\Quartus\Quartus Projects\new_capstone"

if($build){
    & '..\..\Prototype\RISC-V-Capstone\Scripts\build_quartus.ps1' new_capstone 
}if($deploy){
    & '..\..\Prototype\RISC-V-Capstone\Scripts\deploy_fpga.ps1' new_capstone -y
}

Set-Location $OldPath