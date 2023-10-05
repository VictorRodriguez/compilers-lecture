%{
#include <stdio.h>
%}

%%
i                       printf("int_dc ");
f                       printf("float_dc ");
p                       printf("print ");
[a-z]                   printf("id ");
[0-9]+                  printf("int_num ");
[0-9]*\.[0-9]{1,5}      printf("float_num ");
=                       printf("assign ");
\+                      printf("plus ");
\-                      printf("minus ");
\*                      printf("multiply ");
\/                      printf("divide ");
\/\/.*                  /* ignore comment */;
[ \t]+                  /* ignore whitespace */;
%%