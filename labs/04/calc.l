%{
        #include <stdio.h>
        #include "y.tab.h"
        extern double symtable[23];
%}

%%
[\t ]+
[/]{2}[[a-zA-Z0-9]*[\t ]*]*\n { return COMMENT; }
i  	{ return INTDCL; }
p  {  return PRINT; }
[a-e]|[g-h]|[j-o]|[q-z] 	{ yylval.vblno = yytext[0] - 'a'; return ID; }
= { return ASSIGN; } 
\+ 	{ return PLUS; }
- 	{ return MINUS; }
\*   { return TIMES; }
\/   { return DIVIDE; }
[0-9]+ 	{ yylval.dval = atof(yytext); return INUM; }
.   return yytext[0];
%% 
