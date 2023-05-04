%{
#include <stdio.h>
%}

%%
\/\/.* ;
"i"                     printf("intdcl ");
"f"                     printf("floatdcl ");
"p"                     printf("print ");
[a-zA-Z]*               printf("id ");
[0-9]+                  printf("inum ");
[0-9]+.[0-9]+           printf("fnum ");
"="                     printf("assign ");
"+"                     printf("plus ");
"-"                     printf("minus ");
\n                      printf("\n");
[ \t]+                  /* ignore whitespace */;
%%

int main(){
        yylex();
        return 0;
}
