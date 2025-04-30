%{
    #include <stdio.h>
%}

%option noyywrap
%option outfile="Lexer.c"

%%

\/\/.*\n { printf("COMMENT\n"); }
"f" { printf("floatdcl"); }
"i" { printf("intdcl"); }
"p" { printf("print"); }
[a-zA-Z]+ { printf("id"); }
\= { printf("assign"); }
\+ { printf("plus"); }
\- { printf("minus"); }
\* { printf("times"); }
\/ { printf("divide"); }
[0-9]+ { printf("inum"); }
[0-9]+\.[0-9]+ { printf("fnum"); }

\n { printf("\n"); }
\t|\r|\f|\v { /* ignore whitespace */ }

%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}


