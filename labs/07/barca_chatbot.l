%{
#include "y.tab.h"
%}

%%

what[' ']is[' ']FC[' ']Barcelona            { return WHAT_IS_FC_BARCELONA; }
who[' ']is[' ']the[' ']coach[' ']of[' ']FC[' ']Barcelona { return WHO_IS_COACH; }
who[' ']is[' ']the[' ']captain[' ']of[' ']FC[' ']Barcelona { return WHO_IS_CAPTAIN; }
how[' ']many[' ']La[' ']Liga[' ']titles[' ']has[' ']FC[' ']Barcelona[' ']won { return HOW_MANY_TITLES; }
how[' ']many[' ']UEFA[' ']Champions[' ']League[' ']titles[' ']has[' ']FC[' ']Barcelona[' ']won { return HOW_MANY_UCL_TITLES; }
what[' ']are[' ']the[' ']colors[' ']of[' ']FC[' ']Barcelona { return COLORS; }
\n                         { return 0; }

.                          { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
