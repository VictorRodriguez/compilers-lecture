%{
#include <stdio.h>
%}

%option noyywrap

%%
\/\/[^\n]*              printf("COMMENT\n");

i                       printf("intdcl\n");
f                       printf("floatdcl\n");
p                       printf("print\n");

[a-eg-hj-oq-z]          printf("id\n");
[0-9]+                  printf("inum\n");
[0-9]*\.[0-9]           printf("fnum\n");

\=                      printf("assign\n");
\+                      printf("plus\n");
\-                      printf("substraction\n");
\*                      printf("multiplication\n");
\/                      printf("division\n");

[ \t]+
\n
.
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