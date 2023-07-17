%{
#include "y.tab.h"
%}
%%
[0-9]+\.[0-9]{1,5}      { yylval.dval = atof(yytext); return NUMBER; }
[0-9]+                  { yylval.dval = atof(yytext); return NUMBER; }
[a-eg-hj-oq-z]          { yylval.sval = strdup(yytext); return IDENTIFIER; }
[ \t] ; 			                        /* ignore whitespace */
\n                      return 0; 		    /* logical EOF */
.                       return yytext[0];
%%
