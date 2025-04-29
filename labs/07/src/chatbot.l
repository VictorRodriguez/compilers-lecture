%{
#include "y.tab.h"
%}

%%

hello                                   { return HELLO; }
hi                                      { return HELLO; }
hey                                     { return HELLO; }
goodbye                                 { return GOODBYE; }
bye                                     { return GOODBYE; }
name                                    { return NAME; }
time                                    { return TIME; }
weather                                 { return WEATHER; }
dice                                    { return DICE; }
what[' ']is[' ']your[' ']name['\?']?    { return NAME; }
what[' ']is[' ']the[' ']time['\?']?     { return TIME; }
what[' ']time[' ']is[' ']it['\?']?      { return TIME; }
how[' ']is[' ']the[' ']weather['\?']?   { return WEATHER; }
roll[' ']a[' ']dice                     { return DICE; }
should[' ']i[' ']do[' ']this['\?']?     { return ADVICE; }
should[' ']i['\?']?                     { return ADVICE; }
\n                                      { return 0; }  /* End of input on newline */

.               { return yytext[0]; } 

%%

int yywrap() {
    return 1;
}
