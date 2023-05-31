%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}

%union {
 double dval;
 char *sval;
 }


%token <dval> NUMBER
%token <sval> STRING

%type <dval> expression
%%

statement: STRING '=' expression		{printf("%s = %f\n", $1,$3);}
 ;
expression: expression '+' NUMBER   { $$ = $1 + $3;}
 | expression '-' NUMBER            { $$ = $1 - $3;}
 | expression '*' NUMBER            { $$ = $1 * $3;}
 | '(' expression ')'				{$$ = $2;}
 | NUMBER                           {$$ = $1;}
 ;
