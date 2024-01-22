%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
extern FILE* yyin;
%}

%union {
 double dval;
 char *sval;
 }


%token <dval> FLOAT
%token <dval> INTEGER
%token <sval> TYPE
%token <sval> ID
%token <sval> PRINT
%token <sval> COMMENT
%%

instruction: reserved
| statement
| COMMENT
;
reserved: TYPE ID                {printf("Valid expression declaration \n");}
| PRINT ID                 {printf("Valid expression print \n");}
;
statement: ID '=' expression		{printf("Valid expression, assignment \n");}
;
expression: number '+' number
| number '-' number
| number '*' number
| number '/' number
| number
 ;
number: FLOAT
| INTEGER
| ID
;

%%
int main(int argc, char **argv) {
    FILE    *fd;

    if (argc == 2)
    {
        if (!(fd = fopen(argv[1], "r")))
        {
            perror("Error: ");
            return (-1);
        }
        yyin = fd;
        yyparse();
        fclose(fd);
    }
    else
        printf("Usage: ./lex_analaizer filename\n");
    return (0);
}
