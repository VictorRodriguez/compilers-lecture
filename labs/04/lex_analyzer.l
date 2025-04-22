%{
#include <stdio.h>
%}

%option noyywrap

%%

"//".*                 { printf("COMMENT"); }
"f"                    { printf("floatdcl "); }
"i"                    { printf("intdcl "); }
"p"                    { printf("print "); }
"int"                  { printf("intdcl "); }
"="                    { printf("assign "); }
"+"                    { printf("plus "); }
"-"                    { printf("minus "); }
"*"                    { printf("multiply "); }
"/"                    { printf("divide "); }
"("                    { printf("lparen "); }
")"                    { printf("rparen "); }
"print"                { printf("print "); }
[a-zA-Z]+              { printf("id "); }
[0-9]+\.[0-9]+         { printf("fnum "); }
[0-9]+(\.[0-9]+)?      { printf("inum "); }
"\n"                   { printf("\n"); }
[ \t]+                 /* ignore whitespace */
.                      { printf("UNKNOWN_TOKEN "); }
%%

int main() {
    yylex();
    return 0;
}
