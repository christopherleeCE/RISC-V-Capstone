#!/usr/bin/env python3

import argparse

def parse_hex(input_file, output_file):

    tmp_lines = []

    with open(input_file, "r") as fin:
        for _ in range(3): #skip header lines
            next(fin, None)

        addr = 0x0000
        for line in fin:
            line = line.strip()
            if not line:
                continue

            if(addr % 16 == 0):
                tmp_lines.append("\n")
            tmp_lines.append(f"0x[{addr:04X}] : 0x[{line}] ")
            tmp_lines.append("\t")
            addr = addr + 4

    with open(output_file, "w") as fout:
        for line in reversed(tmp_lines):
            fout.write(line)
            #fout.write(input_file)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Parses .hex dump to byte table with abs address, hardcoded infile and outfile")
    #parser.add_argument("input", help="input hex file (one 32-bit word per line)")
    #parser.add_argument("output", help="output .mif file")
    args = parser.parse_args()

    parse_hex("imem_dut_dump.hex", "imem_dut_dump.log")
    parse_hex("imem_gold_dump.hex", "imem_gold_dump.log")