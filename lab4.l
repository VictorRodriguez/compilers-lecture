%{
#include <stdio.h>
%}
/*Fernando López Gómez | A01639715*/

%%

"//".*                      { printf("COMMENT"); }
"p"                         { printf("print "); }
"f"                         { printf("floatdcl "); }
"i"                         { printf("intdcl "); }
[0-9]+                      { printf("inum "); }
[0-9]*\.[0-9]+              { printf("fnum "); }
[a-zA-Z]+[a-zA-Z0-9]*       { printf("id "); }
"="                         { printf("assign "); }
"+"                      { printf("plus "); }
"-"                      { printf("minus "); }
"*"                      { printf("times "); }
"/"                      { printf("division "); }
";"                      { printf("semicolon "); }
\n+                      { printf("\n"); }
[ \t]+                      /* Ignore whitespace */


%%

int main(int argc, char **argv) {
    FILE    *fd;

    if (argc == 2)
    {
        if (!(fd = fopen(argv[1], "r")))
        {
            perror("Error: ");
            return (-1);
        }
        yyset_in(fd);
        yylex();
        fclose(fd);
    }
    else
        printf("Usage: a.out filename\n");
    return (0);
}
