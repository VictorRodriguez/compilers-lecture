%{
#include <stdio.h>
%}

DIGIT    [0-9]
ID       [a-zA-Z_][a-zA-Z0-9_]*

%%
"//".*                  printf("COMMENT"); 
f                       printf("floatdcl"); 
i                       printf("intdcl"); 
p                       printf("print"); 
{ID}                    printf("id");
=                       printf("assign");  
\+                      printf("plus"); 
\-                      printf("minus"); 
\*                      printf("mult");
\/                      printf("div"); 
{DIGIT}+                printf("inum"); 
{DIGIT}+"."{DIGIT}*     printf("fnum"); 
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

