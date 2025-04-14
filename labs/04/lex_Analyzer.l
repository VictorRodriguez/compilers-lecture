%{
#include <stdio.h> 
%}

%option noyywrap

%%
"//".*                 { printf("COMMENT"); }
"f"                    { printf("floatdcl "); }
"i"                    { printf("intdcl "); }

"p"                    { printf("print "); }
"="                    { printf("assign "); }

"+"                    { printf("plus "); }
"-"                    { printf("minus "); }
"*"                    { printf("multiply "); }
"/"                    { printf("divide "); }
"%"                    { printf("module "); }

"("                    { printf("lparen "); }
")"                    { printf("rparen "); }
"["                    { printf("lbracket "); }
"]"                    { printf("rbracket "); }

[a-zA-Z][a-zA-Z0-9]*+  { printf("id "); }

[0-9]+"."[0-9]*        { printf("fnum "); }
[0-9]+                 { printf("inum "); }

"\n"                   { printf("\n"); }
[ \t]+                 /* ignore whitespaces */
.                      { printf("UNKNOWN_TOKEN "); }
%%

int main(){
    yylex();
    return 0;
}