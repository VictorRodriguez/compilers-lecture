%{
#include "y.tab.h"
#include <time.h>
%}

%%

time            { return TIME; }
date            { return DATE; }
hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }
goodbye         { return GOODBYE; }
bye             { return GOODBYE; }
farewell        { return GOODBYE; }
morning         { return MORNING; }
evening         { return EVENING; }
afternoon       { return AFTERNOON; }

what[' ']is[' ']the[' ']time                { return TIME; }
give[' ']me[' ']the[' ']time                { return TIME; }
give[' ']me[' ']the[' ']time[' ']please     { return TIME; }
what[' ']time[' ']is[' ']it                 { return TIME; }
what[' ']is[' ']the[' ']date                { return DATE; }
what[' ']day[' ']is[' ']it                  { return DATE; }  
give[' ']me[' ']the[' ']date[' ']please     { return DATE; }
what[' ']is[' ']your[' ']name               { return NAME; }
see[' ']you[' ']later                       { return GOODBYE; }
good[' ']morning                            { return MORNING; }
good[' ']evening                            { return EVENING; }
good[' ']afternoon                          { return AFTERNOON; }
how[' ']are[' ']you                         { return HOW_ARE_YOU; }
\n              { return 0; }  

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
