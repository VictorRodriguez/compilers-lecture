{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token ARTICLE NOUN VERB PREP
%%

INPUT : 
 | INPUT SENTENCE
 ;

SENTENCE: NOUN_PHRASE VERB_PHRASE                       { printf("PASS\n"); }
 ;

NOUN_PHRASE: CMPLX_NOUN  | CMPLX_NOUN PREP_PHRASE;

VERB_PHRASE: CMPLX_VERB  | CMPLX_VERB PREP_PHRASE;

PREP_PHRASE: PREP CMPLX_NOUN;

CMPLX_NOUN: ARTICLE NOUN;

CMPLX_VERB: VERB         | VERB NOUN_PHRASE;

%%

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;

int main(int argc, char* argv[]){
  // open a file handle to a particular file:
  FILE *myfile = fopen(argv[1], "r");
  // make sure it's valid:
  if (!myfile) {
    printf("Couldnt open the file!");
    return -1;
  }
  // set lex to read from it instead of defaulting to STDIN:
  yyin = myfile;

  // lex through the input:
    do {
        yyparse();
    } while (!feof(yyin));

  fclose(myfile);
}

void yyerror(const char *s) {
    printf("FAIL\n");
}