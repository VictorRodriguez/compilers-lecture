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
weather         { return WEATHER; }
tamagotchi      { return TAMAGOTCHI; }
what[' ']is[' ']the[' ']time    { return TIME; }
what[' ']time[' ']is[' ']it     { return TIME; }
what[' ']is[' ']your[' ']name   { return NAME; }
what[' ']is[' ']the[' ']weather { return WEATHER; }
how[' ']is[' ']the[' ']weather  { return WEATHER; }
how[' ']are[' ']you             { return MOOD; }
who[' ']is[' ']the[' ']tamagotchi[' ']of[' ']the[' ']day  { return TAMAGOTCHI; }
tell[' ']me[' ']the[' ']tamagotchi[' ']of[' ']the[' ']day { return TAMAGOTCHI; }
tamagotchi[' ']of[' ']the[' ']day                         { return TAMAGOTCHI; }
\n                              { return 0; }  /* End of input on newline */
.                               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}