param(
    [switch]$Help
)

if ($Help) {
    # You can put your usage message here
    Write-Output "Call from 'Modules' directory using ../simulate_sv.ps1"
    exit 0
}

vsim -c -do "file delete -force sim.log; transcript file sim.log; vlog *.sv; vsim -voptargs=+acc work.top_riscv_cpu_v2_1; run 5us; quit -f"
