%{
#include "y.tab.h"
%}

%%

hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }

goodbye         { return GOODBYE; }
bye             { return GOODBYE; }

time                          { return TIME_QUERY; }
what[' ']is[' ']the[' ']time  { return TIME_QUERY; }
what[' ']time[' ']is[' ']it   { return TIME_QUERY; }

name                           { return NAME_QUERY; }
what[' ']is[' ']your[' ']name  { return NAME_QUERY; }
who[' ']are[' ']you            { return NAME_QUERY; }

weather[' ']                               { return WEATHER_QUERY; }
how[' ']is[' ']the[' ']weather[' ']in[' '] { return WEATHER_QUERY; }

i[' ']am[' ']           { return USER_NAME_QUERY;}
my[' ']name[' ']is[' '] { return USER_NAME_QUERY;}

[A-Za-z]+ {yylval.sval = strdup(yytext); return GIVEN_NAME; }

\n              { return 0; }  /* End of input on newline */
.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}