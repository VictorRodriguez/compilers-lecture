%{
#include "y.tab.h"
%}

%option case-insensitive

%%

hello|hi|hey                            { return HELLO; }
goodbye|bye                             { return GOODBYE; }
time                                    { return TIME; }
what[' ']is[' ']the[' ']time\?*         { return TIME; }
what[' ']time[' ']is[' ']it\?*          { return TIME; }
what[' ']is[' ']your[' ']name\?*|name   { return NAME; }
how[' ']are[' ']you\?*                  { return EMOTION; }
what[' ']is[' ']the[' ']date\?*|date    { return DATE; }
\n                                      { return 0; }  /* End of input on newline */

.                                       { return yytext[0]; }

%%

int yywrap() {
    return 1;
}