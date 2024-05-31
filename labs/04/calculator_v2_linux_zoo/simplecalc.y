%{
#include <stdio.h>
int yylex();
 void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
%}


%token NAME NUMBER
%%

statement: NAME '=' expression          {printf("%c = %d\n", $1,$3);}
 | expression                                           {printf("= %d\n", $1);}
 ;
expression: expression '+' NUMBER   { $$ = $1 + $3;}
 | expression '-' NUMBER            { $$ = $1 - $3;}
 | expression '*' NUMBER            { $$ = $1 * $3;}
 | '(' expression ')'                           {$$ = $2;}
 | NUMBER                           {$$ = $1;}
 ;

%%

int main(){
        yyparse();
        return 0;
}
