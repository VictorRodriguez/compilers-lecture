%{
#include <stdio.h>
%}

%option noyywrap

%%
"//".*                  { printf("COMMENT "); }
f                       { printf("floatdcl "); }
i                       { printf("intdcl "); }
p                       { printf("print "); }
=                       { printf("assign "); }
\+                      { printf("plus "); }
[a-zA-Z]+               { printf("id "); }
[0-9]+                  { printf("inum "); }
[0-9]*\.[0-9]+          { printf("fnum "); }
\n                      { printf("\n"); }
[ \t]+                  /* ignore whitespace */
%%

int main() {
    yylex();
    return 0;
}