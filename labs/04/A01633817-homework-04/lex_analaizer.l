%{
#include <stdio.h>
%}

%%
"//".*                             { printf("COMMENT\n"); }
f[ \t]+[a-z]                      { printf("floatdcl id\n"); }
i[ \t]+[a-z]                      { printf("intdcl id\n"); }
[a-z][ \t]*=[ \t]*[0-9]+         { printf("id assign inum\n"); }
[a-z][ \t]*=[ \t]*[a-z][ \t]*\+[ \t]*[0-9]+\.[0-9]+ { printf("id assign id plus fnum\n"); }
p[ \t]+[a-z]                      { printf("print id\n"); }
[ \t\n]+                          { /* ignora whitespace */ }
.                                 { /* ignora todo lo demas */ }
%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("File opening failed");
            return 1;
        }
        yyin = file;
    }
    yylex();
    return 0;
}

