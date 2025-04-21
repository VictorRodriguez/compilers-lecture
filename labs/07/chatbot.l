%{
#include "chatbot.tab.h"
%}

%%

hello           { return HELLO; } /*Greeting*/
hi              { return HELLO; } /*Greeting*/
hey             { return HELLO; } /*Greeting*/
goodbye         { return GOODBYE; } /*Farewell*/
bye             { return GOODBYE; } /*Farewell*/
time            { return TIME; } /*Query*/
what[' ']is[' ']the[' ']time  { return TIME; } /*Query*/
what[' ']time[' ']is[' ']it  { return TIME; } /*Query*/
what[' ']is[' ']your[' ']name  { return NAME; } /*Name*/
what[' ']is[' ']the[' ']weather  { return WEATHER; } /*Weather*/
what[' ']is[' ']the[' ']weather[' ']like  { return WEATHER; } /*Weather*/
tell[' ']me[' ']a[' ']joke    { return JOKE; } /*Jokes*/
make[' ']me[' ']laugh         { return JOKE; } /*Jokes*/
what[' ']can[' ']you[' ']do  { return CAPABILITIES; } /*Capabilities*/
\n              { return 0; }  /* End of input on newline */
.               { return yytext[0]; }
%%

int yywrap() {
    return 1;
}
