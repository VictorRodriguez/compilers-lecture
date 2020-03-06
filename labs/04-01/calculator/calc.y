%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int ids[26];
int values[26];
extern FILE *yyin;
%}

%token ID NUMBER
%left '+' '-'
%left '*' '/'
%%

start: statement
  | statement start
  ;

statement: ID '=' expression              { ids[$1] = $3;}
 | 'p' ID                                 { if(values[$2] != 0) printf("%d\n", ids[$2]); else yyerror("syntax error");}
 | 'i' ID                                 { values[$2] = 1;}
 | expression
 ;

expression: expression '+' expression   			{ $$ = $1 + $3;}
 | expression '-' expression           				{ $$ = $1 - $3;}
 | expression '*' expression                  { $$ = $1 * $3;}
 | expression '/' expression                  { if($3 != 0) $$ = $1 / $3; else yyerror("syntax error");}
 | NUMBER                              				{ $$ = $1;}
 | ID                                     { $$ = ids[$1];}
 ;
%%


int main(argc,argv)
int argc ;
char **argv;
{
       if (argc > 1) {
               FILE *file;

               file = fopen(argv[1], "r" ) ;
               if (!file) {
                       fprintf(stderr,"could not open %s\n",argv[1]);
                       exit(1);
               }
               yyin = file;
       }
       do {
               yyparse();
       } while (!feof(yyin));
       return 0;
}

int yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}
int yywrap()
{
  return(1);
}