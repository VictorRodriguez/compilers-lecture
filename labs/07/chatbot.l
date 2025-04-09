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
jesse           { return COOK; }
cook            { return COOK; }
hru             { return HOWRU; }
how[' ']are[' ']you {return HOWRU; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
what[' ']is[' ']your[' ']name  { return YOURNAME; }
what[' ']is[' ']the[' ']weather  { return WEATHER; }

\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
