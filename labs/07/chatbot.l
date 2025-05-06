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
im[' ']bored                          { return BORED; }
bored                                 { return BORED; }
recommend[' ']me[' ']an[' ']activity  { return BORED; }
thanks                                 { return THANKS; }
thank[' ']you                          { return THANKS; }
thank[' ']u                            { return THANKS; }

\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
   return 1;
}
