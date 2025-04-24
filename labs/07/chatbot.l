%{
#include "y.tab.h"
%}

%%

hello|hi|hey          { return HELLO; }
goodbye|bye         { return GOODBYE; }
time            { return TIME; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
what[' ']is[' ']your[' ']name { return NAME; }
what[' ']is[' ']the[' ']weather { return WEATHER; }
how[' ']are[' ']you { return HOWRU; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%