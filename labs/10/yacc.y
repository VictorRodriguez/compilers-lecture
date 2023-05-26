%{
#include <stdio.h>
extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);
%}

%token ARTICLE NOUN VERB PREP EOL

%%

sentence_list: /* empty */
             | sentence_list sentence
             ;

sentence: noun_phrase verb_phrase EOL { printf("PASS\n"); }
        | error EOL { printf("FAIL\n"); yyerrok; }
        ;

noun_phrase: complex_noun
           | complex_noun prep_phrase
           ;

verb_phrase: VERB noun_phrase_opt
           ;

noun_phrase_opt: /* empty */
               | noun_phrase
               ;

prep_phrase: PREP complex_noun
           ;

complex_noun: ARTICLE NOUN
          ;

%%
int main(int argc, char **argv) {

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        fprintf(stderr, "Error en archivo: %s\n", argv[1]);
        return 1;
    }

    yyin = file;
    yyparse();
    fclose(file);

    return 0;
}

void yyerror(const char *s) {
}
