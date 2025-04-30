%{
#include <studio.h>
%}

letter          [a-eg-hj-op-zA-EG-HJ-OP-Z]
digit           [0-9]
integer         {digit}+
float           (0|[1-9]{digit}*)\.({digit}*[1-9]|0)
id              {letter}({letter}|{digit})*

%%
^i              {printf("int10");}
^f              {printf("float10");}
^p              {printf("print");}
\=              {printf("equals");}
\-              {printf("substract");}
\+              {printf("add");}
\*              {printf("multiply");}
\/              {printf("divide");}
\(              {printf("open_parenthesis");}
\)              {printf("close_parenthesis");}
\{              {printf("open_brace");}
\}              {printf("close_brace");}
\[              {printf("open_bracket");}
\]              {printf("close_bracket");}
\?              {printf("question_mark");}
\!              {printf("exclamation_mark");}
{id}            {printf("id");}
{integer}       {printf("int");}
{float}         {printf("float");}
%%

int main(){
    yylex();

    return 0;
}
