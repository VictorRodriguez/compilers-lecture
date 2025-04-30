%{
#include <stdio.h>
%}

%option noyywrap

letter [a-eg-hj-oq-zA-EG-HJ-OQ-Z]
digit [0-9]
number {digit}+

%%
\/{2}.*                 { printf("COMMENT "); }
f                       { printf("floatdcl "); }
i                       { printf("intdcl "); }
=                       { printf("assign "); }
\+                      { printf("plus "); }
\-                      { printf("minus "); }
\*                      { printf("multiplication "); }
\/                      { printf("division "); }
p                      { printf("print "); }
({letter}{digit}*)+      { printf("id "); }
(0|([1-9]{digit}*))\.(({digit}*[1-9])|0)   { printf("fnum "); }
{number}                  { printf("inum "); }
[ \t]+                  /* ignore whitespace */
%%

int main() {
    yylex();
    return 0;
}
