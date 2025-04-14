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
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
give[' ']me[' ']a[' ']random[' ']number  { return RANDOM; }
what[' ']is[' ']the[' ']weather  { return WEATHER; }

what[' ']is { printf("what is"); return WHATIS; }
[0-9]+          { yylval = atoi(yytext); return NUMBER; }

plus			  { printf("plus\n"); return PLUS; }
\n              { return 0; }

.               { }

%%

int yywrap() {
   return 1;
}

