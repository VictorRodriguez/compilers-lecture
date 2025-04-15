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
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
how[' ']do[' ']you[' ']feel[' ']today  { return FEEL; }
how[' ']you[' ']doing  { return FEEL; }
good[' ']bye  { return GOODBYE; }
see[' ']you[' ']later   { return GOODBYE; }
how[' ']is[' ']the[' ']weather[' ']   { return WEATHER; }

\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}