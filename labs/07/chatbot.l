%{
#include "y.tab.h"
%}

%%
hola         { return HELLO; }
hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }

adios         { return GOODBYE; }
goodbye         { return GOODBYE; }
bye             { return GOODBYE; }

time            { return TIME; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }

what[' ']is[' ']your[' ']name  { return NAME; }
give[' ']me[' ']your[' ']name  { return NAME; }
do[' ']you[' ']have[' ']a[' ']name  { return NAME; }

what[' ']is[' ']the[' ']weather  { return WEATHER; }
how[' ']is[' ']the[' ']weather  { return WEATHER; }

how[' ']are[' ']you  { return HOWAREYOU; }
how[' ']you[' ']doing  { return HOWAREYOU; }

what[' ']is[' ']your[' ']favorite[' ']color  { return COLOR; }

how[' ']old[' ']are[' ']you  { return AGE; }

what[' ']is[' ']your[' ']hobby  { return HOBBY; }

\n              { return 0; } /* End of input on newline */

.               { return yytext[0]; }

%%
int yywrap() {
    return 1;
}