#!/usr/bin/env bash
set -e

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: $0"
    echo "Call from 'Modules' directory using ../compile_gcc.sh"
    exit 0
fi

# C compile path
riscv64-unknown-elf-gcc -O0 -march=rv32i -mabi=ilp32 -c test.c -o test.o
riscv64-unknown-elf-objdump -d test.o | tee chris_prog.log
python3 ./load_instr_mem_file.py
