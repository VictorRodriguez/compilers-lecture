%{
#include <stdio.h>
#include <stdlib.h>
%}

DIGIT [0-9]
STRING [a-zA-Z][a-zA-Z0-9]*

%%
{DIGIT}                  { printf("TOKEN: DIGIT\n"); }
{DIGIT}+                 { printf("TOKEN: NUMBER\n"); }
{DIGIT}+"."{DIGIT}*      { printf("TOKEN: FLOAT\n"); }
{STRING}                 { printf("TOKEN: STRING\n"); }
"//".*                   { printf("TOKEN: COMMENT \n");}
[+]                      { printf("TOKEN: ADDITION\n"); }
[-]                      { printf("TOKEN: SUBTRACTION\n"); }
[*]                      { printf("TOKEN: MULTIPLICATION\n"); }
[/]                      { printf("TOKEN: DIVISION\n"); }
[=]                      { printf("TOKEN: ASSIGNMENT\n"); }
;                        { printf("TOKEN: SEMICOLON\n"); }
\n                       { printf("TOKEN: NEWLINE\n"); }
%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("File Not Found");
        return 1;
    }

    yyin = file;

    yylex();

    fclose(file);
    return 0;
}

