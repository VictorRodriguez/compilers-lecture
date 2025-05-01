%{
#include "y.tab.h"
%}

%%

hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }
good[' ']morning { return GOODMORNING; }
good[' ']afternoon { return GOODAFTERNOON; }
good[' ']evening { return GOODEVENING; }
goodbye         { return GOODBYE; }
bye             { return GOODBYE; }
see[' ']you[' ']later { return GOODBYE; }
thanks          { return THANKS; }
thank[' ']you   { return THANKS; }
how[' ']are[' ']you  { return HOWAREYOU; }
what[' ']is[' ']your[' ']name  { return NAME; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
what[' ']day[' ']is[' ']it  { return DAY; }
how[' ']is[' ']the[' ']weather  { return WEATHER; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
