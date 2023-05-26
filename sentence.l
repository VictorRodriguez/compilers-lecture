%{
#include <stdio.h>
#include "sentence.tab.h"
%}



%%

boy|girl|flower         {return NOUN;}
likes|sees|touches      {return VERB;}
a|the                   {return ARTICLE;}
with                    {return PREP;}
[\n ]            /*"ignore" */
[ \t]+          /*"ignore" */
;
%% 
int yywrap(void){
  return 1;
}    
