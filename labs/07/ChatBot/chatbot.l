%{
#include "y.tab.h"
%}

%%

hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }
goodbye         { return GOODBYE; }
bye             { return GOODBYE; }
name            { return NAME; }
time            { return TIME; }
zelda           { return RECOMMEND_GAME; }

what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
what[' ']is[' ']your[' ']name { return NAME; }
how[' ']are[' ']you                { return HOWAREYOU; }
how[' ']are[' ']you[' ']doing      { return HOWAREYOU; }
can[' ']you[' ']recommend[' ']a[' ']zelda[' ']game { return RECOMMEND_GAME; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}