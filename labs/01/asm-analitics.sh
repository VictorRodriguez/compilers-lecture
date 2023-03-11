#!/usr/bin/bash

     #Lógica instrucciones

     numinstr=$(objdump -d ./simple_foo | grep "^ " | tr ' ' '_' | sed 's/.\{31\}//' | awk -F_ '{print $1}' | sort | sed '/^$/D' | uniq -c | cut -f1)
     nameinstr=$(objdump -d ./simple_foo | grep "^ " | tr ' ' '_' | sed 's/.\{31\}//' | awk -F_ '{print $1}' | sort | sed '/^$/D' | uniq -c | cut -f2)
     instr=$(objdump -d ./simple_foo | grep "^ " | tr ' ' '_' | sed 's/.\{31\}//' | awk -F_ '{print $1}' | sort | sed '/^$/D' | uniq | cut -f2 | wc -w)

     #Lógica funciones
    
     address=$(objdump -d ./simple_foo | grep -v "^ " | grep "^0" | sed 's/<.*//')
     numfunc=$(objdump -d ./simple_foo | grep -v "^ " | grep "^0" | sed 's/<.*//' | wc -w)
     func=$(objdump -d ./simple_foo | grep -v "^ " | grep "^0" | sed 's/.\{17\}//') 

     #Pasar los arreglos para manipularlos
 

     #Desplegar información

     echo -e '\t' "Hi, this is the output of the analysis:"
     echo -e '\t''\t' "You have $instr kind of instructions in this object file:"  

 	for elemento in "$nameinstr"
	 do
	   echo -e "$elemento : Executed $numinstr times"
	done

     echo -e '.\t''\t' "You have $numfunc functions:"
	for elemento2 in "$func"
	  do
	    echo -e "$elemento2 : Located at $address"
	done
