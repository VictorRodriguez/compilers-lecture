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
weather         { return WEATHER; }
name            { return NAME; }
mood            { return MOOD; }
activity        { return ACTIVITY; }
what[' ']is[' ']the[' ']time    { return TIME; }
what[' ']time[' ']is[' ']it     { return TIME; }
what[' ']is[' ']your[' ']name   { return NAME; }
what[' ']is[' ']the[' ']weather { return WEATHER; }
how[' ']is[' ']the[' ']weather  { return WEATHER; }
how[' ']are[' ']you             { return MOOD; }
what[' ']is[' ']your[' ']favorite[' ']activity  { return ACTIVITY; }
tell[' ']me[' ']your[' ']favorite[' ']activity  { return ACTIVITY; }
\n              { return 0; }  /* End of input on newline */
.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}