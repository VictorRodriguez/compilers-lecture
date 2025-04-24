/*
José Guerrero
A01285612
Act2
21/01/2024
*/


/* 
This code does looks correct on my grammar managment but
doesnt pass my test cases in example3.ac and example2.ac. 
Ex:
1.- i i
2.- f = 35
3.- p i
*/


%{
#include <stdio.h>
%}


%%
"//".*                                          {printf("COMMENT");}
"f"                                             {printf("floatdcl");}
"i"                                             {printf("intdcl");}
"p"                                             {printf("print");}
    

[a-eg-hj-oq-zA-Z][a-eg-hj-oq-zA-Z0-9]*    		{printf("id");}

[0-9]+                                          {printf("inum");}
[0-9]+[.][0-9]*                                 {printf("fnum");}

"="                                             {printf("assign");}
"+"                                             {printf("plus");}
"-"                                             {printf("minus");}
"*"                                             {printf("times");}
"/"                                             {printf("divided by");}
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