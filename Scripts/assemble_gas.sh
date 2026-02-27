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

riscv64-unknown-elf-as -march=rv32im "$asm_file" -o program_asm.o

#riscv64-unknown-elf-objdump -d program_asm.o

riscv64-unknown-elf-ld \
  -m elf32lriscv \
  -T linker.ld \
  program_asm.o \
  -o program_asm.elf

riscv64-unknown-elf-objdump -d program_asm.elf

riscv64-unknown-elf-objcopy \
  -O binary \
  --gap-fill 0x00 \
  --pad-to 0x1000 \
  -j .text program_asm.elf instr.bin 
hexdump -v -e '1/4 "%08x\n"' instr.bin > instruction_memory.txt

#not sure if the --only-section here will always gra  everythign
riscv64-unknown-elf-objcopy \
  -O binary \
  --only-section=.rodata \
  --only-section=.data \
  --only-section=.bss \
  --gap-fill 0x00 \
  --pad-to 0x2000 \
  program_asm.elf data.bin

truncate -s 4096 data.bin
hexdump -v -e '1/4 "%08x\n"' data.bin > data_memory.txt



#old version
# #!/usr/bin/env bash
# set -e

# # Default file
# asm_file="program_asm.s"

# # Help flag
# if [[ "$1" == "-h" || "$1" == "-help" ]]; then
#     echo "Usage: $0 [assembly_file]"
#     echo "Call from 'Modules' directory using ../Scripts/assemble_gas.sh"
#     echo "If no file is provided, defaults to program_asm.s"
#     exit 0
# fi

# # If argument provided, use it
# if [[ -n "$1" ]]; then
#     asm_file="$1"
# fi

# # Chris's personal command string (assembly)
# riscv64-unknown-elf-as -march=rv32im "$asm_file" -o program_asm.o
# riscv64-unknown-elf-objdump -d program_asm.o | tee program.log
# python3 ./load_instr_mem_file.py
