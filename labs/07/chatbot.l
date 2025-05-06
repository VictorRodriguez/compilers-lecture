%{
#define YYSTYPE char*
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

hello|hi|howdy|hola|greetings                       { return HELLO; }
goodbye|bye|farewell|see[' ']you|later              { return GOODBYE; }
time                                                { return TIME; }
what[' ']is[' ']the[' ']time                        { return TIME; }
what[' ']time[' ']is[' ']it                         { return TIME; }
what[' ']time[' ']is[' ']it\?                       { return TIME; }
what's[' ']the[' ']weather[' ']like|what[' ']is[' ']the[' ']weather|weather     { return WEATHER; }
what[' ']is[' ']the[' ']weather\?|what's[' ']the[' ']weather[' ']like\?         { return WEATHER; }
draw[' ']something|can[' ']you[' ']draw\?                                       { return DRAW; }
help|how[' ']do[' ']I|what[' ']can[' ']you[' ']do                               { return HELP; }
about[ ][A-Za-z0-9 ]+  { 
    yylval = strdup(yytext + 6); // yytext + 6 to skip 'about ' prefix
    return MOVIE_INFO; 
}

\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
