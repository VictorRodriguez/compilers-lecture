%{
 
#include <stdio.h>
#include "y.tab.h"
int c;
extern int yylval;
%}
%%
" "       ;
i   {
    yylval = atoi(yytext);
    return(IDCL);
    }
p   {
    yylval = atoi(yytext);
    return(PRINT);
    }
[a-h]|[j-o]|[q-z]     {
            c = yytext[0];
            yylval = c - 'a';
            return(LETTER);
          }
[0-9]     {
            c = yytext[0];
            yylval = c - '0';
            return(DIGIT);
          }
[^a-z0-9\b]    {
                 c = yytext[0];
                 return(c);
               }
