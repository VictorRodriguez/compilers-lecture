    %{
#include "y.tab.h"
%}

%%

/* Greetings */
hello                   { return HELLO; }
hi                      { return HELLO; }
hey                     { return HELLO; }
how[ \t]+are[ \t]+you   { return HELLO; }
what's[ \t]+up          { return HELLO; }
good[ \t]+morning       { return HELLO; }
good[ \t]+afternoon     { return HELLO; }
good[ \t]+evening       { return HELLO; }

/* Farewells */
goodbye                 { return GOODBYE; }
bye                     { return GOODBYE; }
see[ \t]+you[ \t]+later { return GOODBYE; }
take[ \t]+care          { return GOODBYE; }
farewell                { return GOODBYE; }
have[ \t]+a[ \t]+good[ \t]+day  { return GOODBYE; }
catch[ \t]+you[ \t]+later  { return GOODBYE; }

/* Time Queries */
time                    { return TIME; }
what[ \t]+is[ \t]+the[ \t]+time  { return TIME; }
what[ \t]+time[ \t]+is[ \t]+it  { return TIME; }
can[ \t]+you[ \t]+tell[ \t]+me[ \t]+the[ \t]+time  { return TIME; }
what's[ \t]+the[ \t]+time  { return TIME; }
do[ \t]+you[ \t]+know[ \t]+the[ \t]+time  { return TIME; }

/* Additional Queries */
what[ \t]+is[ \t]+your[ \t]+name  { return NAME; }
what[ \t]+is[ \t]+the[ \t]+weather  { return WEATHER; }
how[ \t]+are[ \t]+you  { return HOW_ARE_YOU; }

/* End of input on newline */
\n                      { return 0; }

/* Default rule */
.                       { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
