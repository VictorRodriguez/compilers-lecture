%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
Robot|Amadeus|Kurisu        { return ROBOT; }
please                      { return PLEASE; }
move                        { return MOVE; }
turn                        { return TURN; }
[0-9]+                      { yylval.dval = atoi(yytext); return NUMBER; }
(and\ |,\ )then             { return CONNECTOR; }
(blocks\ ahead)|blocks      { return BLOCKS; }
degrees                     { return DEGREES; }
[ \t]+                      /* ignore whitespace */;
%%