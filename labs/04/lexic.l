%{
#include <stdio.h>
%}

%option noyywrap

%%
"//".*                 { printf("COMMENT\n"); } 
"f"[ \t]+[a-zA-Z_]+    { printf("floatdcl id\n"); }
"i"[ \t]+[a-zA-Z_]+    { printf("intdcl id\n"); }
"p"[ \t]+[a-zA-Z_]+    { printf("print id\n"); }
[a-zA-Z_]+[ \t]*"="[ \t]*[0-9]+                                     { printf("id assign inum\n"); }
[a-zA-Z_]+[ \t]*"="[ \t]*[a-zA-Z_]+[ \t]*"+"[ \t]*[0-9]+"."[0-9]*   { printf("id assign id plus fnum\n"); }
[ \t]+                 {  }
\n                     { }
.                      { printf("UNKNOWN(%c) ", *yytext); }
%%

int main() {
    yylex();
    return 0;
}
