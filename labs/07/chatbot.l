%{
#include "y.tab.h"
%}

%%

hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }
howdy           { return HELLO; }
hola            { return HELLO; }
que[' ']onda    { return HELLO; }
goodbye         { return GOODBYE; }
bye             { return GOODBYE; }
restaurant      {return RESTAURANT; }
Can[' ']you[' ']give[' ']me[' ']any[' ']restaurant[' ']recomendation { return RESTAURANT; }
movie           { return MOVIE; }
movies          { return MOVIE; }
give[' ']me[' ']movie[' ']suggestions  { return MOVIE; }
any[' ']movie[' ']suggestions[' ']    { return MOVIE; }
i[' ']wanna[' ']watch[' ']a[' ']movie {return MOVIE; }
time            { return TIME; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
