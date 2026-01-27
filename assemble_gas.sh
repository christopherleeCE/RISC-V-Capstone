#!/usr/bin/env bash
set -e

# Check for help flag
if [[ "$1" == "-h" || "$1" == "-help" ]]; then
    echo "Usage: $0"
    echo "Call from 'Modules' directory using ../assemble_gas.sh"
    exit 0
fi

# Chris's personal command string (assembly)
riscv64-unknown-elf-as -march=rv32im chris_prog.s -o chris_prog.o
riscv64-unknown-elf-objdump -d chris_prog.o | tee chris_prog.log
python3 ./load_instr_mem_file.py