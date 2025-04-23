%{
#include <stdio.h>
%}

%option noyywrap

%%
"//"[ a-zA-Z0-9]*       { printf("COMMENT "); }
"f"                     { printf("floatdcl "); }
"i"                     { printf("intdcl "); }
"p"                     { printf("print "); }
[0-9]+                  { printf("intnum "); }
[0-9]?[.][0-9]+         { printf("floatnum "); }
[a-zA-Z0-9]+            { printf("id "); }
"="                     { printf("assign "); }
"+"                     { printf("plus "); }
"-"                     { printf("minus");}
"*"                     { printf("multiplication");}
"\/"                    { printf("division");}

%%

int main() {
    yylex();
    return 0;
}
