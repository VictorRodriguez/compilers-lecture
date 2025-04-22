/* Created by Hedguhar Domínguez on 21/01/2024. */

%{
#include <stdio.h>
%}

%%
"//".*                  { printf("COMMENT"); }
"f"                     { printf("floatdcl"); }
"i"                     { printf("intdcl"); }
"p"                     { printf("print"); }
"="                     { printf("assign"); }
"+"                     { printf("plus"); }
"-"                     { printf("minus"); }
"*"                     { printf("mult"); }
"/"                     { printf("div"); }
[0-9]+"."[0-9]+         { printf("fnum"); }
[0-9]+                  { printf("inum"); }
[a-zA-Z][a-zA-Z0-9]*    { printf("id"); }
[ \t]                   { printf(" "); }
\n                      { printf("\n"); }
.                       { /* Ignore other characters */ }
%%

int main(int argc, char **argv) {
    FILE *fd;

    if (argc == 2)
    {
        if (!(fd = fopen(argv[1], "r")))
        {
            perror("Error: ");
            return (-1);
        }
        yyset_in(fd);
        yylex();
        fclose(fd);
    }
    else {
        printf("Usage: a.out filename\n");
    }
    return (0);
}
