%{
#include <stdio.h>
%}

%option noyywrap

%%
[a-zA-Z][a-zA-Z0-9]*    printf("WORD ");
[a-zA-Z0-9\/.-]+        printf("FILENAME ");
\"                      printf("QUOTE ");
\{                      printf("OBRACE ");
\}                      printf("EBRACE ");
;                       printf("SEMICOLON ");
^<!DOCTYPE\ html>$      printf("Tipo de documento: html");
^<head>$                printf("Encabezado");
^<title>$               printf("Titulo");
^<p>$                   printf("Parrafo");
^<a>$                   printf("Hipervinculo");
^<img>$                 printf("Imagenes");
^<div>$                 printf("Dividir");
^<button>$              printf("Boton");
\n                      printf("\n");
[ \t]+                  /* ignore whitespace */;
%%

int main() {
    yylex();
    return 0;
}
