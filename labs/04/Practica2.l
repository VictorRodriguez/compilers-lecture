%{
#include <stdio.h>
%}
// Reglas de Expresiones Regulares y Acciones:
%%
\/\/.*                  { printf("COMMENT\n"); }
[0123456789]+           { printf("NUMBER\n"); }
[a-zA-Z][a-zA-Z0-9]*    { printf("WORD\n"); }
int                     { printf("intdcl "); }
[0-9]+                  { printf("inum "); }
[0-9]+"."[0-9]+         { printf("fnum "); }
"="                     { printf("assign "); }
"plus"                  { printf("plus "); }
"print"                 { printf("print "); }
\n                      { /* ignore newlines */ }
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
