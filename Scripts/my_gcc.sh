#!/usr/bin/env bash
set -e

# --- Defaults ---
file="program_asm.s"
mode="gas"
notb=false

# --- Argument Parsing ---
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|-help)
      echo "Usage: $0 [-gcc | -gas] [assembly_file]"
      echo "  -help : Show this menu"
      echo "  -gcc  : Use GCC toolchain"
      echo "  -gas  : Use GAS toolchain (default)"
      echo "  -notb : passes -DNO_TB to compilation flags"
      exit 0
      ;;
    -gcc)
      mode="gcc"
      shift
      ;;
    -gas)
      mode="gas"
      shift
      ;;
    -notb)
      notb=true
      shift
      ;;
    -*)
      echo "Error: Unknown option $1"
      exit 1
      ;;
    *)
      # Treat any non-flag argument as the filename
      file="$1"
      shift
      ;;
  esac
done

define=""
if [ "$notb" = true ]; then
    define="-DNO_TB"
fi

#check if file exits
if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' not found."
    exit 1
fi

#check if we are in the right directory
if [ "$(basename "$PWD")" != "Modules" ]; then
    echo "Error: not running in Modules directory"
    exit 1
fi

#check extionsion aligh with mode
extension="${file##*.}"

if [[ "$mode" == "gcc" && "$extension" != "c" ]]; then
    echo "Error: -gcc mode requires a .c file (found .$extension)"
    exit 1
elif [[ "$mode" == "gas" && "$extension" != "s" ]]; then
    echo "Error: -gas mode requires a .s file (found .$extension)"
    exit 1
fi

if [ "$mode" = "gas" ] ; then

    riscv64-unknown-elf-as \
    -march=rv32im \
    "$file" \
    -o program.o

    riscv64-unknown-elf-ld \
    -m elf32lriscv \
    -T linker.ld \
    program.o \
    -o program.elf

elif [ "$mode" = "gcc" ] ; then

    #gpt recomended linking and compiling in one stage, its reasoning didnt seem super sound,
    #commented out old compile + link method below

    #defines the following..
    #target isa
    #abi (whatever that is)
    #excludes std lib
    #excludes automatic _start (we define it manually)
    #prevents compiler from adding in builtin funcs like memcpy as we define those ourselves, might not be necissary
    #defines no OS everioment
    #defines linker script
    #input file
    #include path (headers)
    #library path (static)
    #link library libdrysoup.a
    #some these may not be necissary , but i havent flound any issues with including them
    riscv64-unknown-elf-gcc \
    -march=rv32im \
    -mabi=ilp32 \
    -nostdlib \
    -nostartfiles \
    -fno-builtin \
    -ffreestanding \
    -T linker.ld \
    $define \
    "$file" \
    -I../Programs/directed/lib \
    -L../Programs/directed/lib \
    -ldrysoup \
    -lgcc \
    -o program.elf

    #read -p "Press Enter to continue..."

    # riscv64-unknown-elf-gcc \
    # -march=rv32im \
    # -mabi=ilp32 \
    # -nostdlib \
    # -nostartfiles \
    # -ffreestanding \
    # -c "$file" \
    # -o program.o

fi

#riscv64-unknown-elf-objdump -d program.o

# riscv64-unknown-elf-ld \
# -m elf32lriscv \
# -T linker.ld \
# program.o \
# -o program.elf

#.text dump for debuging
riscv64-unknown-elf-objdump -d program.elf

riscv64-unknown-elf-objcopy \
  -O binary \
  --gap-fill 0x00 \
  --pad-to 0x18000 \
  -j .text program.elf instr.bin 


hexdump -v -e '1/4 "%08x\n"' instr.bin > instruction_memory.hex #reversing display order of bytes order for .txt


# --only-section=.bss \ was removed as it was
# causeing an error with the obj copy, .bss is just
# zeroing out allocated memory, so since we turncate
# the .bin anway, the memory looks the same regardless
# with or without it

#not sure if the --only-section here will always grab everythign
riscv64-unknown-elf-objcopy \
  -O binary \
  --only-section=.rodata \
  --only-section=.data \
  --gap-fill 0x00 \
  --pad-to 0x2C000 \
  program.elf data.bin

truncate -s 81920 data.bin #fills data.bin with 80kb of zeros if empty
hexdump -v -e '1/4 "%08x\n"' data.bin > data_memory.hex #reversing display order of bytes for .txt
