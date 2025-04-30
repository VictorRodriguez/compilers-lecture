%{
#include <stdio.h>
%}

VARIABLE    [a-zA-Z][a-zA-Z0-9]*  
INT      [0-9]+
FLOAT       [0-9]+\.[0-9]+
FLOAT_DECLARATION   "f"
INT_DECLARATION     "i"
PRINT               "p"

%%
"//".*                                                                         {printf("COMMENT\n");}

{FLOAT_DECLARATION}[ \t]{VARIABLE}                                                     {printf("floatdcl id\n");}
{INT_DECLARATION}[ \t]{VARIABLE}                                                     {printf("intdcl id\n");}

{VARIABLE}[ \t]=[ \t]{INT}                                          {printf("id assign inum\n");}

{VARIABLE}[ \t]=[ \t]{VARIABLE}[ \t]*\+[ \t]{FLOAT} {printf("id assign id plus fnum\n");}
{VARIABLE}[ \t]=[ \t]{VARIABLE}[ \t]*-[ \t]{FLOAT} {printf("id assign id minus fnum\n");}
{VARIABLE}[ \t]=[ \t]{VARIABLE}[ \t]*\*[ \t]{FLOAT} {printf("id assign id times fnum\n");}
{VARIABLE}[ \t]=[ \t]{VARIABLE}[ \t]*\/[ \t]{FLOAT} {printf("id assign id over fnum\n");}

{VARIABLE}[ \t]=[ \t]{VARIABLE}[ \t]*\+[ \t]{INT}         {printf("id assign id plus inum\n");}
{VARIABLE}[ \t]=[ \t]{VARIABLE}[ \t]*-[ \t]{INT}          {printf("id assign id minus inum\n");}
{VARIABLE}[ \t]=[ \t]{VARIABLE}[ \t]*\*[ \t]{INT}         {printf("id assign id times inum\n");}
{VARIABLE}[ \t]=[ \t]{VARIABLE}[ \t]*\/[ \t]{INT}         {printf("id assign id over inum\n");}

{PRINT}[ \t]{VARIABLE}                                                     {printf("print id\n"); }
[ \t\n]                                                                        {/* whitespace */ }

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
