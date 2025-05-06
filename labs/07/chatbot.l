%{
#include "y.tab.h"
%}

%%

hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }
goodbye         { return GOODBYE; }
bye             { return GOODBYE; }
name            { return NAME; }
fellowship      { return FELLOWSHIP; }
time            { return TIME; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
what[' ']is[' ']your[' ']name  { return NAME; }
how[' ']are[' ']you { return HOWAREYOU; }
where[' ']are[' ']you[' ']going { return JOURNEY; }
which[' ']is[' ']your[' ']favorite[' ']companion { return FELLOWSHIP; }

\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}