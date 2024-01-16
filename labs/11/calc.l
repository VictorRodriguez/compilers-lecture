%{
#include "y.tab.h"
%}
%%

-?[0-9]+     { yylval.ival = atoi(yytext); return INTEGER; }
-?[0-9]+\.[0-9]{5} { yylval.fval = atof(yytext); return FLOAT; }
[a-eg-hj-oq-z] { yylval.cval = *yytext; return VARIABLE; }
[ \t]      { /* ignore whitespace */ }
\/\/[^\n]*     { printf("comment"); }
\n         {  }
.          { return yytext[0]; }
%%