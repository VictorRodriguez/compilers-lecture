%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int type;   // INT or FLOAT
    char* name;  // Variable name
    double value; // Variable value
} Variable;

#define MAX_VARIABLES 100
Variable variables[MAX_VARIABLES];
int numVariables = 0;

void yyerror(const char *s);
int yylex();
double yylval_number;  // For passing numeric values from lexer to parser
%}

%union {
    char* sval;
}

%token <sval> ID
%token INT FLOAT ASSIGN PLUS MINUS MULT DIV LPAREN RPAREN EOL PRINT

%type <sval> expression term factor

%%

program:
    program statement EOL
    |
    /* empty */

statement:
    INT ID ASSIGN expression { addVariable(INT, $2, yylval_number); }
    | FLOAT ID ASSIGN expression { addVariable(FLOAT, $2, yylval_number); }
    | PRINT ID { printVariable($2); }
    | ID ASSIGN expression { updateVariable($1, yylval_number); }
    | expression { printResult(yylval_number); }

expression:
    expression PLUS term { $$ = $1 + $3; }
    | expression MINUS term { $$ = $1 - $3; }
    | term { $$ = $1; }

term:
    term MULT factor { $$ = $1 * $3; }
    | term DIV factor { $$ = $1 / $3; }
    | factor { $$ = $1; }

factor:
    LPAREN expression RPAREN { $$ = $2; }
    | INT { $$ = yylval_number; }
    | FLOAT { $$ = yylval_number; }
    | ID { $$ = getVariableValue($1); }

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}

void addVariable(int type, char* name, double value) {
    if (numVariables < MAX_VARIABLES) {
        variables[numVariables].type = type;
        variables[numVariables].name = strdup(name);
        variables[numVariables].value = value;
        numVariables++;
    } else {
        fprintf(stderr, "Error: Maximum number of variables reached.\n");
        exit(EXIT_FAILURE);
    }
}

void updateVariable(char* name, double value) {
    for (int i = 0; i < numVariables; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            variables[i].value = value;
            return;
        }
    }
    fprintf(stderr, "Error: Variable '%s' not found.\n", name);
    exit(EXIT_FAILURE);
}

double getVariableValue(char* name) {
    for (int i = 0; i < numVariables; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            return variables[i].value;
        }
    }
    fprintf(stderr, "Error: Variable '%s' not found.\n", name);
    exit(EXIT_FAILURE);
}

void printResult(double result) {
    for (int i = 0; i < numVariables; i++) {
        if (variables[i].name[0] == 'p') {
            printf("%s = %f\n", variables[i].name, variables[i].value);
        }
    }
    printf("Result: %f\n", result);
}

void printVariable(char* name) {
    for (int i = 0; i < numVariables; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            printf("%s = %f\n", variables[i].name, variables[i].value);
            return;
        }
    }
    fprintf(stderr, "Error: Variable '%s' not found.\n", name);
    exit(EXIT_FAILURE);
}
