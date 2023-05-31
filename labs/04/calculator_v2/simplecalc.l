%{
#include "y.tab.h"
extern int yylval;
%}
%%
[0-9]+				{ yylval = atoi(yytext); return NUMBER; }
[a-z]				{ yylval = yytext[0]; return NAME; }
[ \t] ; 			/* ignore whitespace */
\n return 0; 		/* logical EOF */
. return yytext[0];
%%
