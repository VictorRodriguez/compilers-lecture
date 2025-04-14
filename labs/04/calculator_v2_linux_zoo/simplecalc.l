%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%option noyywrap

%%
"//".*                  { printf("COMMENT "); return '\n'; }
"f"                     { printf("floatdcl "); return FLOATDCL; }
[a-eghj-oq-z]           { printf("id "); yylval.sval = yytext[0]; return NAME;}
"i"                     { printf("intdcl "); return INTDCL; }
"="                     { printf("assign "); return '=';}
[0-9]+                  { printf("inum "); yylval.dval = atoi(yytext); return NUMBER;}
"+"                     { printf("plus "); return '+'; }
"*"                     { printf("times "); return '*'; }
"-"                     { printf("minus "); return '-'; }
"/"                     { printf("divided" ); return '/'; }
[0-9]+"."[0-9]+         { printf("fnum "); yylval.dval = atof(yytext); return NUMBER; }
"p"                     { printf("print "); return PRINT;}
[ \t] ;                 /* ignore whitespace */
\n                      { return '\n'; }           /* logical EOF */
.                       { return yytext[0]; }
%%
