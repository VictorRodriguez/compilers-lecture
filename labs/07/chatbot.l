%{
#include "y.tab.h"
%}

%%

([Hh])ello|([Hh])i                          { return HELLO; }
([Gg])oodbye                                { return GOODBYE; }
([Bb])ye                                    { return GOODBYE; }
([Ww])hat[' ']is[' ']the[' ']time[\?]?      { return TIME; }
([Ww])hat[' ']is[' ']your[' ']name[\?]?     { return NAME; }
([Ww])hat[' ']is[' ']the[' ']weather[\?]?   { return WEATHER; }
([Hh])ow[' ']are[' ']you[\?]?               { return HOW; }
([Pp])lay[' ']music                         { return PLAY_MUSIC; }
([Ss])top[' ']music                         { return STOP_MUSIC; }
([Ss])et[' ']alarm                          { return SET_ALARM; }
([Tt])ell[' ']me[' ']a[' ']joke             { return JOKE; }

\n                                     { return 0; }  /* End of input on newline */

.                                      { return yytext[0]; }

%%

int yywrap() {
    return 1;
}