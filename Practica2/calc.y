%{
#include <stdio.h>
int yylex();
void yyerror(const char* s);
%}

%token DIGIT
%token LETTER
%left '+' '-'
%left '*' '/'
%left UMINUS

%%

calc: expr '\n' { printf("%d\n", $1); }
     | calc expr '\n' { printf("%d\n", $2); }

expr:
    expr '+' expr   { $$ = $1 + $3; }
  | expr '-' expr   { $$ = $1 - $3; }
  | expr '*' expr   { $$ = $1 * $3; }
  | expr '/' expr   { if ($3 != 0) $$ = $1 / $3; else yyerror("Division by zero"); }
  | '-' expr %prec UMINUS { $$ = -$2; }
  | '(' expr ')'    { $$ = $2; }
  | DIGIT           { $$ = $1; }
  | LETTER          { $$ = $1; }
  ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}

