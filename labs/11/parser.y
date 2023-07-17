%{
#include <stdio.h>
#define MAX_VARS 256

int yylex();
extern FILE* yyin;
void yyerror(const char *s);

// Struct to hold variable info
struct var_t {
    char name;
    int type; // 0 = int, 1 = float
    union {
        int ival;
        float fval;
    } val;
};

// Symbol table
struct var_t symbol_table[MAX_VARS];
int num_vars = 0;

int find_var(char name) {
    for (int i = 0; i < num_vars; i++) {
        if (symbol_table[i].name == name)
            return i;
    }
    return -1;
}

void add_var(char name, int type) {
    if (num_vars >= MAX_VARS) {
        yyerror("Symbol table is full");
        return;
    }
    if (find_var(name) >= 0) {
        yyerror("Variable already declared");
        return;
    }
    symbol_table[num_vars].name = name;
    symbol_table[num_vars].type = type;
    num_vars++;
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
%token INTEGER_TYPE FLOAT_TYPE PRINT

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
    INTEGER_TYPE VARIABLE     { add_var($2, 0); }
    | FLOAT_TYPE VARIABLE     { add_var($2, 1); }
    ;
  
assignment:
    VARIABLE '=' expression   {
      int var_index = find_var($1);
      if (var_index < 0) {
        char errorMsg[50];
        sprintf(errorMsg, "Variable '%c' not declared", $1);
        yyerror(errorMsg);
        return -1;
      }
      // Match types and assign are omitted
    }
    ;
  
print:
    PRINT VARIABLE {
      // Check if variable exists
      int var_index = find_var($2);
      if (var_index < 0) {
        char errorMsg[50];
        sprintf(errorMsg, "Variable '%c' not declared", $2);
        yyerror(errorMsg);
        return -1;
      }
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
        int var_index = find_var($1);
        if (var_index < 0) {
            char errorMsg[50];
            sprintf(errorMsg, "Variable '%c' not declared", $1);
            yyerror(errorMsg);
            return -1;
        }
        // Here you would handle the retrieval of the variable's value
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