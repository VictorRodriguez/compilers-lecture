%{
#include <stdio.h>
%}

%option noyywrap

%%
"//"                    { printf("COMMENT\n"); }
[a-zA-Z_][a-zA-Z0-9]*   { printf("VARIABLE\n"); }
[0-9]+                  { printf("INUM\n"); }
[0-9]+"."[0-9]+         { printf("FNUM\n"); }
"+"                     { printf("PLU\nS"); }
"="                     { printf("EQUAL\n"); }
"*"                     { printf("MULTIPLICATION\n"); }
"/"                     { printf("DIVISON\n"); }
"\n"                    { printf("\n"); }
.                       {/*Ignore other characters*/}

%%

int main() {
    yylex();
    return 0;
}
