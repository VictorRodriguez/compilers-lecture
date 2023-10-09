%{
#include <stdio.h>
%}

%%
i                       printf("intdcl ");
f                       printf("floatdcl ");
p                       printf("print ");
[+-]?[0-9]+             printf("inum ");
[+-]?[0-9]*\.[0-9]{1,5} printf("fnum ");
[a-z]                   printf("id ");
\+                      printf("plus ");
\-                      printf("minus ");
\*                      printf("multiply ");
\/                      printf("divide ");
\=                      printf("assign ");
\/\/.*                  /* ignore comment */;
[ \t]+                  /* ignore whitespace */;
.                       printf("error ");
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

/*
To compile: lex lexic_analyzer.l && gcc lex.yy.c -o lexic_analyzer -ll
To run: python code_generator.py > input && echo "~~~INPUT~~~" && cat input && cat input | ./lexic_analyzer > output && echo "~~~OUTPUT~~~" && cat output && rm input output
    with only file output: python code_generator.py --stress > random_code.ac && cat random_code.ac | ./lexic_analyzer > output
*/