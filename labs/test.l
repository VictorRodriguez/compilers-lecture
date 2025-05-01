/*
Pactice 2 - A00837812 - Joselyn Reyna Contreras
*/

%{
#include <stdio.h>
%}

%%

"f"                     { printf("DeclareFloat "); }
"i"                     { printf("DeclareInt "); }
"p"                     { printf("Print "); }


[a-zA-Z][a-zA-Z0-9]*    { printf("Id "); }


[0-9]+                  { printf("IntegerNumber "); }
[0-9]+\.[0-9]+          { printf("DecimalNumber "); }

"+"                     { printf("Sum "); }
"-"                     { printf("Minus "); }
"*"                     { printf("Times "); }
"/"                     { printf("Division "); }
"="                     { printf("Asign "); }



\/\/.*                  { printf("Comment\n"); }
\n                      { /* ignorar saltos de línea */ }
[\t ]                   { /* ignorar tabs y espacios */ }


%%

int main(int argc, char **argv) {
    FILE    *fd;

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
    else
        printf("Usage: a.out filename\n");
    return (0);
}
