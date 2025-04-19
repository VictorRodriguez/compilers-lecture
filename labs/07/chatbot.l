%{
#include "y.tab.h"
#include <string.h>

extern char *yytext;
%}

%%

[hH]ello           { return HELLO; }
[Hh]i              { return HELLO; }
[Hh]ey             { return HELLO; }
[Gg]oodbye         { return GOODBYE; }
[bB]ye             { return GOODBYE; }
[tT]ime            { return TIME; }
[sS]tatus          { return HOWAREYOU; }
[Nn]ame            { return NAME; }
[a-zA-Z]+[' ']*[a-zA-Z]*    { yylval.str = strdup(yytext);  return PLAYER; }
[Tt]ell[' ']me[' ']about[' '][a-zA-Z]+[' ']*[a-zA-Z]*          { yylval.str = strdup(yytext+14);  return PLAYER; }
[Aa]bout[' '][a-zA-Z]+[' ']*[a-zA-Z]*          { yylval.str = strdup(yytext+6);  return PLAYER; }
[Ww]hat[' ']is[' ']the[' ']time\?*  { return TIME; }
[Ww]hat[' ']time[' ']is[' ']it\?*  { return TIME; }
[Hh]ow[' ']are[' ']you\?* {return HOWAREYOU; }
[Ww]hat[' ']is[' ']your[' ']name\?* {return NAME; }
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
