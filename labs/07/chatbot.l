%{
#include "y.tab.h"
%}

%%

hello                                   { return HELLO; }
holaaa                                  { return HELLO; }
heyyy                                   { return HELLO; }
goodbye                                 { return GOODBYE; }
bye                                     { return GOODBYE; }
adios                                   { return GOODBYE; }
time                                    { return TIME; }
what[' ']is[' ']the[' ']time            { return TIME; }
what[' ']time[' ']is[' ']it             { return TIME; }
name                                    { return NAME; }
weather                                 { return WEATHER; }
how[' ']is[' ']the[' ']weather          { return WEATHER; }
how[' ']are[' ']you                     { return HOW_ARE_YOU; }
\n                                      { return 0; }  /* End of input on newline */
.                                       { return yytext[0]; }

%%

int yywrap() {
    return 1;
}