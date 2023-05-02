%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(const char *s);
%}

%code requires {
    #include "y.tab.h"
}

%token ARTICLE NOUN VERB PREP


%%
sentence: noun_phrase verb_phrase
        ;

noun_phrase: cmplx_noun
           | cmplx_noun prep_phrase
           ;

verb_phrase: cmplx_verb
           | cmplx_verb prep_phrase
           ;

prep_phrase: PREP cmplx_noun
           ;

cmplx_noun: ARTICLE NOUN
          ;

cmplx_verb: VERB
          | VERB noun_phrase
          ;

%%
extern int yylex(void);
extern int yyparse(void);
extern FILE *yyin;

void yyerror(const char *s) {
}

int main(int argc, char *argv[]) {
    FILE *fp;
    if (argc != 2) {
        fprintf(stderr, "Usage: %s filename\n", argv[0]);
        exit(1);
    }
    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        perror(argv[1]);
        exit(1);
    }
    yyin = fp;
    int result;
    while ((result = yyparse()) == 0) {
        printf("Pass: The sentence is well-formed\n");
    }
    if (result != 0) {
        printf("Fail: The sentence is not well-formed\n");
    }
    fclose(fp);
    return result;
}








