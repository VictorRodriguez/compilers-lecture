%{
#include <stdio.h>
%}

%option noyywrap

%x COMMENT_INLINE

%%
\/\/                    BEGIN COMMENT_INLINE;
<COMMENT_INLINE>[^\n]*  /* INSIDE THE COMMENT*/
<COMMENT_INLINE>\n      {BEGIN(INITIAL);printf("COMMENT\n");}
i                       printf("INTEGER\n");
f                       printf("FLOAT\n");
p                       printf("PRINT_VAR\n");
[a-eg-hj-noq-z]         printf("VAR_NAME\n");
[0-9]+                  printf("INT_NUM\n");
[0-9]*\.[0-9]{1,5}      printf("FOLAT_NUM\n");
\=                      printf("ASSIGN\n");
\+                      printf("ADDITION\n");
\-                      printf("SUBSTRACTION\n");
\*                      printf("MULTIPLICATION\n");
\/                      printf("DIVISION\n");
\^                      printf("POWER\n");
\*\*                    printf("SQUARE\n");
\(                      printf("OPEN_PARENTESIS\n");
\)                      printf("CLOSE_PARENTESIS\n");
\[                      printf("OPEN_SQR_BRACKET\n");
\]                      printf("CLOSE_SQR_BRACKET\n");
\{                      printf("OPEN_CRL_BRACE\n");
\}                      printf("CLOSE_CRL_BRACE\n");
[ \t]+                  /* ignore whitespace */
%%

int main(void) {
    yylex();
    return 0;
}
