%{
#include <stdio.h>
%}

%%
^\/\/[a-zA-Z0-9]+$	printf("\n");
[0-9]+   printf("inum\n"); 
[0-9]+\\.[0-9]{1,5}     printf("fnum\n"); 
[a-eg-hj-oq-z]     printf("id\n"); 
["f"]   printf("floatdcl\n"); 
["i"]   printf("intdcl\n"); 
["p"]   printf("print\n"); 
["="]	printf("assign\n"); 
["\\+"] printf("plus\n"); 
["\-"]	printf("minus\n"); 
["\\*"] printf("times\n"); 
["/"]   printf("divide\n"); 
["\\("] printf("LParen\n"); 
["\\)"] printf("RParen\n"); 
[";"]   printf("Semicolon\n"); 
[ \t\n]		
.	
%%

int main(int argc, char **argv){
    FILE        *fd;

        if (argc ==2)
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
