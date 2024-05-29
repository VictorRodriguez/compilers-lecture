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
tree            { return TREE; }
weather         { return WEATHER; }
mood            { return MOOD; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
what[' ']is[' ']your[' ']name { return NAME; }
print[' ']a[' ']tree { return TREE; }
what[' ']is[' ']the[' ']weather { return WEATHER; }
how[' ']are[' ']you { return MOOD; }

\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}