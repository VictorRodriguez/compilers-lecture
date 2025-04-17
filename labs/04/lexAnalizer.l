%{
#include <stdio.h>
%}

%option noyywrap

%%
[a-zA-Z][a-zA-Z0-9]*    { printf("WORD "); }
[a-zA-Z0-9\/.-]+        { printf("FILENAME "); }
/\.*                    {printf("COMMENT")}
[0-9]+                  {printf("INT")}
[0-9]+"."+[0-9]         {printf("FLOAT")}
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