%{
#include <stdio.h>
%}

    // Token definitions
%%
"//"[^\n]*         { printf("COMMENT\n"); }         // Match comments
"f"                { printf("floatdcl \n"); }     // Match float declarations
"i"                { printf("intdcl \n"); }       // Match integer declarations
"p"                { printf("print \n"); }        // Match print commands
[a-zA-Z][a-zA-Z0-9]* { printf("id "); }            // Match identifiers (no newline here)
"="                { printf("assign "); }           // Match assignment operator (no newline)
[0-9]+             { printf("inum\n"); }            // Match integers
[0-9]+\.[0-9]+     { printf("fnum\n"); }            // Match floating-point numbers
\+                 { printf("plus "); }             // Match the plus operator (no newline)
[ \t]+             { /* Ignore spaces and tabs */ } // Ignore spaces and tabs explicitly
\n                 { /* Ignore standalone newlines */ }
.                  { printf("Unrecognized token: %s\n", yytext); } // Handle unrecognized tokens

%%

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    yyin = file;
    yylex();
    fclose(file);
    return 0;
}

int yywrap() {
    return 1;
}
