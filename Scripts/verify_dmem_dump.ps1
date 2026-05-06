param(
    [switch]$help
)

if($help){
    Write-Host "Checks if dmem_dut_dump.log is the same as dmem_gold_dump.log"
    exit 0
}

python3 ..\Scripts\parse_dmem_dump.py

if((Get-FileHash ".\dmem_dut_dump.log").Hash -eq (Get-FileHash ".\dmem_gold_dump.log").Hash){
    Write-Host "Matching data_mem dumps" -ForegroundColor Green
}else{
    Write-Host "Mismatched data_mem dumps" -ForegroundColor Red
    exit -1
}