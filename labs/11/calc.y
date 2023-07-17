%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

extern FILE* yyin; // Declare yyin to read from a file

int yylex();
void yyerror(const char *s);

#define MAX_VARIABLES 100
struct variable {
    char* name;
    double value;
};
struct variable variables[MAX_VARIABLES];
int num_variables = 0;

double find_variable_value(char* var_name) {
    for (int i = 0; i < num_variables; i++) {
        if (strcmp(var_name, variables[i].name) == 0) {
            return variables[i].value;
        }
    }
    return fprintf("Error: variable not found: %s", var_name); // Variable not found, return 0 as default value
}

void set_variable_value(char* var_name, double value) {
    for (int i = 0; i < num_variables; i++) {
        if (strcmp(var_name, variables[i].name) == 0) {
            variables[i].value = value;
            return;
        }
    }

    // Variable not found, create a new entry
    if (num_variables < MAX_VARIABLES) {
        variables[num_variables].name = strdup(var_name);
        variables[num_variables].value = value;
        num_variables++;
    } else {
        fprintf(stderr, "Error: Maximum number of variables reached.\n");
        exit(EXIT_FAILURE);
    }
}
%}

%union {
 double dval;
 char* sval;
 }

%token <dval> NUMBER
%token <sval> IDENTIFIER

%type <dval> expression

%%

statement: IDENTIFIER '=' expression { set_variable_value($1, $3); }
 | 'i' IDENTIFIER { set_variable_value($2, 0); printf("entramos"); }
 | 'f' IDENTIFIER { set_variable_value($2, 0); }
 | 'p' IDENTIFIER { printf("%f\n", find_variable_value($2)); }s
 ;

expression: expression '+' expression   { $$ = $1 + $3; }
 | expression '-' expression            { $$ = $1 - $3; }
 | expression '*' expression            { $$ = $1 * $3; }
 | expression '/' expression            { $$ = $1 / $3; }
 | '(' expression ')'                   { $$ = $2; }
 | NUMBER                               { $$ = $1; }
 | IDENTIFIER                           { $$ = find_variable_value($1); }
 ;

%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (!file) {
        fprintf(stderr, "Error: Unable to open the input file.\n");
        return 1;
    }

    yyin = file; // Set the lexer input to read from the file

    yyparse(); // Start parsing

    fclose(file);

    return 0;
}


void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
