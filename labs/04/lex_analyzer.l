%{
#include <stdio.h>
%}

%option noyywrap
%%
"//".*                  printf("COMMENT"); 
i                       printf("intdcl ");
f                       printf("floatdcl ");
p                       printf("print ");
[a-eg-hj-oq-z]          printf("id ");
[0-9]+                  printf("inum ");
[0-9]*\.[0-9]{1,5}      printf("fnum ");
\=                      printf("assign ");
\+                      printf("plus ");
\-                      printf("minus ");
\*                      printf("multiplied_by ");
\/                      printf("divided_by ");
\^                      printf("power ");
\*\*                    printf("square ");
\(                      printf("open_parenthesis ");
\)                      printf("close_parenthesis ");
\[                      printf("open_square_bracket ");
\]                      printf("close_square_bracket ");
\{                      printf("open_curly_bracket ");
\}                      printf("close_curly_bracket ");
\n                      printf("\n");
[ \t]+                  /* ignore whitespace */
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
