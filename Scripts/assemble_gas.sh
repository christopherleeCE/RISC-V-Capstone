#!/usr/bin/env bash
set -e

# Check for help flag
if [[ "$1" == "-h" || "$1" == "-help" ]]; then
    echo "Usage: $0"
    echo "Call from 'Modules' directory using ../Scripts/assemble_gas.sh"
    exit 0
fi

# Chris's personal command string (assembly)
riscv64-unknown-elf-as -march=rv32im program_asm.s -o program_asm.o
riscv64-unknown-elf-objdump -d program_asm.o | tee program.log
python3 ./load_instr_mem_file.py