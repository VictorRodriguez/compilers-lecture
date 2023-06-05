%}



%token NOUN PLOX AND THEN MOVE COMMA BLOCKS AHEAD TURN DEGREES END



%%



sentences:

		        | sentences END

		        ;



sentence: 		NOUN performance END		      

			| error END 

			;



move: 	 		MOVE NUMBER BLOCKS AHEAD             

			| TURN DEGREES  

			|               

			;



performance: 		PLOX move conjuction move mix move

		        | PLOX move conjuction move

		        |

		        ;





mix:  			AND THEN

		        | COMMA THEN

		        |

		        ;



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

    

}