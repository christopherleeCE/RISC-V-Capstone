#!/usr/bin/env bash
set -e

#riscv64-unknown-elf-as -march=rv32im program_asm.s -o program_asm.o

# riscv64-unknown-elf-gcc \
#   -march=rv32im -mabi=ilp32 \
#   -nostdlib -ffreestanding \
#   -c program_gcc_test.c -o program_asm.o

riscv64-unknown-elf-as -march=rv32im "program_asm.s" -o program_asm.o

riscv64-unknown-elf-ld \
  -m elf32lriscv \
  -T linker.ld \
  program_asm.o \
  -o program_asm.elf

riscv64-unknown-elf-objcopy -O binary -j .text program_asm.elf instr.bin

# riscv64-unknown-elf-objcopy -O binary -j .text program_asm.elf instr.bin
# hexdump -v -e '1/4 "%08x\n"' instr.bin > instruction_memory.txt

# riscv64-unknown-elf-objcopy -O binary \
#   -j .data \
#   -j .rodata \
#   program_asm.elf data.bin

riscv64-unknown-elf-objcopy \
  -O binary \
  --only-section=.rodata \
  --only-section=.data \
  --only-section=.bss \
  --change-section-lma .rodata=0 \
  --change-section-lma .data=0 \
  --change-section-lma .bss=0 \
  --gap-fill 0x00 \
  --pad-to 0x1000 \
  program_asm.elf data.bin
