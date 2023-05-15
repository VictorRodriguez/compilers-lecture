%{
#include "y.tab.h"
extern int yylval;
%}

%%
the|a				{ return ARTICLE; }
boy|girl|flower		{ return NOUN; }
touches|sees|likes		{ return VERB; }
with 

[ \t] ; 			/* ignore whitespace */
\n return 0; 		/* logical EOF */
. return yytext[0];



