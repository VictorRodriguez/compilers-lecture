%{
#include <stdio.h>
extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);
%}

%token  ARTICLE NOUN VERB PREP EOL
%%
START:	
     |START SENTENCE;

SENTENCE: NOUN-PHRASE VERB-PHRASE EOL  {printf("PASS\n");} 
		| error EOL {printf("FAIL\n"); yyerrok; }

NOUN-PHRASE: CMPLX-NOUN
	     | CMPLX-NOUN PREP-PHRASE

VERB-PHRASE: CMPLX-VERB
	     | CMPLX-VERB PREP-PHRASE 

PREP-PHRASE: PREP CMPLX-NOUN

CMPLX-NOUN: ARTICLE NOUN 

CMPLX-VERB: VERB
	    | VERB NOUN-PHRASE

%%
int main(int argc, char **argv) {

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        fprintf(stderr, "ERROR, FILE NOT FOUND ...\n");
        return 1;
    }

    yyin = file;
    yyparse();
    fclose(file);

    return 0;
}

void yyerror(const char *s){
}
