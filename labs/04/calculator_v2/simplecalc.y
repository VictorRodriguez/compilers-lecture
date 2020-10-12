%{
#include <stdio.h>
%}

%token NAME NUMBER
%%

statement: NAME '=' expression		{printf("= %d\n", $3);}
 | expression 						{printf("= %d\n", $1);}
 ;
expression: expression '+' NUMBER   { $$ = $1 + $3;}
 | expression '-' NUMBER            { $$ = $1 - $3;}
 | NUMBER                           {$$ = $1;}
 ;
