%{
#include <stdio.h>
#include <stdlib.h>
%}

%%

f       { printf("floatdcl "); }
i       { printf("intdcl "); }
p       { printf("print "); }
\n      { printf("\nCOMMENT \n"); }
[a-e g-h j-o q-z]+   { printf("id "); }
[0-9]+  { printf("inum "); }
[-+]?[0-9]*[.][0-9]+ { printf("fnum "); }
"="       { printf("assign "); }
"+"      { printf("plus "); }
"*"     {printf("multiplication ");}
"-"     {printf("minus "); }
"/"     {printf("division ");}
"%"     {printf("module ");}
[ \t]+


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


