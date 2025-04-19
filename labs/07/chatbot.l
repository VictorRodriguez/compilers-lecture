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
how[' ']are[' ']you     { return HOW_ARE_YOU; }
how[' ']you[' ']doing	{ return HOW_ARE_YOU; } /* How are you  */
what[' ']up             { return WHAT_UP; } /* For a more casual line */
what[' ']is[' ']your[' ']name  { return NAME; }
who[' ']are[' ']you	{ return NAME; }
weather		{ return WEATHER; }
how[' ']is[' ']the[' ']weather	{ return WEATHER; }
what[' ']is[' ']the[' ']weather { return WEATHER; } /* Added weather */
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
