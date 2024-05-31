%{
#include "y.tab.h"
%}

%%

hello                            { return HELLO; }
hi                               { return HELLO; }
hey                              { return HELLO; }
goodbye                          { return GOODBYE; }
bye                              { return GOODBYE; }
time                             { return TIME; }
what[' ']is[' ']the[' ']time     { return TIME; }
what[' ']time[' ']is[' ']it      { return TIME; }
tell[' ']me[' ']the[' ']time     { return TIME; }
what[' ']is[' ']the[' ']current[' ']time { return TIME; }
tell[' ']a[' ']joke              { return JOKE; }
tell[' ']me[' ']a[' ']joke       { return JOKE; }
give[' ']me[' ']a[' ']joke       { return JOKE; }
make[' ']me[' ']laugh            { return JOKE; }
joke                             { return JOKE; }
I[' ']am[' ']lonely              { return LONELY; }
i[' ']am[' ']lonely              { return LONELY; }
I[' ']feel[' ']lonely            { return LONELY; }
i[' ']feel[' ']lonely            { return LONELY; }
I[' ']am[' ']sad                 { return SAD; }
i[' ']am[' ']sad                 { return SAD; }
sad                              { return SAD; }
I[' ']feel[' ']sad               { return SAD; }
i[' ']feel[' ']sad               { return SAD; }
happy                            { return HAPPY; }
I[' ']am[' ']happy               { return HAPPY; }
i[' ']am[' ']happy               { return HAPPY; }
I[' ']feel[' ']happy             { return HAPPY; }
i[' ']feel[' ']happy             { return HAPPY; }
pokemon                          { return POKEMON; }
give[' ']me[' ']a[' ']pokemon    { return POKEMON; }
show[' ']me[' ']a[' ']pokemon    { return POKEMON; }
I[' ']want[' ']a[' ']pokemon     { return POKEMON; }
money                            { return MONEY; }
I[' ']need[' ']money             { return MONEY; }
give[' ']me[' ']money            { return MONEY; }
\n                               { return 0; }  /* End of input on newline */
.                                { return yytext[0]; }

%%

int yywrap() {
    return 1;
}