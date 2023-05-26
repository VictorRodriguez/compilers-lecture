%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}


%token NAME NUMBER
%%

statement: NAME '=' expression		{printf("= %d\n", $3);}
 | expression 						{printf("= %d\n", $1);}
 ;
expression: expression '+' NUMBER   { $$ = $1 + $3;}
 | expression '-' NUMBER            { $$ = $1 - $3;}
 | expression '*' NUMBER            { $$ = $1 * $3;}
 | '(' expression ')'				{$$ = $2;}
 | NUMBER                           {$$ = $1;}
 ;


