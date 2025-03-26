%{
#include <stdio.h>
%}

%option noyywrap

%%
[a-zA-Z][a-zA-Z0-9]*    { printf("WORD "); }
[a-zA-Z0-9\/.-]+        { printf("FILENAME "); }
\"                      { printf("QUOTE "); }
\{                      { printf("OBRACE "); }
\}                      { printf("EBRACE "); }
;                       { printf("SEMICOLON "); }
\n                      { printf("\n"); }
[ \t]+                  /* ignore whitespace */
%%

int main() {
    yylex();
    return 0;
}
