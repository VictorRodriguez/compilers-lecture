%{
#include "y.tab.h"
%}

%%

hello|hi|hey|hola|howdy          { return HELLO; }
goodbye|bye|farewell|ciao        { return GOODBYE; }
time|clock|hour                  { return TIME; }
what[' ']is[' ']the[' ']time     { return TIME; }
what[' ']time[' ']is[' ']it      { return TIME; }
what[' ']is[' ']the[' ']hour     { return TIME; }
exit|leave                       { return EXIT; }
\n                               { return 0; }  /* End of input on newline */

.                                { return yytext[0]; }

%%

int yywrap() {
    return 1;
}