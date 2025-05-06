%{
#include "chatbot.tab.h"
extern int yylval;
%}

%%
hello                           { return HELLO; }
hi                              { return HELLO; }
hey                             { return HELLO; }
"good morning"                  { return HELLO; }
"good evening"                  { return HELLO; }
"good afternoon"                { return HELLO; }
goodbye                         { return GOODBYE; }
bye                             { return GOODBYE; }
"see you"                       { return GOODBYE; }
thanks                          { return THANKS; }
"thank you"                     { return THANKS; }
"thanks a lot"                  { return THANKS; }
"thank you very much"           { return THANKS; }
"thanks so much"                { return THANKS; }
time                            { return TIME; }
what[' ']is[' ']the[' ']time    { return TIME; }
what[' ']time[' ']is[' ']it     { return TIME; }
"can you ".*" time"             { return TIME; }
name                            { return NAME; }
what[' ']is[' ']your[' ']name   { return NAME; }
your[' ']name                   { return NAME; }
"do you have".*" name"          { return NAME; }
.*weather.*                     { return WEATHER; }
.*sunny.*                       { return WEATHER; }
.*rain.*                        { return WEATHER; }
.*snow.*                        { return WEATHER; }
.*windy.*                       { return WEATHER; }                         
.*temperature.*                 { return WEATHER; }                         
.*joke.*                        { return JOKE; }
"sing".*"song"                  { return SING; }
.*sing.*                        { return SING; }
recommend.*artist               { return ARTISTREC; }
recommend.*album                { return ALBUMREC; }
recommend.*song                 { return SONGREC; }
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
"("         { return '('; }
")"         { return ')'; }
[ \t]       { /* ignore whitespace */ }
\n          { return 0; }  /* End of input on newline */
.           { return yytext[0]; }
%%

int yywrap() {
    return 1;
}