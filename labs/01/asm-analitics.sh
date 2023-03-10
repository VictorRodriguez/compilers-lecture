#!/usr/bin/bash


# validar argumentos recibidos
if test $# -eq 1
then
# obtener archivo instrucciones
 cat $1 | cut -c -28 --complement | tr [:blank:] @ | cut -f1 -d@ | egrep -v : | sed '/^$/d' | tail -n +2 | sort | uniq -c | tr [:blank:] @ | tr -s @ > f_inst
 linea1=`cat f_inst | wc -l`
 echo -e "\nHi, this is the output of the analysis...\n"
 echo -e "\tYou have $linea1 kind of instructions in this object file:\n"
# ciclo para representacion de datos
 cat f_inst | cut -d@ -f2 > i_inst
 cat f_inst | cut -d@ -f3 > w_inst
 line=1
 for what in `cat w_inst`
 do
  name_inst=`echo $what`
  num_inst=`cat i_inst | tail -n+$line | head -1`
  line=$(($line+1))
  echo -e "\t\t$name_inst\t: Executed $num_inst times\n"
 done

# obtener archivo funciones
 cat $1 | egrep '>:' | tr -d [:blank:],'>:' > f_func
 linea2=`cat f_func | wc -l`
 echo -e "\n\tYou have $linea2 functions:\n"
# ciclo para representacion de datos
 cat f_func | cut -d'<' -f1 > ad_func
 cat f_func | cut -d'<' -f2 > w_func
 for what_func in `cat w_func`
 do
  name_func=`echo $what_func`
  for address in `cat ad_func`
  do
   address_func=`echo $address`
  done
  echo -e "\t\t$name_func\t: Located at $address_func addr\n"
 done
else
 echo -e "\nERROR. The script needs 1 parameter.\n"
fi
