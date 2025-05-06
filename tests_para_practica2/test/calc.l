%{
#include <stdio.h>
#include <stdlib.h>
float b;
int a;
%}

%%

f       { printf("COMMENT\nfloatdcl id\n"); }
i       { printf("COMMENT\nintdcl id\n"); }
p       { printf("print id\n"); }
\n      { printf("COMMENT\n"); }
[a-z]+  { printf("id "); }
[0-9]+  { printf("inum "); }
=       { printf("assign "); }
\+      { printf("plus "); }

[0-9]+"."[0-9]+ { printf("fnum "); }

%%

int main() {
    yylex();
    return 0;
}
