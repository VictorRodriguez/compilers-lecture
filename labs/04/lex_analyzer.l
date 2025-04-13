%{
#include <stdio.h>
%}

DIGIT    [0-9]
ID       [a-zA-Z_][a-zA-Z0-9_]*

%%

"//".*                 { printf("COMMENT"); }
f                      { printf("floatdcl"); }
i                      { printf("intdcl"); }
p                      { printf("print"); }
{ID}                   { printf("id");}
=                      { printf("assign"); } 
\+                     { printf("plus"); }
\-                     { printf("minus"); }
\*                     { printf("mult"); }
\/                     { printf("div"); }
{DIGIT}+               { printf("inum"); }
{DIGIT}+"."{DIGIT}*    { printf("fnum"); }

%%

int main(int argc, char *argv[]) {
    ++argv, --argc; 
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;

    yylex();
}
