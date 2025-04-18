%{
#include "y.tab.h"
%}

%%

magic8[^\n]* { return MAGIC_8_BALL; }

mood { return MOOD; }
how[' ']are[' ']you  { return MOOD; }

hello            { return HELLO; }
hi               { return HELLO; }
hey              { return HELLO; }
goodbye          { return GOODBYE; }
bye              { return GOODBYE; }
time             { return TIME; }
ping             { return PING; }
weather          { return WEATHER;}
what[' ']is[' ']the[' ']weather  { return WEATHER; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
\n               { return 0; }  /* End of input on newline */

.                { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
