#!/usr/bin/env python3

import sys
import re
from collections import defaultdict

if len(sys.argv) != 2:
    print(f"Usage: {sys.argv[0]} <objdump-output-file>")
    sys.exit(1)

infile = sys.argv[1]

# Count how many different instructions there are
instructions = set()
with open(infile) as f:
    for line in f:
        match = re.match(r"\s*\d+:\s+(\w+)", line)
        if match:
            instructions.add(match.group(1))
instruction_count = len(instructions)

# Count how many times each instruction is used
instruction_counts = defaultdict(int)
with open(infile) as f:
    for line in f:
        match = re.match(r"\s*\d+:\s+(\w+)\s", line)
        if match:
            instruction_counts[match.group(1)] += 1
instruction_counts = [f"{k} : Executed {v} times" for k, v in instruction_counts.items()]

# Count how many functions the binary has
functions = []
with open(infile) as f:
    for line in f:
        match = re.match(r"\s*([0-9a-f]+)\s+<(.+)>:", line)
        if match:
            functions.append((match.group(2), match.group(1)))
function_count = len(functions)

# Print the virtual address of each function
function_addresses = [f"{name} : Located at {addr} addr" for name, addr in functions]

# Print the output
print("Hi, this is the output of the analysis:")
print(f"    You have {instruction_count} kinds of instructions in this object file:")
print("    " + "\n    ".join(instruction_counts))
print(f"    You have {function_count} functions:")
print("    " + "\n    ".join(function_addresses))

