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
date            { return DATE; }
help            { return HELP; }
joke            { return JOKE; }
fact            { return FACT; }
what[' ']is[' ']the[' ']time            { return TIME; }
what[' ']time[' ']is[' ']it             { return TIME; }
can[' ']you[' ']help[' ']me             { return HELP; }
how[' ']are[' ']you                     { return HOWAREYOU; }
what[' ']is[' ']the[' ']date[' ']today  { return DATE; }
what[' ']day[' ']is[' ']it              { return DATE; }
tell[' ']me[' ']a[' ']joke              { return JOKE; }
tell[' ']me[' ']a[' ']fact              { return FACT; }
tell[' ']me[' ']something               { return FACT; }
give[' ']me[' ']a[' ']random[' ']number { return RANDOMNUMBER; }
random[' ']number                       { return RANDOMNUMBER; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
