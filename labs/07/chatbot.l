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
what[' ']is[' ']the[' ']time[' ']in[' ']Mexico     { return TIME; }
what[' ']time[' ']is[' ']it[' ']in[' ']Mexico      { return TIME; }
what[' ']is[' ']the[' ']time[' ']in[' ']Japan     { return TIMEJ; }
what[' ']time[' ']is[' ']it[' ']in[' ']Japan      { return TIMEJ; }
how[' ']are[' ']you              {return STATUS; }
what[' ']is[' ']your[' ']name    {return NAME; }
name            { return NAME; }

\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}