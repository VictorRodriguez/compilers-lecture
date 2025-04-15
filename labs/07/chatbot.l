%{
#include "y.tab.h"
%}

%%

hello                                   { return HELLO; }
hi                                      { return HELLO; }
hey                                     { return HELLO; }
goodbye                                 { return GOODBYE; }
bye                                     { return GOODBYE; }
time                                    { return TIME; }
what[' ']is[' ']the[' ']time            { return TIME; }
what[' ']time[' ']is[' ']it             { return TIME; }
"how"[' ']+"much"[' ']+"is"[' ']        { return CALCULATION; }
[0-9]*\.[0-9]+                          {   yylval.floatValue = atof(yytext); // Convert token text to integer
                                            return FNUM;   }
[0-9]+                                  {   yylval.intValue = atoi(yytext); // Convert token text to integer
                                            return INUM;  }
"+"                                     { return SUM; }
"what"[' ']+"is"[' ']+"combo"[' ']+"number"[' ']   { return COMBO; }
[ \t]                                   ; // ignore whitespace
\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}