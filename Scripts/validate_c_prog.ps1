#only works with .text only programs

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
    [int]$time = 100,
    [string]$program_file_name = ''
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

wsl bash -c "../Scripts/compile_gcc.sh $program_file_name"
vsim -c -do "file delete -force sim.log; transcript file sim.log; vlog *.sv; vsim -voptargs=+acc work.top_riscv_cpu_v2_1 $vsimArgs; run ${time}us; quit -f"

Write-Output('')
Write-Output("Parsing return value from sim...`n")
$simReturnValue = [int](
    (Select-String -Path .\sim.log -Pattern 'Return value in a0:\s+(-?\d+)').Matches[0].Groups[1].Value
)

Write-Output("Running program in WSL-x86 and parsing return value`n")
$x86ReturnValue = wsl bash -c "gcc $program_file_name -DX86_BUILD -o x86.out && ./x86.out"
$x86ReturnValue = [int]$x86ReturnValue.Trim('<', '>')

if($x86ReturnValue -eq $simReturnValue){
    Write-Output("$($PSStyle.Foreground.Green)Pass... `nsim: $simReturnValue `nx86: $x86ReturnValue$($PSStyle.Reset)`n")

}else{
    Write-Output("$($PSStyle.Foreground.Red)Fail... `nsim: $simReturnValue `nx86: $x86ReturnValue$($PSStyle.Reset)`n")

}

