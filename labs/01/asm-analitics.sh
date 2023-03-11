#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 archivo_a_procesar"
  exit 1
fi

archivo_entrada="$1"

# Obtener instrucciones del archivo
instrucciones=$(tail -n +7 "$archivo_entrada" | tr -s '\n' '\n' | grep -v 'Disassembly' | grep '    ' | tr -s>
# Contar instrucciones
dif_instrucciones=$(echo "$instrucciones" | wc -l)
num_instruccioens=$(echo "$instrucciones" | wc -l)
echo "Hay $dif_instrucciones tipos diferentes de instrucciones en este archivo objeto:"
echo "$instrucciones" | awk '{print "    "$2" : Ejecutada "$1" veces"}'

# Obtener funciones
funciones=$(tail -n +7 "$archivo_entrada" | tr -s '\n' '\n' | grep -v 'Disassembly' | grep -v '    ' | tr '<>>
# Contar funciones
num_funciones=$(echo "$funciones" | grep -c '_')

echo "Hay $num_funciones funciones:"
echo "$funciones" | grep '_' | awk '{print "    "$NF" : Localizada en la dirección "$1 addr}'



##tail -n +7 dump  | tr -s '\n' '\n' | grep -v 'Disassembly' | grep '    ' | tr -s ' ' | tr '\t' '#' | cut -f>##tail -n +7 dump  | tr -s '\n' '\n' | grep -v 'Disassembly' | grep -v '    ' | tr '<>' ' ' | tr ':' ' ' | tr>#Estas instrucciones me generan un tipo de archivo de esta manera
#      5 add
#      1 addss
#      1 and
#      6 bnd
#      9 callq
#      2 xor
#0000000000001000 _init
#0000000000001020 .plt
#0000000000001050 __cxa_finalize@plt
#0000000000001060 puts@plt
#0000000000001070 printf@plt
#0000000000001080 _start
#00000000000010b0 deregister_tm_clones



