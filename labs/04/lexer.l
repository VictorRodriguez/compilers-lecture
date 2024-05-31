%{
#include <stdio.h>
#include <string.h>

void print_token(const char* token_type);
%}

%%
"//"[^\n]*      { print_token("COMMENT"); }
"float"         { print_token("FLOAT_KEYWORD"); }
"int"           { print_token("INT_KEYWORD"); }
"print"         { print_token("PRINT_KEYWORD"); }
[0-9]+          { print_token("INTEGER"); }
[0-9]+\.[0-9]+  { print_token("FLOAT"); }
[a-zA-Z][a-zA-Z0-9]*  { print_token("IDENTIFIER"); }
"="             { print_token("ASSIGNMENT"); }
"+"             { print_token("ADDITION"); }
"-"             { print_token("SUBTRACTION"); }
"*"             { print_token("MULTIPLICATION"); }
"/"             { print_token("DIVISION"); }
\n              { printf("\n"); }
[ \t]+          ; /* Ignore whitespace */
.               { printf("UNKNOWN TOKEN: %s\n", yytext); }

%%
int yywrap() {
    return 1;
}

void print_token(const char* token_type) {
    printf("%-20s : %s\n", token_type, yytext);
}

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        printf("Error opeing file: %s\n", argv[1]);
        return 1;
    }

    yyin = file;
    yylex();

    fclose(file);
    return 0;
}
