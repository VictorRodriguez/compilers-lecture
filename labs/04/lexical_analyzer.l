%option noyywrap

%{
#include <stdio.h>
%}

%%
[\t]+ /* Ignore Whitespaces */
\/\/.* {printf("Comment");}
"f" {printf("FloatDeclaration ");}
"i" {printf("IntDeclaration ");}
"p" {printf("Print ");}
"=" {printf("Assignation ");}
"+" {printf("Sum ");}
"-" {printf("Substraction ");}
"*" {printf("Multiplication ");}
"/" {printf("Division ");}
[0-9]+ {printf("Inum ");}
[0-9]+\.[0-9]* {printf("Fnum ");}
[a-zA-Z][a-zA-Z0-9]* {printf("ID ");}
%%

int main(){
yylex();
return 0;
}