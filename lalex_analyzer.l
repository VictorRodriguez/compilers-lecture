%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap

%%

[ \t]+                  
\n                      { printf("\n ");}

"f"                    { printf("floatdcl "); }
"i"                    { printf("intdcl "); }
[0-9]+                  { printf("inum "); } 
[0-9]+(\.[0-9]+)?       { printf("fnum "); }
"+"                     { printf("plus "); }
"="                    { printf("assign "); }
"p"                    { printf("print "); }
[a-zA-Z_][a-zA-Z0-9_]*  { printf("id "); }

%%

int main(int argc, char** argv) {
    
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
