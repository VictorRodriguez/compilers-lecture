/* Actividad 3.1: Analizador Léxico | Lab 04 */
/* Alumno: León Emiliano García Pérez [A00573074] */
/* Fecha de Entrega: Martes 7 de Mayo de 2024 */

%{
#include <stdio.h>
%}

%option noyywrap

%s ID

%%

"//".*[\n]*                            { printf("COMMENT\n"); }

"f"                                    { printf("floatdcl "); BEGIN(ID); }
"i"                                    { printf("intdcl "); BEGIN(ID); }
"p"                                    { printf("print "); BEGIN(ID); }

"**"                                   { printf("poweredBy "); }
"*"                                    { printf("multipliedBy "); }
"="                                    { printf("assign "); }
"+"                                    { printf("plus "); }
"-"                                    { printf("minus "); }
"/"                                    { printf("dividedBy "); }
";"                                    { printf("semicolon "); }
"("                                    { printf("roundBracketOpen "); }
")"                                    { printf("roundBracketClose "); }
"{"                                    { printf("curlyBracketOpen "); }
"}"                                    { printf("curlyBracketClose "); }
"["                                    { printf("squareBracketOpen "); }
"]"                                    { printf("squareBracketClose "); }

-?[0-9]+\.[0-9]+                       { printf("fnum "); }
-?[0-9]+                               { printf("inum "); }

\'[a-zA-Z]+\'                          { printf("char "); }
\"[a-zA-Z]+\"                          { printf("string "); }

[a-zA-Z0-9_\-\.]+\.[a-zA-Z]+[0-9]?     { printf("file "); }

<ID>[a-zA-Z]+[a-zA-Z0-9]* {
    printf("id ");
    BEGIN(INITIAL);
}

[a-zA-Z]+[a-zA-Z0-9_\-]*               { printf("id "); }

[\n]*                                  { printf("\n"); }
[ \t]+ ;
.|\n ECHO;


%%

int main(int argc, char **argv) {
    FILE *fd;

    if (argc == 2) {
        if (!(fd = fopen(argv[1], "r"))) {
            perror("Error: ");
            return (-1);
        }
        yyset_in(fd);
        yylex();
        fclose(fd);
    } else {
        printf("Usage: a.out filename\n");
    }
    return 0;
}