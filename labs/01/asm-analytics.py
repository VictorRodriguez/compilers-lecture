import sys

file_name = str(sys.argv[1])
file = open(file_name, "r")
functions = {}
instructions = {}

for line in file:
	ins_line = line.split()
	if len(ins_line) == 2 and ins_line[1].startswith('<'):
		instruction = ins_line[1][1:len(ins_line[1]) - 2]
		if not(instruction in functions):
			functions[instruction] = ins_line[0]

	if len(ins_line) > 1 and len(ins_line[1]) == 2 and len(ins_line[0]) == 4:
		for i in range (1, len(ins_line)):
			ins = ins_line[i]
			if not(len(ins) == 2):
				if ins in instructions:
					instructions[ins] = instructions[ins] + 1
				else:
					instructions[ins] = 1
				break

print ("Hi, this is the output of the analysis:")
print("\tYou have %d kind of instructions in this object file:" %(len(instructions)))

for (x, y) in instructions.items():
	print("\t\t{}: Executed {} times".format(x, y))
print("\tYou have {} functions:".format(len(functions)))
for x, y in functions.items():
	print("\t\t{}\t\t: Located at {} addr".format(x, y))


