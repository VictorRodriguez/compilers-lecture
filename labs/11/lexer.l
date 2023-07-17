%{
#include "y.tab.h"
%}
%%

-?[0-9]+     { yylval.ival = atoi(yytext); return INTEGER; }
-?[0-9]+\.[0-9]{5} { yylval.fval = atof(yytext); return FLOAT; }
f                 { return FLOAT_TYPE; }
i                 { return INTEGER_TYPE; }
p                 { return PRINT; }
[a-eg-hj-oq-z] { yylval.cval = *yytext; return VARIABLE; }
[ \t]      { /* ignore whitespace */ }
\/\/.*     { /* ignore comments */ }
\n         {  }
.          { return yytext[0]; }
%%