%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int yylex();
extern FILE* yyin;
void yyerror(const char *s);

#define MAX_VARIABLES 100

// Struct to hold variable info
struct variable {
    char name;
    int type; // 0 = int, 1 = float
    union {
        int ival;
        float fval;
    } val;
};

// Symbol table
struct variable variables[MAX_VARIABLES];
int num_variables = 0;

int find_variable_index(char var_name) {
    for (int i = 0; i < num_variables; i++) {
        if (variables[i].name == var_name) {
            return i;
        }
    }
    return -1; // Variable not found
}

void add_variable(char var_name, int var_type) {
    if (num_variables >= MAX_VARIABLES) {
        yyerror("Error: Maximum number of variables reached.\n");
        exit(EXIT_FAILURE);
    }

    if (find_variable_index(var_name) >= 0) {
        yyerror("Error: Variable already declared.\n");
        exit(EXIT_FAILURE);
    }

    variables[num_variables].name = var_name;
    variables[num_variables].type = var_type;
    num_variables++;
}

double get_variable_value(char var_name) {
    int var_index = find_variable_index(var_name);
    if (var_index >= 0) {
        if (variables[var_index].type == 0) {
            return (double)variables[var_index].val.ival;
        } else {
            return (double)variables[var_index].val.fval;
        }
    } else {
        yyerror("Error: Variable not found.\n");
        exit(EXIT_FAILURE);
    }
}

void set_variable_value(char var_name, double value) {
    int var_index = find_variable_index(var_name);
    if (var_index >= 0) {
        if (variables[var_index].type == 0) {
            variables[var_index].val.ival = (int)value;
        } else {
            variables[var_index].val.fval = (float)value;
        }
    } else {
        yyerror("Error: Variable not found.\n");
        exit(EXIT_FAILURE);
    }
}
%}

%union {
    float fval;
    int ival;
    char cval;
}

%token <fval> FLOAT
%token <ival> INTEGER
%token <cval> VARIABLE

%type <fval> expression term factor


%%

program:
    program statement
    | statement
    ;

statement:
    declaration
    | assignment
    | print
    ;

declaration:
    'i' VARIABLE     { add_variable($2, 0); }
    | 'f' VARIABLE     { add_variable($2, 1); }
    ;

assignment:
    VARIABLE '=' expression   {
      set_variable_value($1, $3);
    }
    ;

print:
    'p' VARIABLE {
      printf("%c = %f\n", $2, get_variable_value($2));
    }
    ;

expression:
    expression '+' term       { $$ = $1 + $3;}
    | expression '-' term     { $$ = $1 - $3; }
    | term
    ;

term:
    term '*' factor           { $$ = $1 * $3; }
    | term '/' factor         { $$ = $1 / $3; }
    | factor
    ;

factor:
    '(' expression ')'        { $$ = $2; }
    | FLOAT                   { $$ = $1; }
    | INTEGER                 { $$ = $1; }
    | VARIABLE {
        $$ = get_variable_value($1);
    }
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

    yyin = file; 
    yyparse();

    fclose(file);

    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
