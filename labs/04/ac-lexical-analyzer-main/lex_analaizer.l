%{
#include <stdio.h>
#include <string.h>

extern FILE *yyin;
%}

/* Definitions */
ID      [a-eg-hj-oq-z]
DIGIT   [0-9]
INT     {DIGIT}+
FLOAT   {DIGIT}+"."{DIGIT}{1,5}

%%
"//".*                  { printf("COMMENT\n"); }
"f"                     { printf("floatdcl\n"); }
"i"                     { printf("intdcl\n"); }
"p"                     { printf("print\n"); }
"="                     { printf("assign\n"); }
"+"                     { printf("plus\n"); }
{FLOAT}                 { printf("fnum\n"); }
{INT}                   { printf("inum\n"); }
{ID}                    { printf("id\n"); }
[ \t\r\n]+              { /* Ignore whitespace */ }
.                       { printf("UNKNOWN TOKEN: %s\n", yytext); }
%%

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error opening input file");
            return 1;
        }
    }
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
