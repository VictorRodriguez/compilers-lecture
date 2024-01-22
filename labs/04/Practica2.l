%{
#include <stdio.h>
%}
// Reglas de Expresiones Regulares y Acciones:
%%
\/\/.*                  { printf("COMENTARIO\n"); }
float                   { printf("DECLARAR_FLOAT "); }
int                     { printf("DECLARAR_INT "); }
[a-zA-Z][a-zA-Z0-9]*    { printf("IDENTIFICADOR "); }
[0-9]+                  { printf("NUMERO_ENTERO "); }
[0-9]+"."[0-9]+         { printf("NUMERO_DECIMAL "); }
"="                     { printf("ASIGNAR "); }
"plus"                  { printf("SUMAR "); }
"print"                 { printf("IMPRIMIR "); }
\n                      { /* ignorar saltos de línea */ }

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
