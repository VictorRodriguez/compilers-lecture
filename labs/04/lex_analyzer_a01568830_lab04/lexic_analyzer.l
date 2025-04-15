
%{
#include <stdio.h>
%}

%%

// Regular expressions for tokens
"f"           { printf("floatdcl "); }
"i"           { printf("intdcl "); }
"p"           { printf("print "); }

[a-z]         { printf("id "); }
[0-9]+        { printf("inum "); }
[0-9]+"."[0-9]+ { printf("fnum "); }

"="           { printf("assign "); }
"+"           { printf("plus "); }

"//"          { /* Comment, ignore */ }
\n            { /* Newline, ignore */ }
[ \t]         { /* Whitespace, ignore */ }
.             { printf("Invalid token\n"); }

%%

int main() {
    yylex();
    return 0;
}
