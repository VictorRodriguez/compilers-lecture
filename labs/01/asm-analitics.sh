#!/bin/bash

echo "Hi, this is the output of the analysis:"

echo -n "You have "
cat simple_foo.s | grep -oE '^\s*[a-z]+[bwl]*\s' | sort | uniq | wc -l | tr '\n' ' '
echo "different kinds of instructions in this object file:"
cat simple_foo.s | grep -oE '^\s*[a-z]+[bwl]*\s' | sort | uniq -c | sort -rn | awk '{print $2, ":", "Executed", $1, "times"}'

echo -n "You have "
grep -c '^[a-zA-Z0-9_]\+\s*[a-zA-Z0-9_]\+\s*(' simple_foo.c | tr '\n' ' '
echo "functions:"
nm -C simple_foo | grep ' T ' | grep -v ' _start$' | grep -E '^(0+| )'"$(objdump -t simple_foo | grep '\.text' | awk '{print $1}')" | awk '{print $3, "located at address", $1}'
