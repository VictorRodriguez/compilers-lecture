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
name            { return NAME; }
weather         { return WEATHER; }
joke           { return JOKE; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
what[' ']is[' ']your[' ']name { return NAME; }
what[' ']is[' ']the[' ']weather { return WEATHER; }
how[' ']are[' ']you { return HOWAREYOU; }
tell[' ']me[' ']a[' ']joke { return JOKE; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
