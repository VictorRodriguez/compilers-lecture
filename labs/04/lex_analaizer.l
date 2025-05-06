%{
#include <stdio.h> 
%}

%option noyywrap

%%
"//".*                      {printf("COMMENT ");}
"f"                         {printf("floatdcl ");}
"i"                         {printf("intdcl ");}
"p"                         {printf("print ");}
"="                         {printf("assign ");}
"+"                         {printf("plus ");}
"-"                         {printf("minus ");}
"/"                         {printf("division ");}
"*"                         {printf("multiplication ");}
[0-9]+                      {printf("inum ");}
[0-9]+"."[0-9]*             {printf("fnum ");}
[a-zA-Z][a-zA-Z0-9]*+       {printf("id ");}
[ \t]+                      /*whitespaces*/
.                           {printf("invalid token ");}
%%

int main(){
    yylex();
    return 0;
}