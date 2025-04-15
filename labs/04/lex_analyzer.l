%{
#include <stdio.h>
%}

%%
"//".*                  { printf("COMMENT"); }
i                       { printf("intdcl"); }
f                       { printf("floatdcl"); }
p                       { printf("print"); }
=                       { printf("assign"); }
\+                      { printf("plus"); }
\-                      { printf("sub"); }
\*                      { printf("mul"); }
\/                      { printf("div"); }
[a-zA-Z_]+[a-zA-Z0-9_]* { printf("id"); }
-?[0-9]+                { printf("inum"); }
-?[0-9]+\.[0-9]+        { printf("fnum"); }
^[\t\n ]*\n				{ printf(""); } /* Ignore blank lines */
[^\t\n ]                  { /* ignore all characters except whitespace, tab, and newline */ }
%%

int main() {
    yylex();
    return 0;
}
