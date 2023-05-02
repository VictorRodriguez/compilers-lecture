%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}


%token ARTICLE NOUN VERB PREP
%%

input : 
 | input sentence
 ;

sentence: noun_phrase verb_phrase {printf("PASS\n");}
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

#include <stdio.h>
#include <stdlib.h>

// stuff from lex that yacc needs to know about:
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