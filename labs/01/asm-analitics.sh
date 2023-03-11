#!/usr/bin/bash
echo 'Esta es mi tarea del laboratorio 01'
#Asesoria
MOVS=$(grep mov log | wc -l)
JMPS=$(grep jmp log | wc -l)

echo "Total of movs: " $MOVS
echo "Total of jmps: " $JMPS



OBJ_FILE="simple_foo"

objdump -S "$OBJ_FILE" > log

# Analyze the log file and extract the instruction and function data
#cat log | awk -F '  +' '{print $2}' | sed  '/^$/d' | awk '{$1=$1};1' | cut -d ' ' -f 1 | sort -u
#INSTRUCTIONS=$(grep -oP '^\s*\d+:\s+\S+\s+' log | awk '{print $2}' | sort | uniq -c | sort -rn)
INSTRUCTIONS=$(grep -oP '^\s*\d+:\s+\S+\s+ | [0-9a-f][0-9a-f].*[0-9a-f][0-9a-f]\s+' log | awk '{print $2}' | sort | uniq -c | sort -rn)
#INSTRUCTIONS=$(grep -oP '^\s*\d+:\s+\S+\s+ | [0-9a-f][0-9a-f]\s+' log | awk '{print $2}' | sort | uniq -c | sort -rn)
FUNCTIONS=$(grep -oP '\s+[0-9a-f]+\s+<.*>:|^[0-9a-f]+ <.*>:' log | awk '{print $NF, ":", "Located at", $1, "addr"}')

# Print the analysis results
echo "Hi, this is the output of the analysis:"
echo "You have $(echo "$INSTRUCTIONS" | wc -l) kinds of instructions in this object file:"
echo "$INSTRUCTIONS"
echo "You have $(echo "$FUNCTIONS" | wc -l) functions:"
echo "$FUNCTIONS"
