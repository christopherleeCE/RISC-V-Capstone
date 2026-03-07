#!/usr/bin/env python3
import argparse

def hex_to_mif(input_file, output_file, width=32, depth=None):
    words = []

    with open(input_file, "r") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            words.append(line)

    if depth is None:
        depth = len(words)

    with open(output_file, "w") as f:
        f.write(f"WIDTH={width};\n")
        f.write(f"DEPTH={depth};\n\n")
        f.write("ADDRESS_RADIX=HEX;\n")
        f.write("DATA_RADIX=HEX;\n\n")
        f.write("CONTENT BEGIN\n")

        for addr, word in enumerate(words):
            f.write(f"{addr:04X} : {word};\n")

        if depth > len(words):
            f.write(f"[{len(words):04X}..{depth-1:04X}] : 0;\n")

        f.write("END;\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert plain hex words to .mif")
    parser.add_argument("input", help="input hex file (one 32-bit word per line)")
    parser.add_argument("output", help="output .mif file")
    parser.add_argument("--width", type=int, default=32, help="word width (default 32)")
    parser.add_argument("--depth", type=int, help="memory depth (default = number of lines)")

    args = parser.parse_args()

    hex_to_mif(args.input, args.output, args.width, args.depth)