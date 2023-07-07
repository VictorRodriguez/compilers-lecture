%{
#include <stdio.h>
%}

%%
"//".*                   printf("COMMENT");
[a-eg-hj-oq-z][0-9]*     printf("id ");
i                        printf("intdcl ");
f                        printf("floatdcl ");
p                        printf("print ");
=                        printf("assign ");
\+                       printf("plus ");
\-                       printf("minus ");
\*                       printf("times ");
\/                       printf("divide ");
[0-9]+\.[0-9]+           printf("fnum ");
[0-9]+                   printf("inum ");
[ \t] ; 			     /* ignore whitespace */
.                        printf("Syntax Error\n");
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
