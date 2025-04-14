%{
#include <stdio.h>
%}

%option noyywrap

%%
"//".*                      { printf("COMMENT"); }
"p"                         { printf("print "); }
"f"                         { printf("floatdcl "); }
"i"                         { printf("intdcl "); }
[ \t]+                      /* Ignore whitespace */
[a-zA-Z]+[a-zA-Z0-9]*       { printf("id "); }
[0-9]+                      { printf("inum "); }
[0-9]*\.[0-9]+               { printf("fnum "); }
"="                         { printf("assign "); }
"+"                      { printf("plus "); }
"-"                      { printf("minud "); }
"*"                      { printf("times "); }
"/"                      { printf("division "); }
\n+                       { printf("\n"); }

%%
int main() {
    yylex();
    return 0;
}