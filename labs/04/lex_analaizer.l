%{
#include <stdio.h>
%}

%option noyywrap

%%
"//".*                  { printf("COMMENT"); }
"f"                     { printf("floatdcl "); }
"i"                     { printf("intdcl "); }
"+"                     { printf("plus "); }
"="                     { printf("assign "); }
"-"                     { printf("minus "); }
"*"                     { printf("multiply "); }
"/"                     { printf("div "); }
"p"                     { printf("print "); }
[a-zA-Z]+               { printf("id "); }
[0-9]+                  { printf("inum "); }
[0-9]+"."[0-9]+         { printf("fnum "); }
[ \t]+                  {/* ignore whitespace */}
"\n"                    { printf("\n");}
.                       { /* Ignore any other characters */ }
%%

int main() {
    yylex();
    return 0;
}
