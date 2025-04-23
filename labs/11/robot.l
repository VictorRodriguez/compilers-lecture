%{
#include "y.tab.h"
#include <stdio.h>
%}

%%
Robot                           { return ROBOT; }
please                          { return POLITE; }
move                            { return MOVE; }
turn                            { return TURN; }
90|180|270|360                  { yylval.degrees = atoi(yytext); return DEGREES; }
[0-9]                           { yylval.steps = atoi(yytext); return STEPS; }
[ \t]+ 			                /* ignore whitespace */
\n                              { return ENDLINE; }
.                               /* ignore irrelevant text*/
%%