%{
#include <stdio.h>
#include <stdlib.h>
extern int yylval;
%}

%token ARTICLE NOUN VERB PREP
%start SENTENCE
%%

SENTENCE : NOUN_PHRASE VERB_PHRASE NOUN_PHRASE
 	{  printf("valid sentence"); }
 	;
 	
NOUN_PHRASE	: CMPLX_NOUN
		| CMPLX_NOUN PREP_PHRASE
		;
VERB_PHRASE	: CMPLX_VERB
		| CMPLX_VERB PREP_PHRASE
		;
PREP_PHRASE 	: PREP CMPLX_NOUN
		;
CMPLX_NOUN 	: ARTICLE NOUN
		;
CMPLX_VERB	: VERB
		| VERB NOUN_PHRASE
		;
%%
/*
int main(int argc, char* argv[]){
	FILE* inputFile;
	
	if(argc != 2){
		fprintf(stderr, "usage: %s input_file", argv[0];
	}	
	inputFile = fopen(argv[1], "r");
	if (inputFile == NULL){
		perror("error opening file");
		return 1;
	}
	if(argc > 0){
		printf("hola");
	}
	
	yyin = inputFile;
	yyparse();
	
	fclose(inputFile);
	return 0;
}*/
/*
int main (void) {
	yyparse();
	printf("entering main of yacc");
	return 0;
}	
*/
