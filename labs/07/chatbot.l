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
date            { return DATE; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
what[' ']is[' ']the[' ']date  { return DATE; }
what[' ']day[' ']is[' ']today  { return DAY; }
what[' ']is[' ']your[' ']name { return NAME; }
how[' ']are[' ']you { return HOW_ARE_YOU; }
tell[' ']me[' ']a[' ']joke { return JOKE; }
how[' ']old[' ']are[' ']you { return AGE; }
tell[' ']me[' ']a[' ']random[' ']fact { return RANDOM; }
tell[' ']me[' ']a[' ']riddle { return RIDDLE; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
