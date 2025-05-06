%{
#include <stdio.h>
%}

%option noyywrap

%%
^\/\/.*            { printf("COMMENT\n"); } 
f                  { printf("float "); }
i                  { printf("int "); }
d                  { printf("double "); }
c                  { printf("char "); }
l                  { printf("long "); }
p                  { printf("print "); }
[a-zA-Z_]+         { printf("id "); }
[0-9]+             { printf("inum "); }
[0-9]+\.[0-9]+     { printf("fnum "); }
=                  { printf("assign "); }
\+                 { printf("plus "); }
\-                 { printf("minus "); }
\*                 { printf("mult "); }
\/                 { printf("div "); }
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