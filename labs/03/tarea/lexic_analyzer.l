%{
#include <stdio.h>
%}

%%
\/\/.*\n                /* ignore comments */;
i                       printf("intdcl ");
f                       printf("floatdcl ");
p                       printf("print ");
[a-eghj-oq-z]           printf("id ");
[0-9]{1,8}"."[0-9]{1,5} printf("fnum ");
[0-9]{1,8}              printf("inum ");
"="                     printf("assign ");
"+"                     printf("plus ");
"-"                     printf("minus ");
"*"                     printf("multiplication ");
"/"                     printf("division ");
"%"                     printf("modulo ");
\n                      printf("\n");
[ \t]+                  /* ignore whitespace */;
%%