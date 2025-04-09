%{
#include <stdio.h>
%}

%option noyywrap

%%
"//".*                 { printf("COMMENT\n"); }
"f"[ \t]+[a-zA-Z_]+    { printf("floatdcl %s\n", yytext); }
"i"[ \t]+[a-zA-Z_]+    { printf("intdcl %s\n", yytext); }
"p"[ \t]+[a-zA-Z_]+    { printf("print %s\n", yytext); }
[a-zA-Z_]+[ \t]"="[ \t][0-9]+                                     { printf("id assign inum\n"); }
[a-zA-Z_]+[ \t]"="[ \t][a-zA-Z_]+[ \t]"+"[ \t][0-9]+"."[0-9]*   { printf("id assign id plus fnum\n"); }
[ \t]+                   { /* ignore spaces */ }      
[\n]                     { /* ignore new lines */ }      
.                        { printf("UNKNOWN(%s) ", yytext); } 
%%

int main() {
    yylex();
    return 0;
}
