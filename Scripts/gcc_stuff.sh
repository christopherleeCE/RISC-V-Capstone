#!/usr/bin/env bash
set -e

riscv64-unknown-elf-gcc \
  -march=rv32im -mabi=ilp32 \
  -nostdlib -ffreestanding \
  -c program_gcc_test.c -o program_c.o

#inspecting the unlinked, relocatable obj file
riscv64-unknown-elf-readelf -S program_c.o
riscv64-unknown-elf-objdump -d program_c.o

#ojb -> executable elf, defaut linker
# riscv64-unknown-elf-gcc \
#   -march=rv32im -mabi=ilp32 \
#   -nostdlib \
#   program_c.o -o program_c.elf

#ojb -> executable elf, custom linker
riscv64-unknown-elf-gcc \
  -march=rv32im -mabi=ilp32 \
  -nostdlib \
  -T linker.ld \
  program_c.o -o program_c.elf

#inspect sections
riscv64-unknown-elf-readelf -S program_c.elf

#inspect segments
riscv64-unknown-elf-readelf -l program_c.elf

#dissasemble elf
riscv64-unknown-elf-objdump -D program_c.elf

