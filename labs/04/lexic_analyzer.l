%{
#include <stdio.h>
%}

%option noyywrap

%%
[0-9]+                                  { printf("inum "); }       /* Integer Value: Any number equal or above zero */
[+-]?([0-9]*\.[0-9]{1,5}|[0-9]+)        { printf("fnum "); }       /* Float Value: Any decimal number with a maximum of 5 decimal places */
i                                       { printf("intdc "); }      /* Integer Type: Declares an integer */
f                                       { printf("floatdcl "); }   /* Float Type: Declares an float */
p                                       { printf("print "); }      /* Print: Prints the value of a variable */
[a-eghj-oq-z]                           { printf("id "); }         /* Variables */
=                                       { printf("assign ");}      /* Assign symbol */
\+                                      { printf("plus ");}        /* Plus symbol */
\/\/.*                                  { printf("COMMENT"); }     /* Comment: Any sentence that starts with "//" */
\n                                      { printf("\n"); }
[ \t]+                                  /* ignore whitespace */
%%

int main() {
    yylex();
    return 0;
}
