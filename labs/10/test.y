%{
# include <stdio.h>
int yylex();
void yyerror(cost char *s);
%}

%token ARTICLE NOUN VERB PREP

%%

sentence: noun_phrase verb_phrase {printf ("PASS \n");}
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