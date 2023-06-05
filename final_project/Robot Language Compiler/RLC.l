%{
#include <stdio.h>
#include "y.tab.h"
%}

%%

[ \t]  { /* ignore whitespace */ }
[0-9]+  { return NUMBER; }
please  { return PLEASE; }
and     { return AND; }
go|turn { return ACTION; }
forward|backward|right|left  { return DIRECTION; }
block|blocks|degrees  { return UNIT; }
\n      { return '\n'; }
.       { printf("Lexical error: Unrecognized token '%s'\n", yytext); }

%%
