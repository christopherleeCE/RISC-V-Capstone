# ..\Scripts\directed_master.ps1 -directory functional_s dmem_test.s
python3 .\hex2python.py .\instruction_memory.hex instr.mif
python3 .\hex2python.py .\data_memory.hex data.mif
# ..\Scripts\directed_master.ps1 -directory functional_s dmem_test.s -v
# ..\Scripts\directed_master.ps1 -directory functional_s dmem_test.s -no_run