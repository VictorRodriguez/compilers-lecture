%{
#include "y.tab.h"
%}

%%

hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }
goodbye         { return GOODBYE; }
bye             { return GOODBYE; }
time            { return TIME; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
throw[' ']a[' ']dice { return DICE; }
dice            { return DICE; }
name            { return NAME; }
what[' ']is[' ']your[' ']name  { return NAME; }
rock[' ']paper[' ']scissors  { return GAME; }
rps             { return GAME; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}