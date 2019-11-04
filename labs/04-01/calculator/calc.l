%{
#include "y.tab.h"
extern int yylval;
%}
%%
[0-9]+                         {yylval = atoi(yytext); return NUMBER;}
[a-hj-oq-z]                    {yylval = yytext[0] - 'a'; return ID;}
[+-/*=pi]                      return yytext[0];
"//".*\n ;                     /* do nothing */
[ \t] ;                        /* do nothing */
\n ;                           /* do nothing */
%%