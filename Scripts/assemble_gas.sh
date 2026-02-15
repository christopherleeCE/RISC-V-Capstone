#!/usr/bin/env bash
set -e

# Default file
asm_file="program_asm.s"

# Help flag
if [[ "$1" == "-h" || "$1" == "-help" ]]; then
    echo "Usage: $0 [assembly_file]"
    echo "Call from 'Modules' directory using ../Scripts/assemble_gas.sh"
    echo "If no file is provided, defaults to program_asm.s"
    exit 0
fi

# If argument provided, use it
if [[ -n "$1" ]]; then
    asm_file="$1"
fi

# Chris's personal command string (assembly)
riscv64-unknown-elf-as -march=rv32im "$asm_file" -o program_asm.o
riscv64-unknown-elf-objdump -d program_asm.o | tee program.log
python3 ./load_instr_mem_file.py