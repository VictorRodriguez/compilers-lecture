%{
#include <stdio.h>
%}

%option noyywrap

%%
\/\/[^\n]*              { printf("COMMENT\n"); }
f                       { printf("floatdcl "); }
i                       { printf("intdcl "); }
p                       { printf("print "); }
[a-zA-Z][a-zA-Z0-9]*    { printf("id "); }
[0-9]+                  { printf("inum "); }
[0-9]+"."[0-9]+         { printf("fnum "); }
\+                      { printf("plus "); }
\=                      { printf("assign "); }
\n                      { printf("\n"); }
[ \t]+                  /* ignore whitespace */
%%

int main() {
    yylex();
    return 0;
}
