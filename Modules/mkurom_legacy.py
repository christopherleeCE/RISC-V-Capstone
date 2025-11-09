#!/usr/bin/env python3
# Python rewrite of mkurom.pl
# Produces: sig_declare.inc, ustore.sv, uid.sv
# Usage: python3 mkurom.py

# Notes:
# Single-bit signals set without =value become all-ones for their width. That matches reasonable intent.
# Opcode parsing expects hex tokens (underscores allowed). It falls back to base-0 parse if needed.
# Behavior and output formatting match the original Perl script closely.
# Run from same directory as microcode.sh.

import re
import sys
from collections import OrderedDict

def d2bit(wid, num):
    mask = (1 << wid) - 1
    return format(num & mask, 'b').zfill(wid)

# Read microcode.sh
try:
    with open("./microcode.sh", "r") as f:
        raw_lines = f.readlines()
except IOError:
    print("Cannot open microcode.sh", file=sys.stderr)
    sys.exit(1)

order = []                # preserves signal order
width = {}                # width[name] = int
constant = {}             # name -> value
opcodes_lines = []        # full lines that contain 'OPCODE'
lines = []                # saved ucode lines as "upc <rest>"
upc = 0

for line in raw_lines:
    # strip comments
    line = re.sub(r'#.*', '', line)
    if re.match(r'^\s*$', line):
        continue

    # process SIG lines (note: original perl replaced "SIG " -> "SIG1 ")
    line2 = re.sub(r'\bSIG\s', 'SIG1 ', line)
    m = re.match(r'^\s*SIG(\d)\s+(.*)', line2)
    if m:
        wid = int(m.group(1))
        names = re.split(r'\s+', m.group(2).strip())
        for n in names:
            if n == '':
                continue
            width[n] = wid
            order.append(n)
        continue

    # CONST line
    m = re.match(r'^\s*CONST\s+(.*)', line)
    if m:
        names = re.split(r'\s+', m.group(1).strip())
        for i, n in enumerate(names):
            if n == '':
                continue
            constant[n] = i
        continue

    # label: "<name>:" becomes constant with current upc
    m = re.match(r'^\s*(\S+):', line)
    if m:
        constant[m.group(1)] = upc
        # if label-only line, skip (perl did next if /:/)
        if ':' in line:
            continue

    # OPCODE lines
    if re.search(r'OPCODE', line):
        m = re.match(r'^\s*(\S+)\s+OPCODE', line)
        if m:
            # perl set constant[label] = upc if /^\s*(\S+)\s+OPCODE/
            constant[m.group(1)] = upc
        opcodes_lines.append(line.rstrip('\n'))
        continue

    # Everything else considered ucode line
    if re.search(r'\S', line):
        lines.append(f"{upc} {line.rstrip()}")
        upc += 1

# compute ucode width (sum of individual widths)
uwid = 0
for n in order:
    uwid += width[n]

# deduce uip width (address width)
wid = 3
num = 8
while num < upc:
    num *= 2
    wid += 1

# map instruction starts: constant[label] => label (for opcode lines first token)
instruction_starts = {}
for opl in opcodes_lines:
    first = opl.split()[0]
    if first in constant:
        instruction_starts[constant[first]] = first

# Build urom
urom_lines = []
for entry in lines:
    # replace any occurrences of "=CONST" with numeric value
    # do replacement for tokens like "=NAME"
    for k, v in constant.items():
        entry = re.sub(rf'={re.escape(k)}\b', f"={v}", entry)

    # comment capture: remainder after the initial number
    m = re.match(r'^\s*(\d+)(.*)', entry)
    cmts = m.group(2).strip() if m else ""

    tokens = re.split(r'\s+', entry.strip())
    if len(tokens) == 0:
        continue
    lnum = int(tokens.pop(0))

    seen = {}
    for tok in tokens:
        if tok == '':
            continue
        if '=' in tok:
            name, val = tok.split('=', 1)
            if name not in width:
                print(f"Illegal signal {name} encountered at ucode address {lnum}", file=sys.stderr)
                sys.exit(1)
            # support decimal or hex literal for value
            val_num = int(val, 0)
            seen[name] = d2bit(width[name], val_num)
        else:
            name = tok
            if name not in width:
                print(f"Illegal signal {name} encountered at ucode address {lnum}", file=sys.stderr)
                sys.exit(1)
            # set single-bit to '1' or multi-bit to all-ones
            seen[name] = '1' * width[name]

    # build concatenated bitstring in order
    bitstr = ""
    for n in order:
        if n in seen and seen[n] != 0:
            bitstr += seen[n]
        else:
            bitstr += "0" * width[n]

    # add instruction header comment if this uaddress starts one
    if lnum in instruction_starts:
        instr_name = instruction_starts[lnum]
        urom_lines.append(f"// ==== INSTRUCTION: {instr_name} ====")
    elif "UD_fault" in constant and lnum == constant["UD_fault"]:
        urom_lines.append("// ==== LABEL: UD_fault ====")

    urom_lines.append(f"    {wid}'d{lnum}: sig = {uwid}'b{bitstr}; // {cmts}")

