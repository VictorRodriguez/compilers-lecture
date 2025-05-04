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
name            { return NAME; }
what[' ']is[' ']your[' ']name['?']  { return NAME; }
how[' ']are[' ']you['?']    { return HOW; }
how             { return HOW; }
weather         { return WEATHER; }
what[' ']is[' ']the[' ']weather[' ']today    { return WEATHER; }
how[' ']is[' ']the[' ']weather { return WEATHER; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
