/*Miguel Angel Cabrera Victoria*/
/*<A01782982@tec.mx>*/
/*LAB-03*/

%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
void yyerror(const char *s) {
    printf("FAIL\n" );
}
extern FILE *yyin;
%}

%token ARTICLE NOUN VERB PREP EOL
%start SENTENCES

%%

SENTENCES: /* EMPTY */ | SENTENCES SENTENCE

SENTENCE: NOUN_PHRASE VERB_PHRASE EOL { printf("PASS\n"); }
        | NOUN_PHRASE EOL { printf("PASS\n"); }
        | VERB_PHRASE EOL { printf("PASS\n"); }

NOUN_PHRASE: ARTICLE NOUN| ARTICLE NOUN PREP_PHRASE;

VERB_PHRASE: VERB| VERB NOUN_PHRASE;

PREP_PHRASE: PREP NOUN_PHRASE;

%%

int main(int argc, char **argv) {
  if (argc != 2) {
    fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
    exit(1);
  }

  FILE *file = fopen(argv[1], "r");
  if (!file) {
    perror(argv[1]);
    exit(1);
  }

  yyin = file;
  yyparse();
  fclose(file);

  return 0;
}
