import re

# Input objdump file
input_file = "program.log"
output_file = "instruction_memory.txt"

# Regular expression to match the machine code hex
# Example line: 0: 01050513 addi a0,a0,16
hex_pattern = re.compile(r'^\s*[0-9a-f]+:\s+([0-9a-f]{8})', re.IGNORECASE)

with open(input_file, 'r') as f_in, open(output_file, 'w') as f_out:
    for line in f_in:
        match = hex_pattern.match(line)
        if match:
            machine_code = match.group(1)
            f_out.write(machine_code + '\n')

print(f"Machine code written to {output_file}")
