%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern char* yytext;
extern FILE* yyin;

//void yyerror(char *s);

int pass = 1;

int main(int argc, char **argv) {
    // Código de tu programa aquí
    return 0;
}

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}

%}

%token NOUN VERB ARTICLE PREPOSITION DELIMITER

%union {
    char *str;
}

%%

sentence:
    noun_phrase verb_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase noun_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase preposition_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase noun_phrase preposition_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase noun_phrase verb_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase noun_phrase preposition_phrase verb_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase preposition_phrase noun_phrase verb_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase preposition_phrase noun_phrase preposition_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase noun_phrase preposition_phrase noun_phrase verb_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase noun_phrase preposition_phrase noun_phrase preposition_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase noun_phrase verb_phrase preposition_phrase noun_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase noun_phrase verb_phrase preposition_phrase preposition_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase noun_phrase preposition_phrase verb_phrase noun_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase preposition_phrase verb_phrase noun_phrase preposition_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase noun_phrase preposition_phrase verb_phrase noun_phrase preposition_phrase DELIMITER { printf("PASS\n"); }
    | noun_phrase verb_phrase preposition_phrase noun_phrase preposition_phrase verb_phrase noun_phrase DELIMITER { printf("PASS\n"); }
    ;

noun_phrase:
    complex_noun { }
    | complex_noun preposition_phrase { }
    ;

complex_noun:
    article noun { }
    ;

verb_phrase:
    complex_verb { }
    | complex_verb preposition_phrase { }
    ;

complex_verb:
    verb { }
    | verb noun_phrase { }
    ;

preposition_phrase:
    preposition complex_noun { }
    ;

noun:
    NOUN { }
    ;

verb:
    VERB { }
    ;

article:
    ARTICLE { }
    ;

preposition:
   

