%{
#include "y.tab.h"
%}

%%


the     | 
a             { return ARTICLE; }

girl    | 
boy     |
flower          { return NOUN;}

touches | 
likes   |
sees            { return VERB; }

with            { return PREP; }

[a-z]+      ;
[ \t\n]     ;        /* ignore whitespace */

. return yytext[0];

%%