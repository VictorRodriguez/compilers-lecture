%{
#include "chatbot.tab.h"
%}
%option outfile="chatbot.c"
%%

hello|hi|hey                  { return HELLO; }
goodbye|bye                   { return GOODBYE; }
time                          { return TIME; }
what[[:space:]]is[[:space:]]the[[:space:]]time { return TIME; }
what[[:space:]]time[[:space:]]is[[:space:]]it  { return TIME; }
what[[:space:]]is[[:space:]]your[[:space:]]name { return NAME; }
what[[:space:]]is[[:space:]]the[[:space:]]weather { return WEATHER; }
weather[[:space:]]in[[:space:]]([a-zA-Z ]+)        { yylval.str = strdup(yytext + 11); return WEATHER_CITY; }
[0-9]+[[:space:]]*\+[[:space:]]*[0-9]+   { yylval.str = strdup(yytext); return ADD; }
[0-9]+[[:space:]]*-[[:space:]]*[0-9]+   { yylval.str = strdup(yytext); return SUB; }
[0-9]+[[:space:]]*\*[[:space:]]*[0-9]+   { yylval.str = strdup(yytext); return MUL; }
[0-9]+[[:space:]]*\/[[:space:]]*[0-9]+   { yylval.str = strdup(yytext); return DIV; }

\n                            { return 0; }
.                             { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
