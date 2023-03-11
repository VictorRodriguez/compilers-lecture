#!/usr/bin/bash

#echo log | awk '{print $0, ":", $2}' 
awk 'length($5)>2 {print $5}' log | grep -o '^[a-zA-Z]\+' | sort | uniq > commands

#awk '{print $0}' commands | grep -o '^[a-zA-Z]\+' 
cantInst=`cat commands | wc -l`
echo -e "You have $cantInst kind of instructions in this object file:"
cat commands

echo -n "You have "
grep -c '^[a-zA-Z0-9_]\+\s*[a-zA-Z0-9_]\+\s*(' simple_foo.c | tr '\n' ' '
echo "Functions:"
nm -C simple_foo | grep ' T ' | grep -v ' _start$' | grep -E '^(0+| )'"$(objdump -t simple_foo | grep '\.text' | awk '{print $1}')" | awk '{print $3, "Located at address: 0x", $1}'

