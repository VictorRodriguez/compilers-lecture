%{
#include <stdio.h>
%}


%%
[0-9]+	{printf("inum ");}
[0-9]+.[0-9]+	{printf("fnum ");}
"i" 	{printf("intdcl ");}
"f" 	{printf("floatdcl ");}
"p" 	{printf("print ");}
"//"[a-zA-Z0-9" ".+*=/]*	{printf("COMMENT ");}
[a-eg-hj-oq-z]	{printf("id ");}
=	{printf("assign ");}
[+]	{printf("plus ");}
[*]	{printf("multiply ");}
\n      {printf("\n");}
[ \t]+                  /* ignore whitespace */;

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

