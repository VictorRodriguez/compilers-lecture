%{
#include <stdio.h>
%}

NUMBER [0-9]
ID [a-zA-Z_][a-zA-Z0-9_]*

%%

"//".*                      printf("COMMENT");
p                           printf("print");
i                           printf("intdcl");
f                           printf("floatdcl");
=                           printf("assign");
\+                          printf("plus");
-                           printf("minus");
\/                          printf("divide");
\*                          printf("multiply");
[+-]?{NUMBER}+              printf("inum");
{ID}                        printf("id");
[+-]?{NUMBER}+.{NUMBER}*    printf("fnum");

%%

int main(int argc, char **argv) {
    FILE    *file;

    if (argc == 2){
        if (!(file = fopen(argv[1], "r"))){
            perror("Couldn't open the file");
            return (-1);
        }
        yyset_in(file);
        yylex();
        fclose(file);
    }
    else
        printf("Usage: a.out filename\n");
    return (0);
}
