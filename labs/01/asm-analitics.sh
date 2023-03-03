#!/usr/bin/bash

MOVS=$(grep mov log | wc -l)
JMPS=$(grep jmp log | wc -l)

echo "Total of movs: " $MOVS
echo "Total of jmps: " $JMPS

