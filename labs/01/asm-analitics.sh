#!/usr/bin/bash

if test $# -eq 1
then
        cat $1 | cut -c -32 --complement | tr ' ' @ | cut -f1 -d@ | egrep -v : | sed '/^$/d' | tail -n +2 | sort | uniq -c | tr ' ' % | t>

echo 'hi, this is done :)'
        instructions=`cat Instrucciones | wc -l`
echo -e "Hi, this is the output of the analysis: \n"
echo -e "You have $inst kind of instructions in this object file: \n"

echo 'mistake'
        for word in `cat Instrucciones`
        do
                instructions_2=`echo $word | cut -f1 -d%`
                instructions_number=`echo $word | cut -f2 -d%`
                echo -e "\t$n_inst\t: Executed $instructions_2 times \n"
        done
cat $1 | egrep '>:' | tr -d [:blank:],'>' > Funciones
functions=`cat Funciones | wc -l`
echo -e "You have $functions functions: \n"

        for word2 in `cat Funciones`
        do
                functions_2=`echo $word2 | cut -f1 -d'<'`
                functions_number=`echo $word2 | cut -f2 -d'<'`
                echo -e "\t$functions_number\n: Located at $functions_2 address \n"
        done
else
        echo 'Error: there is no parameters'
fi