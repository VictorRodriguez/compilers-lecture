%{
#include <stdio.h>
%}

%option noyywrap

%%
"//"[ a-zA-Z0-9]*       { printf("COMMENT "); }
"f"                     { printf("floatdcl "); }
"i"                     { printf("intdcl "); }
"p"                     { printf("print "); }
[0-9]+                  { printf("inum "); }
[0-9]?[.][0-9]+         { printf("fnum "); }
[a-zA-Z0-9]+            { printf("id "); }
"="                     { printf("assign "); }
"+"                     { printf("plus "); }

%%

int main() {
    yylex();
    return 0;
}
