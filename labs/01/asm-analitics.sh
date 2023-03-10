#!/usr/bin/bash
# Lee si manda un parametro
if test $# -eq 1
then
        # $1 variable para el parametro
        cat $1 | cut -c -32 --complement  | tr ' ' @ |  cut -f1 -d@ | egrep -v : | sed '/^$/d' | tail -n +2 | sort | uniq -c | tr ' ' % | t> % | tr -s % | cut -c -1 --complement > Instrucciones

        # inst variable de numero de instrucciones
        inst=`cat Instrucciones | wc -l`
        echo -e "Hi, this is the output of the analysis: \n"
        echo -e "You have $inst kind of instructions in this object file: \n"

        # instrucciones
        for word in `cat Instrucciones`
        do
                # numero de instruccion
                inst2=`echo $word | cut -f1 -d%`

                # nombre de la instruccion
                n_inst=`echo $word | cut -f2 -d%`
                echo -e "\t$n_inst\t: Executed $inst2 times \n"
        done

        # funciones
        cat $1 | egrep '>:' | tr -d [:blank:],'>:' > Funciones
        fun=`cat Funciones | wc -l`
        echo -e "You have $fun functions: \n"

        for word2 in `cat Funciones`
        do
                # numero de funcion
                fun2=`echo $word2 | cut -f1 -d'<'`

                # nombre de la funcion
                n_fun=`echo $word2 | cut -f2 -d'<'`
                echo -e "\t$n_fun\t: Located at $fun2 address \n"
        done
else
        echo 'No hay parametros intenta otra vez. :c'
fi
