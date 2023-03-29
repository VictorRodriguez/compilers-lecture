
#!/usr/bin/bash
MOVQ=$(grep movq log | wc -l)
JMPS=$(egrep jmp log | wc -l)
MOVSS=$(egrep movss log | wc -l)
ADDSS=$(egrep add log |wc -l)
MOV=$(grep mov log | wc -l)
XOR=$(egrep xor log | wc -l)
SUB=$(egrep sub log | wc -l)
CALL=$(egrep call log |wc -l)
LEAVE=$(grep leave log | wc -l)
RET=$(egrep ret log | wc -l)
LEA=$(egrep lea log | wc -l)
PUSH=$(egrep push log |wc -l)
NOPL=$(grep nopl log | wc -l)
CMPQ=$(egrep cmpq log | wc -l)
MOVB=$(egrep movb log | wc -l)
POP=$(egrep pop log |wc -l)

echo "Hi, this is the output of the analysis: "
echo "		You have 16 kind of instructions in this object file: "




echo "			jmp	:Executed " $JMPS " times "
echo "			movq	:Executed " $MOVQ " times"
echo "			adds	:Executed " $ADDSS " times"
echo "			movss	:Executed " $MOVSS " times"
echo "                  movs     :Executed " $MOV " times "
echo "                  xors    :Executed " $XOR " times"
echo "                  subs    :Executed " $SUB " times"
echo "                  calls   :Executed " $CALL " times"
echo "                  leaves     :Executed " $LEAVE " times "
echo "                  rets    :Executed " $RET " times"
echo "                  leas    :Executed " $LEA" times"
echo "                  pushs   :Executed " $PUSH " times"
echo "                  nopl     :Executed " $NOPL " times "
echo "                  cmpq    :Executed " $CMPQ " times"
echo "                  movb    :Executed " $MOVB " times"
echo "                  pop   :Executed " $POP " times"

# Cuenta cuántas funciones tiene el binario
funciones=$(awk '{if ($2 == "F") {print $0}}' | wc -l)
echo "Funciones: $funciones"

# Imprime la dirección virtual de cada función
awk '{if ($2 == "F") {print $1}}'



 
