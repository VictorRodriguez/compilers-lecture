%{
#include "y.tab.h"
%}
%%
[0-9]+                  { yylval.dval = atof(yytext); return NUMBER; }
[a-z]+                  { yylval.sval = strdup(yytext); return STRING; }
[ \t] ; 			                        /* ignore whitespace */
\n                      return 0; 		    /* logical EOF */
.                       return yytext[0];
%%
