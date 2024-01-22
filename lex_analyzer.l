%{
#include <stdio.h>
%}

%%

"//".*           { printf("COMMENT\n"); }
[f]              { printf("floatdcl id\n"); }
[i]              { printf("intdcl id\n"); }
[a-z]            { printf("id\n"); }
[0-9]+           { printf("inum\n"); }
[0-9]+"."[0-9]+  { printf("fnum\n"); }
"="              { printf("assign\n"); }
"+"              { printf("plus\n"); }
"print"          { printf("print "); }
\n               { /* ignore newlines */ }
.                { /* ignore other characters */ }

%%

int main() {
    yylex();
    return 0;
}

