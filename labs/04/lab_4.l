%{
#include <stdio.h>
%}

%option noyywrap

%%
"//"(.*)"\n"       { printf("COMMENT\n"); }
f                   { printf("floatdcl "); }
i                   { printf("intdcl "); }
p                   { printf("print "); }
[a-zA-Z]+           { printf("id"); }
[0-9]+              { printf("inum"); }
[0-9]+"."[0-9]+     { printf("fnum"); }
"="                 { printf("assign "); }
"+"                 { printf("plus "); }
\n                  { printf("\n"); }
%%

int main() {
    yylex();
    return 0;
}
