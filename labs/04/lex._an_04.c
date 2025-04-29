%{
#include <stdio.h>
%}
    
%option noyywrap
    
%%
    
\/{2}*              { printf("COMMENT "); }
"f"                 { printf("floatdcl "); }
"i"                 { printf("intdcl "); }
"p"                 { printf("print "); }
[a-zA-Z]            { printf("id"); }
"="                 { printf("assign "); }
"+"                 { printf("plus "); }
[0-9]+\.[0-9]+      { printf("fnum "); }
[0-9]+              { printf("inum "); }
    

    
%%
    
int main() {
    yylex();
    return 0;
}
    