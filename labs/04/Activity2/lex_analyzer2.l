/*
José Guerrero
A01285612
Act2
21/01/2024
*/


/*
This code has a different approach on the grammar managment but,
it passed all of my test cases. 
Ex.-
1- p = a + 20
2- i i
3- p f
*/


%{
#include <stdio.h>
%}



%%
[//][a-zA-Z][a-zA-Z0-9]*                                    {printf("COMMENT :)"); }
[f][ \t]*[a-zA-Z]+                                          {printf("floatdcl id");} 
[i][ \t]*[a-zA-Z]+                                          {printf("intdcl id");} 
[a-zA-Z]+[ \t]*[=][ \t]*[0-9]+                              {printf("id assign inum");} 
[a-zA-Z]+[ \t]*[=][ \t]*[0-9]+[.][0-9]*                     {printf("id assign fnum"); }
[a-zA-Z]+[ \t]*[=][ \t]*[a-zA-Z]+[ \t]*[+][ \t]*[0-9]+      {printf("id assign id plus inum");}
[a-zA-Z]+[ \t]*[=][ \t]*[a-zA-Z]+[ \t]*[-][ \t]*[0-9]+      {printf("id assign id minus inum");}
[a-zA-Z]+[ \t]*[=][ \t]*[a-zA-Z]+[ \t]*[*][ \t]*[0-9]+      {printf("id assign id times inum");}  
[a-zA-Z]+[ \t]*[=][ \t]*[a-zA-Z]+[ \t]*[/][ \t]*[0-9]+      {printf("id assign id divided by inum");}    
[p][ \t]*[a-zA-Z]+                                          {printf("print id"); }
[\t]+    
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