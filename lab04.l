%{
#include <stdio.h>
%}

%option noyywrap

%%
p                   { printf("print "); }
f                       { printf("floatdcl "); }
i                       { printf("intdcl "); }
\/\/.*                  { printf("COMMENT "); }
[0-9]+\.[0-9]+          { printf("fnum "); }
[0-9]+                  { printf("inum "); }
\+                      { printf("plus "); }
\-                      { printf("minus "); }
\*                      { printf("times "); }
\/                      { printf("divide "); }
=                       { printf("assign "); }
[a-zA-Z][a-zA-Z0-9\/.-]* { printf("id "); }
\n                      { printf("\n"); }
[ \t]+                  /* ignore whitespace */
%%

int main() {
    yylex();
    return 0;
}
