%{
#include "calc.tab.h"
%}

%%

[0-9]+          { yylval = atoi(yytext); return DIGIT; }
[a-zA-Z]        { yylval = *yytext - 'a'; return LETTER; }
[ \t]           ; // Ignore whitespace characters
\n              return '\n'; // Ignore newline characters
.               { return *yytext; } // Return other characters as is

%%

int yywrap() {
    return 1;
}
