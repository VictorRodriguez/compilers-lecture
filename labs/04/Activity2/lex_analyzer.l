%{
#include <stdio.h>
%}

%%

[//][a-zA-Z][a-zA-Z0-9]*                                    {printf("COMMENT :)\n"); }
[f][ \t]*[a-zA-Z]+                                          {printf("floatdcl id\n");} 
[i][ \t]*[a-zA-Z]+                                          {printf("intdcl id\n");} 
[a-zA-Z]+[ \t]*[=][ \t]*[0-9]+                              {printf("id assign inum\n");} 
[a-zA-Z]+[ \t]*[=][ \t]*[0-9]+[.][0-9]*                     {printf("id assign fnum\n"); }
[a-zA-Z]+[ \t]*[=][ \t]*[a-zA-Z]+[ \t]*[+][ \t]*[0-9]+      {printf("id assign id plus inum\n");}
[a-zA-Z]+[ \t]*[=][ \t]*[a-zA-Z]+[ \t]*[-][ \t]*[0-9]+      {printf("id assign id minus inum\n");}
[a-zA-Z]+[ \t]*[=][ \t]*[a-zA-Z]+[ \t]*[*][ \t]*[0-9]+      {printf("id assign id times inum\n");}  
[a-zA-Z]+[ \t]*[=][ \t]*[a-zA-Z]+[ \t]*[/][ \t]*[0-9]+      {printf("id assign id divided by inum\n");}    
[p][ \t]*[a-zA-Z]+                                          {printf("print id\n"); }
[\t]+                                                       {/* ignore whitespace */ ;}

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