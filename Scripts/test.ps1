# Stop on errors
$ErrorActionPreference = "Stop"

Write-Host "Running GAS assembly in WSL..."

# Run the bash script inside WSL
wsl bash -c "../Scripts/assemble_gas.sh"

# Check if WSL command failed
if ($LASTEXITCODE -ne 0) {
    Write-Error "assemble_gas.sh failed."
    exit 1
}

Write-Host "Assembly complete."
Write-Host "Running simulation..."

# Run the PowerShell simulation script
..\Scripts\simulate_sv.ps1

if ($LASTEXITCODE -ne 0) {
    Write-Error "simulate_sv.ps1 failed."
    exit 1
}

Write-Host "Flow completed successfully."
