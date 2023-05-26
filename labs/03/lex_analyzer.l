%{
#include <stdio.h>
%}

%%

\/\/.* ;
"f"             { printf("floatdcl "); }
"i"             { printf("intdcl "); }
"p"             { printf("print "); }
[a-zA-Z]+       { printf("id "); }
=               { printf("assign "); }
\+              { printf("plus "); }
\-              { printf("minus "); }
\*              { printf("mult "); }
\/              { printf("div "); }
[0-9]+          { printf("inum "); }
[0-9]*\.[0-9]+  { printf("fnum "); }
[\n]            { printf (" \n" ); }
[ \t]+    ;

%%


int main() {
    yylex();
    return 0;
}