%{
#include "y.tab.h"
%}

%%

hello                           { return HELLO; }
hi                              { return HELLO; }
hey                             { return HELLO; }
goodbye                         { return GOODBYE; }
bye                             { return GOODBYE; }
time                            { return TIME; }
what[' ']is[' ']the[' ']time    { return TIME; }
what[' ']time[' ']is[' ']it     { return TIME; }
weather                         { return WEATHER; }
give[' ']me[' ']the[' ']weather { return WEATHER; }
what[' ']is[' ']the[' ']weather {return WEATHER; }
how[' ']are[' ']you             { return HOWAREYOU; }
what[' ']are[' ']you[' ']doing  {return WRYD; }
sing[' ']a[' ']song             {return SINGREQUEST; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
