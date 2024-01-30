/*Miguel Angel Cabrera Victoria*/
/*<A01782982@tec.mx>*
/*LAB-03*/

%{
#include "y.tab.h"
%}

%%

[aA] |
[tT]he          { return ARTICLE; }

[gG]irl |
[bB]oy |
[fF]lower       { return NOUN; }

[tT]ouches |
[lL]ikes |
[sS]ees         { return VERB; }

[wW]ith         { return PREP; }

[ \t]+          /* ignore whitespaces */

\n              { return EOL; }

%%

int yywrap(void) {
    return 1;
}
