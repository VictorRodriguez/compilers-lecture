%{
#include <stdio.h>
%}

%option noyywrap

%%
"//".*                  { printf("COMMENT"); }
"i"                     { printf("intdcl "); }
"f"                     { printf("floatdcl "); }
"p"                     { printf("print "); }
"+"                     { printf("plus "); }
"-"                     { printf("minus "); }
"*"                     { printf("times "); }
"/"                     { printf("divide "); }
"="                     { printf("assign "); }
[a-zA-Z]+[a-zA-Z0-9]*   { printf("id "); }
[0-9]*\.[0-9]+          { printf("fnum "); }
[0-9]+                  { printf("inum "); }
%%

int main() 
{
    yylex();
    return 0;
}