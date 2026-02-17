#!/usr/bin/env bash
set -e

#riscv64-unknown-elf-as -march=rv32im program_asm.s -o program_asm.o

riscv64-unknown-elf-gcc \
  -march=rv32im -mabi=ilp32 \
  -nostdlib -ffreestanding \
  -c program_gcc_test.c -o program_asm.o

riscv64-unknown-elf-ld \
  -m elf32lriscv \
  -T linker.ld \
  program_asm.o \
  -o program_asm.elf

riscv64-unknown-elf-objcopy -O binary -j .text program_asm.elf instr.bin

riscv64-unknown-elf-objcopy -O binary \
  -j .data \
  -j .rodata \
  program_asm.elf data.bin
