%{
#include "y.tab.h"
%}

%%

hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }
goodbye         { return GOODBYE; }
bye             { return GOODBYE; }
peace           { return GOODBYE; }
time            { return TIME; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
tell[' ']the[' ']time   { return TIME;}
name            { return NAME; }
what[' ']is[' ']your[' ']name   { return NAME; }
say[' ']your[' ']name   { return NAME; }
tell[' ']me[' ']your[' ']name   { return NAME; }
weather         { return WEATHER; }
what[' ']is[' ']the[' ']weather { return WEATHER; }
tell[' ']the[' ']weather { return WEATHER; }
how[' ']are[' ']you             { return HOWAREYOU; }
how[' ']is[' ']it[' ']going     { return HOWAREYOU; }
how[' ']are[' ']you[' ']doing   { return HOWAREYOU; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}