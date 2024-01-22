%{
#include "y.tab.h"
%}
%%
[ \t] ; 			                        /* ignore whitespace */
\n                              return 0;
[abcdeghjklmnoqrstuvwxyz]       { yylval.sval = strdup(yytext); return ID; }
\/\/.*                          { yylval.sval = strdup(yytext); return COMMENT; }
p                               { yylval.sval = strdup(yytext); return PRINT; }
f                               { yylval.sval = strdup(yytext); return TYPE; }
i                               { yylval.sval = strdup(yytext); return TYPE; }
[0123456789]+                   { yylval.dval = atoi(yytext); return INTEGER; }
[0123456789]+.[0123456789]+     { yylval.dval = atof(yytext); return FLOAT; };
.                               return yytext[0];
%%
