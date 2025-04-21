%{
#include <stdio.h>
%}
      
%option noyywrap
      
%%
[ \t]                   printf("");
\/\/.*                  printf("COMMENT "); 
i                       printf("intdcl ");
f                       printf("floatdcl ");
p                       printf("PRINT ");
[0-9]+\.[0-9]+          printf("fnum ");
[0-9]+                  printf("inum ");
[_a-zA-Z][_a-zA-Z0-9]*  printf("id ");
\=                      printf("assign ");
\+                      printf("plus ");
\-                      printf("minus ");
\/                      printf("division ");
\*                      printf("multiplication ");
.                       printf("UNKNOWN CHARACTER: %s\n", yytext);
%%
    
int main(){
    yylex();
    return 0;
}