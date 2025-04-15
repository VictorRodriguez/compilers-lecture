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
weather		{ return WEATHER; }
What's[' ']the[' ']weather[' ']like\?  { return WEATHER; } /* The question now starts with a capital letter and ends with a question mark  */
What[' ']time[' ']is[' ']it\?  { return TIME; } /* The question now starts with a capital letter and ends with a question mark  */
What[' ']is[' ']your[' ']name\? { return NAME; }
What's[' ']your[' ']name\? { return NAME; }
How[' ']are[' ']you\? { return FEELING;  }
joke		{ return JOKE  ; }
Tell[' ']me[' ']a[' ']joke    { return JOKE   ; }
\n              { return 0; }  /* End of input on newline */
.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
