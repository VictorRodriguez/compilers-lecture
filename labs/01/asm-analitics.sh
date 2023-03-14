#!/usr/bin/bash


echo 'hi, start of the program'

echo 'the number of lines in simple_foo file are:'
objdump -d ./simple_foo | wc -l

echo 'the number of lines with instructions are:'
objdump -d ./simple_foo | grep -hP '^[ \t]+[a-z]*'| sed 's/^[ \t]\+\([a-z]*\).*/\1/' | sort | uniq -c

echo 'the number of mov'
objdump -d ./simple_foo | grep -wo mov | wc -w

echo 'list of assembly instructions'
objdump -d ./simple_foo |grep ^\ |expand|cut -c41-|sed 's/ .*//'|sort|uniq -c|sort -n -r |head
