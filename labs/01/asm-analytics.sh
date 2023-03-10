#!/usr/bin/bash

echo 'Hi, this is the output of the analysis'

#Get commands from dump
#tail -n +7 dump  | tr -s '\n' '\n' | grep -v 'Disassembly' | grep '    ' | tr -s ' ' | tr '\t' '#' | cut -f3 -d# | cut -f1 -d' ' | awk NF | sort | uniq -c 


#Get functions from dump
#tail -n +7 dump  | tr -s '\n' '\n' | grep -v 'Disassembly' | grep -v '    ' | tr '<>' ' ' | tr ':' ' ' | tr -s ' ' 

DUMP_FILE="$1"

INSTRUCTIONS=$(tail -n +7 $DUMP_FILE | tr -s '\n' '\n' | grep -v 'Disassembly' | grep '    ' | tr -s ' ' | tr '\t' '#' | cut -f3 -d# | cut -f1 -d' ' | awk NF | sort | uniq -c | sort -r | sed 's/^ *//' | tr ' ' '#')
INSTRUCTION_COUNT=$(echo "$INSTRUCTIONS" | wc -l)

echo -e "    You have $INSTRUCTION_COUNT kind of instructions in this object file:"

for i in $INSTRUCTIONS
do  
    INST_NAME=$(echo $i | cut -f2 -d#)
    INST_COUNT=$(echo $i | cut -f1 -d#)
    printf "\t %-10s : Executed %2d times\n" "$INST_NAME" $INST_COUNT
done

FUNCTIONS=$(tail -n +7 $DUMP_FILE  | tr -s '\n' '\n' | grep -v 'Disassembly' | grep -v '    ' | tr '<>' ' ' | tr ':' ' ' | tr -s ' ' '#' | sort)
FUNCTION_COUNT=$(echo "$FUNCTIONS" | wc -l)

echo -e "\n    You have $FUNCTION_COUNT functions:"

for i in $FUNCTIONS
do  
    FUNCT_NAME=$(echo $i | cut -f2 -d#)
    FUNCT_ADDRESS=$(echo $i | cut -f1 -d#)
    printf "        %-25s  : Located at %s\n" "$FUNCT_NAME" "$FUNCT_ADDRESS"
done
