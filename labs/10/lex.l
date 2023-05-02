%{
#include "y.tab.h"
%}

%%

a |
the                     { return ARTICLE; }

boy |
girl |
flower              { return NOUN;}

touches |
likes |
sees                    { return VERB; }

with            { return PREP; }

[a-z]+                  { return 0; }
[ \t]                   { /* ignore whitespace */ }
\n                      { return 0; }
.                       { return yytext[0]; }

%%
