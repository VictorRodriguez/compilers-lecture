%{
#include "chatbot.tab.h"
%}

%%

hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }
goodbye         { return GOODBYE; }
bye             { return GOODBYE; }
time            { return TIME; }
name            {return NAME;}
weather            {return WEATHER;}
feeling            {return FEELING;}
action            {return ACTION;}
what[' ']should[' ']I[' ']do { return ACTION; }
what[' ']should[' ']i[' ']do { return ACTION; }
how[' ']are[' ']you { return FEELING; }
how[' ']are[' ']you[' ']feeling  { return FEELING; }
what[' ']is[' ']the[' ']weather  { return WEATHER; }
what[' ']is[' ']your[' ']name  { return NAME; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
