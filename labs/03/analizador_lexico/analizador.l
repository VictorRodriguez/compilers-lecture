%{
#include <stdio.h>
%}

%%
f                       printf("floatdlc");
i                       printf("intdcl");
p                       printf("print");

\=                      printf("assign");
\+                      printf("plus");
\-                      printf("minus");
\*                      printf("times");
\/                      printf("dividedby");

[a-z]                   printf("id ");
[+-]?[0-9]+             printf("inum ");
[+-]?[0-9]*\.[0-9]{1,5} printf("fnum ");

\/\/.*                  /* comentario */;
[ \t]+                  /* espacio */;
%%