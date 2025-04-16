%{
#include <stdio.h>
%}

%option noyywrap

%option outfile="tester.c"

%%
"p"                     { printf("PRINT "); }
"i"                     { printf("intdcl "); }
"f"                     { printf("floatdcl "); }
[aA-zZ]+                { printf("id "); }
"//".*                  { printf("COMMENT "); }
"+"                     { printf("PLUS "); }
"*"                     { printf("MULTIPLY "); }
"="                     { printf("EQUAL "); }
"/"                     { printf("DIVIDE "); }
"-"                     { printf("MINUS "); }
[0-9]+                  { printf("INUM "); }
[0-9]+"."[0-9]+         { printf("FNUM "); }
\n                      { printf("\n"); }
[ \t]+                  /* ignore whitespace */
%%

int main() {
    yylex();
    return 0;
}