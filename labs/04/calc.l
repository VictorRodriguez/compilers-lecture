%{
    #include <stdio.h>
%}

%option noyywrap

%%
"i"                         { printf("intdcl ") ; }
"f"                         { printf("floatdcl ") ; }
"p"                         { printf("print ") ; }
"//".*                      { printf("COMMENT ") ; }
"+"                         { printf("plus ") ; }
"-"                         { printf("minus ") ; }
"*"                         { printf("times ") ; }
"/"                         { printf("division ") ; }
[0-9]+                      { printf("inum ") ; }
[0-9]*\.[0-9]+               { printf("fnum ") ; }
"="                         { printf("assign ") ; }
[a-zA-Z]+[a-zA-Z0-9]*       { printf("id ") ; }
[ \t]+                      // Ignorar espacio en blanco
%%


int main() {
    yylex();
    return 0;
}