urom = "\n".join(urom_lines) + "\n"

# Build opcode casex
casex_lines = []
for opl in opcodes_lines:
    # replace leading symbolic constants (if any) with numeric equivalents.
    # The perl attempted s/^\s*$k\s+/$constant{$k} /; we will not strictly replicate this.
    # Extract instr name and opcode token.
    m = re.match(r'^\s*(\S+)\s+OPCODE\s+(\S+)', opl)
    if not m:
        continue
    instr = m.group(1)
    opcode_str = m.group(2)
    opcode_str = re.sub(r'[_\s]', '', opcode_str)  # remove underscores/spaces
    # interpret opcode_str as hex. Allow "0x" or plain hex
    try:
        opcode_val = int(opcode_str, 16)
    except ValueError:
        # fallback: try int with base 0 (0b/0x) or decimal
        opcode_val = int(opcode_str, 0)
    casex_lines.append(f"    7'h{opcode_val:02X} :  uip = {wid}'d{constant.get(instr, 0)} ;   // {instr}")

# default UD_fault
ud_fault_val = constant.get("UD_fault", 0)
casex_lines.append(f"    default:      uip = {wid}'d{ud_fault_val} ;   // #UD fault")
casex = "\n".join(casex_lines) + "\n"

# create verilog declarations for signals
declare_lines = []
for n in order:
    w = width[n] - 1
    if w > 0:
        declare_lines.append(f"  logic [{w}:0]{n};")
    else:
        declare_lines.append(f"  logic     {n};")
declare = "\n".join(declare_lines) + "\n"

highaddr = wid - 1
highsignal = uwid - 1

# write sig_declare.inc
with open("./sig_declare.inc", "w") as f:
    f.write("//this file is generated by python script mkurom.py.\n")
    f.write("//Do not edit under pain of losing your edits!\n")
    f.write(f"parameter BIT_WIDTH=32,ADDR_WIDTH=32,UCODE_WIDTH={highsignal}+1,UIP_WIDTH={highaddr}+1; \n\n")
    # print constants that start with UC_
    for k in sorted(constant.keys()):
        if k.startswith("UC_"):
            f.write(f"  parameter {k} = {constant[k]};\n")
    f.write("\n")
    f.write(declare)
    f.write("  logic [UCODE_WIDTH-1:0] sig;\n")
    f.write("  assign {" + ",".join(order) + "} = sig;\n")

# write ustore.sv
with open("./ustore.sv", "w") as f:
    f.write("//this file is generated by python script mkurom.py.\n")
    f.write("//Do not edit under pain of losing your edits!\n")
    f.write("\n")
    f.write("module US__ ( \n      input logic [")
    f.write(f"{highaddr}:0] uip,\n      output logic [")
    f.write(f"{highsignal}:0] sig \n\n")
    f.write("          );\n")
    f.write("always_comb begin\n  unique case ( uip ) \n")
    f.write(urom)
    f.write(f"    default: sig = {uwid}'d0;\n")
    f.write("  endcase\nend\n")
    f.write("endmodule // US__ \n")

# write uid.sv
with open("./uid.sv", "w") as f:
    f.write("//this file is generated by python script mkurom.py.\n")
    f.write("//Do not edit under pain of losing your edits!\n")
    f.write("\n")
    f.write("module UID__ \n")
    f.write(f" # (UIP_WIDTH={wid})\n")
    f.write("( \n      input logic [6:0] opcode,\n")
    f.write("      output logic [UIP_WIDTH-1:0] uip \n")
    f.write("            ); \n")
    f.write("always_comb begin\n  unique case (opcode) inside\n")
    f.write(casex)
    f.write("  endcase\nend\n")
    f.write("endmodule  // UID__ \n")

print("Generated: sig_declare.inc, ustore.sv, uid.sv")
