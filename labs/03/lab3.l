%{
#include <stdio.h>
%}

%option noyywrap

%%
"f"                     { printf("floatdcl "); }
"i"                     { printf("intdcl "); }
"p"                     { printf("print "); }
[a-zA-Z]                { printf("id "); }
"+"                     { printf("plus "); }
"-"                     { printf("minus "); }
"="                     { printf("assign "); }
[0-9]+                  { printf("inum "); }
[0-9]*\.[0-9]+          { printf("fnum "); }
"//".*$                 { printf("Comment "); }
\n                      { printf("\n"); }
[ \t]+                  /* ignorar los espacios */
%%

int main() {
    yylex();
    return 0; 
}
           
