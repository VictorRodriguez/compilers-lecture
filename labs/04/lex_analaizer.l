%{
#include <stdio.h>
%}

%option noyywrap

/*Gerardo Cortes Leal*/
/*A01639946*/

%%
"//".*                 { printf("COMMENT "); }
f                      { printf("floatdcl "); }
i                      { printf("intdcl "); }
p                      { printf("print "); }
[a-zA-Z][a-zA-Z0-9]*   { printf("id "); }
[0-9]+                 { printf("inum "); }
[0-9]+"."[0-9]+        { printf("fnum "); }
"="                    { printf("assign "); }
"+"                    { printf("plus "); }
"*"                    { printf("multiply "); }
"-"                    { printf("minus "); }
"/"                    { printf("divide "); }
[ \t]+                 /* ignore whitespace */
%%

int main() {
    yylex();
    return 0;
}