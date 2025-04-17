%{
#include <stdio.h>
%}

%%

f					{printf("floatdcl");}
i					{printf("intdcl");}
p					{printf("print");}
"="					{printf("assign");}
"+"					{printf("plus");}
[0123456789]+"."[0123456789]*           {printf("fnum");}
[0123456789]+           		{printf("inum");}
[a-zA-Z][a-zA-Z0-9]*    		{printf("id");}
"//".*					{printf("COMMENT");}

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


