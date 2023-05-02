%{
# include <stdio.h>
#include "y.yab.h"
%}


%%
a|the {return ARTICLE;}
boy|girl|flower {return NOUN;}
touches|likes|sees {return VERB;}
with {return PREP;}
[ \t] ;
\n {return 0;}
. {return yytext[0];}
%%

int main(){
yylex();
}