%{
#include <stdio.h>
%}


%%
[0-9]+                  printf("inum ");
[0-9]+"."[0-9]          printf("fnum ");
[a-eg-hj-oq-z]          printf("id ");   // Exeptua 'f','i' y 'p'

f                       printf ("floatdcl ");
i                       printf ("intdcl ");
p                       printf ("print ");

\=                      printf ("assign "); 
\+                      printf ("plus ");

\/\/[^\n]*              printf("COMMENT ");
[ \t] ; 		/* ignore whitespace */;

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
