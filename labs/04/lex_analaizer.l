%{
#include <stdio.h>
%}

%%
[abcdeghjklmnoqrstuvwxyz]  printf("id");
\/\/.*  printf("COMMENT");
\+   printf("plus");
\-   printf("minus");
\*  printf("mult");
\/  printf("div");
\=   printf("assign");
p   printf("print");
f   printf("floatdcl");
i   printf("intdcl");
[0123456789]+   printf("inum");
[0123456789]+.[0123456789]+   printf("fnum");

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
        printf("Usage: ./lex_analaizer filename\n");
    return (0);
}