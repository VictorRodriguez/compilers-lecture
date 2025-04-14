%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

double varvalue[26];
%}

%union {
    double dval;
    char sval;
}

%token <sval> NAME
%token <dval> NUMBER
%token FLOATDCL PRINT INTDCL
%type <dval> expression

%left '+' '-'
%left '*' '/'

%%

input:
    | input '\n'
    | input statement '\n'
    ;

statement: FLOATDCL NAME        
    | INTDCL NAME
    | NAME '=' expression       { varvalue[$1 - 'a'] = $3; }
    | PRINT NAME                { printf("%f\n", varvalue[$2 - 'a']); }
    ;

expression:
      expression '+' expression   { $$ = $1 + $3; }
    | expression '-' expression   { $$ = $1 - $3; }
    | expression '*' expression   { $$ = $1 * $3; }
    | expression '/' expression   { $$ = $1 / $3; }
    | '(' expression ')'          { $$ = $2; }
    | NUMBER                      { $$ = $1; }
    | NAME                        { $$ = varvalue[$1 - 'a']; }
    ;

%%

int main(int argc, char **argv) {
    FILE *fd;

    if (argc == 2) {
        if (!(fd = fopen(argv[1], "r"))) {
            perror("Error: ");
            return -1;
        }
        yyset_in(fd);
        yyparse();
        fclose(fd);
    } else {
        printf("Usage: %s filename\n", argv[0]);
    }
    return 0;
}
