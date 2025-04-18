%{
#include <stdio.h>
%}

%option noyywrap


%%
"//".*                  { printf("COMMENT "); }
"f"                     { printf("floatdcl "); }
"i"                     { printf("intdcl "); }
"p"                     { printf("print "); }
[0-9]*\.[0-9]+          { printf("fnum "); }
[0-9]+                  { printf("inum "); }
"="                     { printf("assign "); }
[a-zA-Z]+[a-zA-Z0-9]*   { printf("id "); }
"+"                     { printf("plus "); }
"-"                     { printf("minus "); }
"*"                     { printf("by "); }
"/"                     { printf("divide "); }
[ \t]+                  /* ignore whitespace */
.                       { printf("unknown token "); }
%%


/**
  * For compiling:
  * lex lexAnalyzer.l
  * gcc lex.yy.c
  * ./a.out < random_code.ac
  */
int main() {
    yylex();
    return 0;
}