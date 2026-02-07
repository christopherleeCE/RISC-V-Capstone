$ErrorActionPreference = "Stop"

# Save original location
$root = Split-Path -Parent $PSScriptRoot
$modulesDir = Join-Path $root "Modules"
$scriptsDir = Join-Path $root "Scripts"

# Switch to Modules directory (important for vsim flow)
Set-Location $modulesDir

Write-Host "Generating random assembly..."
python "$scriptsDir\gen_random.py"

if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Assembling in WSL..."
wsl bash -c "
    cd $(wslpath '$modulesDir') &&
    riscv64-unknown-elf-as -march=rv32im program_asm.s -o program_asm.o &&
    riscv64-unknown-elf-objdump -d program_asm.o | tee program.log
"

if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Generating instruction memory file..."
python ".\lead_instr_mem_file.py"

if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Running simulation..."
& "$scriptsDir\simulate_sv.ps1"

if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Flow complete."
