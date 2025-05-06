%{
#include <stdio.h>
%}

%%

"\/\/".*                    { printf("COMMENT\n"); }
"f"[ \t]*[a-zA-Z]+          { printf("floatdcl id\n"); }
"i"[ \t]*[a-zA-Z]+          { printf("intdcl id\n"); }
[a-zA-Z]+[ \t]*=[ \t]*[0-9]+    { printf("id assign inum\n"); }
[a-zA-Z]+[ \t]*=[ \t]*[a-zA-Z]+[ \t]*\+[ \t]*[0-9]+\.[0-9]+   { printf("id assign id plus fnum\n"); }
"p"[ \t]+[a-zA-Z]+          { printf("print id\n"); }
[ \t\n]+                    ; 
.                           { printf("Unexpected character\n"); }
%%
