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
date            { return DATE; }
what[' ']is[' ']the[' ']date  { return DATE; }
what[' ']date[' ']is[' ']it  { return DATE; }
weather         { return WEATHER; }
how[' ']is[' ']the[' ']weather  { return WEATHER; }
thank[' ']you   { return THANKS; }
thanks          { return THANKS; }
joke            { return JOKE; }
tell[' ']me[' ']a[' ']joke    { return JOKE; }
what[' ']is[' ']your[' ']name { return NAME; }
my[' ']name[' ']is[' ']([a-zA-Z]+) { yylval.str = strdup(yytext + 11); return NAME_IS; }
how[' ']are[' ']you { return HOW_ARE_YOU; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
