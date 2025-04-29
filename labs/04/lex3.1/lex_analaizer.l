%{
#include <stdio.h>
%}
%option noyywrap

%%
"f"[ \t]+                printf("floatdcl ");
"i"[ \t]+                printf("intdcl ");
"p"[ \t]+                printf("print ");
"="                      printf("assign ");
"+"                      printf("plus ");
"//".*                   printf("COMMENT ");
[0-9]+\.[0-9]+           printf("fnum ");
[0-9]+                   printf("inum ");
[a-z]                    printf("id ");
[ \t\n]+                 /* ignore whitespace */;
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