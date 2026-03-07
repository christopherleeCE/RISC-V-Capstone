#Call from 'Modules' directory using ../Scripts/simulate_sv.ps1

param(
    [switch]$help,
    [switch]$golden_calc,
    [switch]$dut_dump,
    [switch]$golden_history,
    [switch]$verify_output,
    [switch]$no_verify,
    [switch]$continue,
    [switch]$verbose,
    [switch]$v,
    [int]$time = 100
)

$vsimArgs = ""

if ($Help) {
    # You can put your usage message here
    Write-Output "
    -help:              shows this dialog
    -golden_calc:       shows the debug info for the golden values calculated on every posedge
    -dut_dump:          shows a dump of all dut on every negedge
    -golden_history:    shows dump of golden_history[] on every negedge
    -verify_output:     shows debug info of verify_row()'s
    -no_verify:         disable verification, script will verify if this argument is NOT given
    -continue:          continue simulation even on instruction failure
    -verbose:           enables -golden_calc -dut_dump -golden_history -verify_output -continue
    -v:                 same as -verbose
    -time <INTEGER>     sets the runtime of the questia simulation to be <INTEGER> micro seconds, default is 2us
    "
    exit 0
}

if ($golden_calc)       { $vsimArgs += " +GOLDEN_CALC" }
if ($dut_dump)          { $vsimArgs += " +DUT_DUMP" }
if ($golden_history)    { $vsimArgs += " +GOLDEN_HISTORY" }
if ($verify_output)     { $vsimArgs += " +VERIFY_OUTPUT"}
if ($no_verify)         { $vsimArgs += " +NO_VERIFY" }
if ($continue)          { $vsimArgs += " +CONTINUE" }
if ($verbose)           { $vsimArgs += " +GOLDEN_CALC +DUT_DUMP +GOLDEN_HISTORY +VERIFY_OUTPUT +CONTINUE"}
if ($v)                 { $vsimArgs += " +GOLDEN_CALC +DUT_DUMP +GOLDEN_HISTORY +VERIFY_OUTPUT +CONTINUE"}

#todo add *.v in vlog
#test if both includes are needed at some point
$quartus = $env:QUARTUS_ROOTDIR -replace "\\","/"
$do = @"

file delete -force sim.log;
transcript file sim.log;
vlog $quartus/eda/sim_lib/altera_mf.v
vlog *.sv *.v
vsim -voptargs=+acc work.top_riscv_cpu_v2_1 $vsimArgs;
run ${time}us;
quit -f
"@

#gpt says this was needed for bram but quartus said it only needs altera_mf
#vlog $quartus/eda/sim_lib/220model.v

vsim -c -do $do