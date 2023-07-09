%{
#include <stdio.h>
%}

%%
"//".*          printf("COMMENT");
"f"             printf("floatdcl ");
"i"             printf("intdcl ");
"p"             printf("print ");
[a-z]+          printf("id ");
"="             printf("assign ");
[0-9]+          printf("inum ");
[0-9]*\.[0-9]+  printf("fnum ");
"+"             printf("plus ");
"-"             printf("minus ");
\n              printf("\n");
[ \t]+          /* ignore whitespace */
%%
