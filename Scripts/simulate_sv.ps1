#Call from 'Modules' directory using ../Scripts/simulate_sv.ps1

param(
    [switch]$help,
    [switch]$golden_calc,
    [switch]$dut_dump,
    [switch]$golden_history,
    [switch]$verify_output,
    [switch]$no_verify,
    [switch]$continue,
    [switch]$v,
    [switch]$wave_dump,
    [switch]$no_compile,    
    [int]$time = 100
)

$vsimArgs = ""
$compileCmd = ""
$quartus = $env:QUARTUS_ROOTDIR -replace "\\","/"

if(-not $no_compile){
    $compileCmd = "vlog $quartus/eda/sim_lib/altera_mf.v *.sv *.v"
}

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
    -v:                 enables -golden_calc -dut_dump -golden_history -verify_output -continue
    -wave_dump:         include if you need a wave dump, slows down simulation
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
if ($v)                 { $vsimArgs += " +GOLDEN_CALC +DUT_DUMP +GOLDEN_HISTORY +VERIFY_OUTPUT +CONTINUE"}
if ($wave_dump)         { $vsimArgs += " +WAVE_DUMP" }

#gpt says this was needed for bram but quartus said it only needs altera_mf
#vlog $quartus/eda/sim_lib/220model.v
if($wave_dump){

$do = @"
    file delete -force sim.log;
    transcript file sim.log;
    $compileCmd;
    vsim -voptargs=+acc work.top_riscv_cpu_v2_1 $vsimArgs;
    run ${time}us;
    quit -f
"@
vsim -c -do $do

}else{  #disables optimizations, and deletes waveforms, 
        #(i think that disabled optimatitions might make
        #the wavedump inaccurate, dont quote me on that)
    
$do = @"
    file delete -force sim.log;
    transcript file sim.log;
    $compileCmd;
    vsim work.top_riscv_cpu_v2_1 $vsimArgs;
    run ${time}us;
    quit -f
"@
vsim -c -do $do
Remove-Item -Path dump.vcd -ErrorAction SilentlyContinue

}
