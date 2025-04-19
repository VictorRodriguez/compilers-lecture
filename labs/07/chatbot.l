%{
#include "y.tab.h"
#include <stdlib.h>
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
why[' ']Kane {return NAME; }
why[' ']is[' ']your[' ']name[' ']Kane {return NAME; }
how[' ']are[' ']you {return MOOD; }
what[' ']is[' ']the[' ']weather {return WEATHER; }
weather {return WEATHER; }
recommend[' ']an[' ']artist {return MUSIC; }
artist {return MUSIC; }

\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}