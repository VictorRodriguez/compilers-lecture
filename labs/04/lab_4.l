%{
#include <stdio.h>
%}

%option noyywrap

%%
"//".*                  { printf("COMMENT "); }
i|I                     { printf("intdcl "); }
f|F                     { printf("floatdcl "); }
p|P                     { printf("print "); }
[a-zA-Z][a-zA-Z0-9]*    { printf("id "); }
[0-9]+                  { printf("inum "); }
[0-9]+"."[0-9]+         { printf("fnum "); }
"="                     { printf("assign "); }
"+"                     { printf("plus "); }
"-"                     { printf("minus "); }
"*"                     { printf("times "); }
"/"                     { printf("over "); }
\n                      { printf("\n"); }
[ \t]+                  /* ignore whitespace */
%%

int main() {
    printf("Parsing input:\n");
    yylex();
    return 0;
}
