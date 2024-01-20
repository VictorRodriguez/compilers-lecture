%{
#include <stdio.h>
%}

%%
\/\/.*\n                /* ignore comments */;
i                       printf("intdcl ");
f                       printf("floatdcl ");
p                       printf("print ");
[a-eghj-oq-z]           printf("id ");
[0-9]{1,8}"."[0-9]{1,5} printf("fnum ");
[0-9]{1,8}              printf("inum ");
"="                     printf("assign ");
"+"                     printf("plus ");
"-"                     printf("minus ");
"*"                     printf("multiplication ");
"/"                     printf("division ");
"%"                     printf("module ");
\n                      printf("\n");
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
