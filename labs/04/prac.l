%{
#include <stdio.h>
%}

%%
(\/\/).*  { printf("COMMENT: %s\n", yytext); }
(p)     { printf("PRINT: %s\n", yytext); }
(i)     { printf("INTDCL: %s\n", yytext); }
(f)     { printf("FLOATDCL: %s\n", yytext); }
(\+)    { printf("PLUS: %s\n", yytext); }
(\-)    { printf("MINUS: %s\n", yytext); }
(\/)    { printf("DIVIDE: %s\n", yytext); }
(\*)    { printf("MULTIPLY: %s\n", yytext); }
(=)     { printf("EQUALS: %s\n", yytext); }
[+-]?[0-9]+                 { printf("INUM: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*      { printf("ID: %s\n", yytext); }
[+-]?[0-9]+.[0-9]*          { printf("FNUM: %s\n", yytext); }
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
