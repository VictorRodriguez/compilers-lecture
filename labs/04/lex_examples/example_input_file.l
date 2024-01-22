%{
#include <stdio.h>
%}

%%

"//"[^"\n"]*                        { printf("COMMENT\n"); }
"f "([a-z])                         { printf("floatdcl id\n"); }
"i "([a-z])                         { printf("intdcl id\n"); }
([a-z])" = "([0-9]+)                { printf("id assign inum\n"); }
([a-z])" = "([a-z])" "([+\-*/])" "([0-9]+) { printf("id assign id plus fnum\n"); }
"p "([a-z])                         { printf("print id\n"); }
\n                                  { /* ignore newlines */ }
[ \t]+                              { /* ignore whitespace */ }
.                                   { /* ignore other characters */ }

%%

int main(int argc, char **argv) {
    FILE *fd;

    if (argc != 2) {
        printf("Usage: %s filename\n", argv[0]);
        return 1;
    }

    fd = fopen(argv[1], "r");
    if (!fd) {
        perror("Error opening file");
        return 1;
    }

    yyin = fd;
    yylex();

    fclose(fd);
    return 0;
}
