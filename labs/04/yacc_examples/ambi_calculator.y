%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}


%token NAME NUMBER

%left '*''/'
%left '+''-'

%%

statement: NAME '=' expression ';'		{printf("%c = %d\n", $1,$3);}
 | expression						{printf("= %d\n", $1);}
 ;
expression: expression '+' expression   { $$ = $1 + $3;}
 | expression '*' expression            { $$ = $1 * $3;}
 | expression '/' expression            { $$ = $1 / $3;}
 | expression '-' expression            { $$ = $1 - $3;}
 | NUMBER                           {$$ = $1;}
 ;


