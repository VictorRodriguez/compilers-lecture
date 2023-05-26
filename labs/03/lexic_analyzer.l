%{
#include <stdio.h>
%}

/* Definición de tokens */
%%
"f"    { printf("floatdc\n"); }
"i"    { printf("intdc\n"); }
"p"    { printf("Print\n"); }
[a-hj-oq-z][a-z]*    { printf("id %s\n", yytext); }
[0-9]+    { printf("int %s\n", yytext); }
[0-9]+\.[0-9]{1,5}    { printf("float %s\n", yytext); }
[ \t\n]    ; /* Ignorar espacios en blanco y saltos de línea */
%%
 
int main() {
    yylex();
    return 0;
}

