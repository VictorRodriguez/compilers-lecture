%{
#include <stdio.h>
%}

%%
\/\/.*\n*               /* ignore comments */;
f                       printf("floatDec ");
i                       printf("intDec ");
p                       printf("print ");
[a-zA-Z]                printf("var ");
[+-]?[0-9]*\.[0-9]+     printf("float ");
=                       printf("assign ");
[+-]?[0-9]+             printf("number ");  
[+*\/-]                 printf("operator ");
^(?:[\t ]*(?:\r?\n|\r))+ /* ignore blanklines */;
[ \t]+                  /* ignore whitespace */;
%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE* inputFile = fopen(argv[1], "r");
    if (!inputFile) {
        perror("Error opening file");
        return 1;
    }

    yyin = inputFile;
    yylex();

    fclose(inputFile);
    return 0;
}