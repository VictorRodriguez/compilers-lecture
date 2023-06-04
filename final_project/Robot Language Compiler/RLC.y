%{
#include <stdio.h>
%}

%token PLEASE AND ACTION DIRECTION NUMBER UNIT

%%

program : magic inslist
        ;

inslist :  instruction
                 |  inslist conjunction instruction
                 ;

instruction :  movins
            ;

magic : PLEASE
                    ;

conjunction : AND
                 ;

movins : ACTION DIRECTION NUMBER UNIT 
                 ;
%%
