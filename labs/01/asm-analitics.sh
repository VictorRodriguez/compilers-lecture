#!/usr/bin/bash

MOVS=$(grep mov log | wc -l)
JMPS=$(grep jmp log | wc -l)
ENDS=$(grep end log | wc -l)
SUBS=$(grep sub log | wc -l)
TESTS=$(grep tes log | wc -l)
JES=$(grep je log | wc -l)
CALLS=$(grep call log | wc -l)
ADDS=$(grep add log | wc -l)
RETS=$(grep ret log | wc -l)
PUSHS=$(grep push log | wc -l)
NOPLS=$(grep nopl log | wc -l)

echo "Hi, this is the output of the analysis: "

echo "  movs    :Executed " $MOVS "times"
echo "  jmps    :Executed " $JMPS "times"
echo "  ends    :Executed " $ENDS "times"
echo "  subs    :Executed " $SUBS "times"
echo "  tests    :Executed " $TESTS "times"
echo "  jes    :Executed " $JES "times"
echo "  calls    :Executed " $CALLS "times"
echo "  adds    :Executed " $ADDS "times"
echo "  rets    :Executed " $RETS "times"
echo "  pushs    :Executed " $PUSHS "times"
echo "  nopls    :Executed " $NOPLS "times"
