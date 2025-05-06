%{
/* Definitions */
#include <stdio.h>
#include <time.h>

int yywrap(void) {
    return 1; // Indicate end of input
}

/* Global variables */
int lineno = 1;

/* Function declarations */
void yyerror(char *s);

%}

/* Regular expressions */
%%
"//".*                  { printf("COMMENT\n"); }
[ \t]+                  { /* Ignore whitespace */ }
"print"                 { printf("print "); }
"f"                     { printf("floatdcl "); }
"i"                     { printf("intdcl "); }
[a-z][a-z0-9]*          { printf("id "); }
[0-9]+\.[0-9]*         { printf("fnum "); }
[0-9]+                  { printf("inum "); }
"="                     { printf("assign "); }
"+"                     { printf("plus "); }
"-"                     { printf("minus "); }
"*"                     { printf("times "); }
"/"                     { printf("divided by "); }
";"                     { /* Ignore semicolons */ }
[\n]                    { lineno++; printf("NEWLINE\n"); }
.                       { yyerror("Invalid character"); }

%%

/* Error handling function */
void yyerror(char *s) {
    fprintf(stderr, "Error on line %d: %s\n", lineno, s);
}

/* Main function */
int main() {
    yylex(); // Start the lexical analysis

    // Generate txt file with time elapsed to complete the analysis
    clock_t start_time, end_time;
    double elapsed_time;

    start_time = clock();  // Record start time
    yylex();               // Start lexical analysis
    end_time = clock();    // Record end time

    elapsed_time = ((double) (end_time - start_time)) / CLOCKS_PER_SEC;
    FILE *time_file = fopen("analysis_time.txt", "w");
    if (time_file == NULL) {
        // Handle file opening error
        fprintf(stderr, "Error opening file for writing.\n");
        return 1;
    }

    fprintf(time_file, "Time taken to analyze: %f seconds\n", elapsed_time);
    fclose(time_file);

    return 0;
}


/*

Ejecucion:
lex lexic_analyzer.l (the lex code you generate in your homework)
gcc lex.yy.c -o lexical_scan
./lexical_scan <source code for ac language like example.ac>

Randon ac file generator
python3 code_generator.py --stress
*/