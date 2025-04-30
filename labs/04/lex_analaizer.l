%{
#include <stdio.h>
int yywrap(void) { return 1; }
%}

%%

"//".*              printf("COMMENT");
f                   printf("floatdcl ");
i                   printf("intdcl ");
p                   printf("print ");
[a-eg-hj-oq-z]      printf("id ");
[0-9]+              printf("inum ");
[0-9]*\.[0-9]+      printf("fnum ");
=                   printf("assign ");
\+                  printf("plus ");
\-                  printf("substraction\n");
\*                  printf("multiplication\n");
\/                  printf("division\n");
[ \t]+              /* ignore spaces */
\n                  printf("\n");

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *fp = fopen(argv[1], "r");
        if (!fp) {
            perror("File open failed");
            return 1;
        }
        yyin = fp;
    }
    yylex();
    return 0;
}