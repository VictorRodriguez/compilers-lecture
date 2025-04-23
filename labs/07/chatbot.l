%{
#include "y.tab.h"
%}

%%

Hello[' ']World                           { return HI; }
Hi                                        { return HI; }
Hello                                     { return HI; }
Goodbye[' ']World                         { return BYE; }
Bye                                       { return BYE; }
Goodbye                                   { return BYE; }
See[' ']you[' ']soon                      { return BYE; }
See[' ']you[' ']later[' ']alligator       { return BYE; }
Time                                      { return TIME; }
What[' ']time[' ']is                      { return TIME; }
Give[' ']me[' ']the[' ']time              { return TIME; }
How[' ']are[' ']you                       { return FEELING; }
How[' ']are[' ']you[' ']feeling           { return FEELING; }
What[' ']is[' ']your[' ']name             { return NAME; }
Tell[' ']me[' ']your[' ']name             { return NAME; }
How[' ']is[' ']the[' ']wheater            { return WEATHER; }
Tell[' ']me[' ']the[' ']wheater           { return WEATHER; }

\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}