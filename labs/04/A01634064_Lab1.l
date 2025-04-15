%{
#include <stdio.h>
%}

%option noyywrap

%%
"//".*                   { printf("COMMENT\n"); }
"f"                     { printf("floatdcl "); } 
"i"                     { printf("intdcl "); }
"p"                     { printf("print "); }
[a-zA-Z][a-zA-Z0-9]*    { printf("id "); }
[0-9]+"."[0-9]*         { printf("fnum "); }
[0-9]+                  { printf("inum "); }
"+"                     { printf("plus "); }
"="                     { printf("assign "); }
[ \t\n]+                 /* ignore whitespace */
%%

int main() {
    yylex();
    return 0;
}
