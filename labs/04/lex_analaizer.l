%{
#include <stdio.h>
%}


%%

\/\/.*              { printf("COMMENT\n"); }
"f"                 { printf("floatdcl "); }
"i"                 { printf("intdcl "); }
"p"                 { printf("print "); }
"="                 { printf("assign ");}
"+"                 { printf("plus ");}
[0-9]+              { printf("inum \n");}
[0-9]*"."[0-9]+     { printf("fnum \n"); }
[a-zA-Z]+           { printf("id ");}
[ \t\n]+            /* ignore whitespace and line breaks */;
.                   { printf("UNKNOWN \n"); } 


%%


int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Error to open the file");
            return 1;
        }
        yyin = file;  // Flex
    }
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
