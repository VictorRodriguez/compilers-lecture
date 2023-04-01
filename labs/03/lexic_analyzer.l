%{
#include <stdio.h>
%}

%%

"//".*"\n" { /* Ignorar comentarios */ }
"f" { printf("floatdcl "); }
"i" { printf("intdcl "); }
"p" { printf("print "); }
[a-c|e-h|j-z] { printf("id "); }
[0-9]+ { printf("inum "); }
[0-9]+\.[0-9]{0,5} { printf("fnum "); }
[ \t\n] { /* ignorar espacios en blanco */ }
. { fprintf(stderr, "Caracter no reconocido: %s\n", yytext); }

%%

int main() {
    yylex();
    return 0;
}

int yywrap(void) {
    return 1;
}

