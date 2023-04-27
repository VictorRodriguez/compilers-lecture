%{
#include <stdio.h>
%}

%%

float                                               { printf("FLOAT"); }
int                                                 { printf("INT"); }
print                                               { printf("PRINT"); }
=                                                   { printf("ASSIGN"); }
\+                                                  { printf("PLUS"); }
\-                                                  { printf("MINUS"); }
\*                                                  { printf("MULTIPLY"); }
\/                                                  { printf("DIVIDE"); }
[a-zA-Z_][a-zA-Z0-9_]*                               { printf("ID"); }
[0-9]+                                              { printf("INUM"); }
[0-9]*\.[0-9]+([eE][-+]?[0-9]+)?                    { printf("FNUM"); }
\/\/[^\n]*                                           { /* Ignore single-line comments */ }
\/\([^]|[\r\n]|(\+([^/]|[\r\n])))\+\/         { /* Ignore multi-line comments */ }
[ \t]+                                              { /* Ignore white spaces */ }
\n                                                  { printf("NEWLINE"); }

%%

int main(int argc, char* argv[]) {
    FILE *fp;
    int ret;

    if (argc < 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        printf("Error: Cannot open file %s\n", argv[1]);
        return 1;
    }

    yyin = fp;
    ret = yylex();
    while (ret) {
        ret = yylex();
    }

    fclose(fp);
    return 0;
}
