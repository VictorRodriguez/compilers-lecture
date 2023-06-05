%{
#include <stdio.h>
int yylex();
void yyerror(const char* s);
%}

%token PLEASE AND ACTION DIRECTION NUMBER UNIT

%%

program : magic inslist          { printf("Valid instruction\n"); }
        ;

inslist : movins
        | movins conjunction movins
        ;

magic : PLEASE
      ;

conjunction : AND
            ;

movins : action direction number unit
       ;

action : ACTION
       ;

direction : DIRECTION
          ;

number : NUMBER
       ;

unit : UNIT
     ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Syntax error: %s\n", s);
}

#include <stdio.h>
#include "lex.yy.c" // Include the generated Lex file

extern FILE* yyin;

int main(int argc, char* argv[]) {
    if (argc > 1) {
        FILE* file = fopen(argv[1], "r");
        if (file == NULL) {
            perror("Error opening file");
            return 1;
        }
        yyin = file;
    } else {
        yyin = stdin;
    }

    yyparse();

    return 0;
}
