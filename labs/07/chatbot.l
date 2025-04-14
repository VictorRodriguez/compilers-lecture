%{
#include "y.tab.h"
%}

%%

hello                       { return HELLO; }
hi                          { return HELLO; }
hey                         { return HELLO; }
goodbye                     { return GOODBYE; }
bye                         { return GOODBYE; }
time                        { return TIME; }
"what is the time"          { return TIME; }
"what time is it"           { return TIME; }
"what is your name"         { return NAME; }
"name"			    { return NAME; }
"your name"         	    { return NAME; }
"what is the weather"       { return WEATHER; }
"weather"                   { return WEATHER; }
"how are you"               { return HOWAREYOU; }
"mood"                      { return HOWAREYOU; }
"flip coin"                 { return FLIP_COIN; }

\n                          { return 0; }  /* End of input on newline */

.                           { return yytext[0]; }

%%

