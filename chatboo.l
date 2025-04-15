%{
#include <stdio.h>
#include "y.tab.h"
%}

%%

hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }
goodbye         { return GOODBYE; }
bye             { return GOODBYE; }
time            { return TIME; }
what[' ']is[' ']your[' ']name  { return NAME; }
what[' ']is[' ']the[' ']weather  { return WEATHER; }
how[' ']are[' ']you  { return FEELING; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
