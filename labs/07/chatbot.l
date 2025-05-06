%{
#include "y.tab.h"
%}

%%

hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }
greetings       { return HELLO; }
howdy           { return HELLO; }
salutations     { return HELLO; }

goodbye         { return GOODBYE; }
bye             { return GOODBYE; }
farewell        { return GOODBYE; }
see[' ']you[' ']later { return GOODBYE; }
take[' ']care    { return GOODBYE; }
catch[' ']you[' ']later { return GOODBYE; }

time            { return TIME; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
current[' ']time { return TIME; }
time[' ']now     { return TIME; }
what[' ']is[' ']the[' ']current[' ']time { return TIME; }

weather         { return WEATHER; }
what[' ']is[' ']the[' ']weather { return WEATHER; }
how[' ']is[' ']the[' ']weather { return WEATHER; }
what[' ']is[' ']the[' ']current[' ']weather { return WEATHER; }

mood            { return MOOD; }
how[' ']are[' ']you { return MOOD; }
what[' ']is[' ']your[' ']mood { return MOOD; }
how[' ']do[' ']you[' ']feel { return MOOD; }
tell[' ']me[' ']your[' ']mood { return MOOD; }

name            { return NAME; }
what[' ']is[' ']your[' ']name { return NAME; }
who[' ']are[' ']you { return NAME; }
tell[' ']me[' ']your[' ']name { return NAME; }

\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}