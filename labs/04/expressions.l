%{
#include <stdio.h>
%}

%%
"//".*                                      printf("COMMENT ");
-?[0-9]+\.[0-9]*                            printf("FLOAT ");
-?[0-9]+                                    printf("INT ");
[a-eg-hj-oq-z]                              printf("IDENTIFIER ");
"f"                                         printf("FLOATDCL ");
"i"                                         printf("INTDCL ");
"p"                                         printf("PRINT ");
"+"                                         printf("PLUS ");
"-"                                         printf("MINUS ");
"*"                                         printf("TIMES ");
"/"                                         printf("DIVIDE ");
"="                                         printf("ASSIGN ");
" "|\t|\n|\r                                printf("");
.                                           printf("ERROR ");
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}