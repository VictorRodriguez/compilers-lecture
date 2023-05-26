%{
#include "y.tab.h"
%}

%%


a | 
the		        { return ARTICLE; }

boy | 
girl |
flower		    { return NOUN;}

touches | 
likes |
sees			{ return VERB; }

with            { return PREP; }

[a-z]+ ;
[ \t]  ;	    /* ignore whitespace */
\n     ;

. return yytext[0];

%%
