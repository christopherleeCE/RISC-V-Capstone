#!/usr/bin/env bash
set -e

c_file="program_c.c"

# Check for help flag
if [[ "$1" == "-h" || "$1" == "-help" ]]; then
    echo "Usage: $0 [c_file]"
    echo "Call from 'Modules' directory using ../Scripts/compile_gcc.sh"
    echo "If no file is provided, defaults to program_c.c"
    exit 0
fi

# If argument provided, use it
if [[ -n "$1" ]]; then
    c_file="$1"
fi

# C compile path
riscv64-unknown-elf-gcc -O0 -march=rv32i -mabi=ilp32 -c "$c_file" -o program_c.o
riscv64-unknown-elf-objdump -d program_c.o | tee program.log
python3 ./load_instr_mem_file.py
