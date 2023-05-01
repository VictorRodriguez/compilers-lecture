%{
#include "y.tab.h"
%}

%%

"boy"|"girl"|"flower" { yylval.str = strdup(yytext); return NOUN; }
"touches"|"likes"|"sees" { yylval.str = strdup(yytext); return VERB; }
"a"|"the" { yylval.str = strdup(yytext); return ARTICLE; }
"with" { yylval.str = strdup(yytext); return PREPOSITION; }
";"|\. { return DELIMITER; }
[ \t\n] { } /* skip whitespace */

%%

int yywrap() {
    return 1;
}

