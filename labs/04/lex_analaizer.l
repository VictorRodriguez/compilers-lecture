%option noyywrap
%{
/*Performing lexical Analysis of a COMMENT, an INTEGER, and a FLOAT */

#include <stdio.h> /*Para incluir la funcion de printf*/

%}

%%
\/\/[^\/].*	{ printf("COMMENT\n"); }
f	{ printf("floatdcl "); }
i	{ printf("intdcl "); }
=	{ printf("assign "); }
\+	{ printf("plus "); }
[0-9]+\.[0-9]+	{ printf("fnum\n"); }
[0-9]+	{ printf("inum\n"); }
[a-eg-hj-oq-z]	{ printf("id\n"); }
p	{ printf("print "); }
\/	{ printf("divide "); }	
\*	{ printf("times "); }	
\-	{ printf("minus "); }	

[ \t\n]+	;
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
