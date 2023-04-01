%{
#include <stdio.h>
%}

%%
\/\/(.*)
[0-9]+                  printf("inum");
[0-9]+(\.[0-9]+)?       printf("fnum");
[a-z]*                  printf("id");
["f"]                   printf("floatdcl");
["i"]                   printf("intdcl");
["p"]                   printf("print");
["="]                   printf("assign");
["+"]                   printf("add");
["-"]                   printf("substract");
["*"]                   printf("multiply");
["/"]                   printf("divide");

%%

int main(int argc, char** argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }
    FILE* input_file = fopen(argv[1], "r");
    if (input_file == NULL) {
        fprintf(stderr, "Error: could not open file '%s'\n", argv[1]);
        return 1;
    }

    yyin = input_file;

    yylex();

    fclose(input_file);
    return 0;
}
