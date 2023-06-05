%{

#include "y.tab.h"

%}



%%



please          {return PLOX; }



robot           {return NOUN; }



move            {return MOVE; }



blocks          {return BLOCKS; }



ahead           {return AHEAD; }



degrees         {return DEGREES; }



turn            {return TURN; }



and             {return AND; }



then            {return THEN; }



,               {return COMMA;  }



[0-9]           {yylval.block=atoi(yytext);     return BLOCKS; }



90|180|270|360  {yylval.degree=atoi(yytext);    return DEGREE; }



[ \t]+          ;



\n              {return END;}



.               {return yytext[0];}

%%



int yywrap(void)

{

        return 1;

}