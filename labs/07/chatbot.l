%{
#include "y.tab.h"
%}

%%

hello|hi|hey                      { return HELLO; }
goodbye|bye|see[' ']you[' ']later { return GOODBYE; }
time                              { return TIME; }
what[' ']is[' ']the[' ']time      { return TIME; }
what[' ']time[' ']is[' ']it       { return TIME; }
what[' ']is[' ']your[' ']name     { return NAME; }
what[' ']is[' ']the[' ']weather   { return WEATHER; }
how[' ']are[' ']you               { return HOWAREYOU; }
tell[' ']me[' ']a[' ']joke        { return JOKE; }
what[' ']can[' ']you[' ']do       { return CAPABILITIES; }

\n                                { return 0; }

.                                 { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
