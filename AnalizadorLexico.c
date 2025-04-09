%{
#include <stdio.h>
%}

%option noyywrap

%%
f|float                 { printf("floatdcl "); }
i|integer               { printf("intdcl "); }
p|print		        { printf("print "); }
=			{ printf("assign "); }
+			{ printf("plus "); }
[0-9]+.[0-9]+		{ printf("fnum "); }
[0-9]+			{ printf("num "); }
[a-zA-Z][a-zA-Z0-9]*    { printf("id "); }
[a-zA-Z0-9.-]+          { printf("FILENAME "); }
\"                      { printf("QUOTE "); }
\{                      { printf("OBRACE "); }
\}                      { printf("EBRACE "); }
;                       { printf("SEMICOLON "); }
\n                      { printf("\n"); }
\/\/.*                  { printf("COMMENT"); }
[ \t]+                  /* ignore whitespace */
%%

int main() {
    yylex();
    return 0;
}