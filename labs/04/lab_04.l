%{
#include <stdio.h>
%}

%option noyywrap

%%
"//".*                  { printf("comment "); }
"f"                     { printf("floatdcl "); }
"i"                     { printf("intdcl "); }
"p"                     { printf("print "); }
"+"                     { printf("plus "); }
"-"                     { printf("minus "); }
"/"                     { printf("division "); }
"*"                     { printf("times "); }
"="                     { printf("assign "); }
[0-9]+                  { printf("integer "); }
[0-9]+"."[0-9]+         { printf("fnum "); }
[a-eghj-oq-z]           { printf("id "); }
[ \t]+                  /* ignore whitespace */
.                       /* ignore other characters */
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