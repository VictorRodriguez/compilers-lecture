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
anime           {return ANIME; }
sport		{return SPORT; }
weather		{return WEATHER; }
food		{return FOOD; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
what[' ']is[' ']the[' ']best[' ']anime[' ']in[' ']the[' ']history {return ANIME; }
what[' ']is[' ']the[' ']best[' ']sport[' ']in[' ']the[' ']history {return SPORT; }
how[' ']is[' ']the[' ']weather {return WEATHER; }
what[' ']is[' ']your[' ']favorite[' ']food {return FOOD; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
