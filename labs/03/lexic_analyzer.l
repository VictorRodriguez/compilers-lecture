%{
#include <stdio.h>
%}

%%

"if"    { printf("PALABRA_RESERVADA: %s\n", yytext); }
"f"     { printf("PALABRA_RESERVADA: %s\n", yytext); }
"n"     { printf("PALABRA_RESERVADA: %s\n", yytext); }
"r"     { printf("PALABRA_RESERVADA: %s\n", yytext); }
"p"     { printf("PALABRA_RESERVADA: %s\n", yytext); }
"="     { printf("OPERADOR_ASIGNACION\n"); }
"+"     { printf("OPERADOR_SUMA\n"); }
[0-9]+  { printf("NUMERO_ENTERO: %s\n", yytext); }
[a-zA-Z][a-zA-Z0-9]* { printf("IDENTIFICADOR: %s\n", yytext); }
" "     { /* ignorar espacios en blanco */ }
\n      { /* ignorar saltos de línea */ }
.       { printf("CARACTER_INVALIDO: %s\n", yytext); }

%%

int main(void)
{
    yylex();
    return 0;
}

