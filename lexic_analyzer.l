%{
//Libreria requerida para codigo en C
#include <stdio.h>
%}

%%

\/\/(.*)
^f {printf("floatdcl");}
^i {printf("intdcl");}
^p {printf("print");}

"="  {printf(" assign ");}
"\+" {printf(" plus ");}
"\-" {printf(" minus ");}
"\*" {printf(" multiply ");}
"\/" {printf(" divide ");}

[a-eg-hj-oq-z]* {printf("id");}
-?[0-9]+ {printf("inum");}
-?[0-9]+\.[0-9]+ {printf("fnum");}

\n {printf("\n");}

%%
//Codigo en C para abrir el archivo y leerlo
   int main(int argc, char* argv[]){

   FILE *test = fopen(argv[1], "r");
//Validacion
   if (!test) {
     printf("Error:Could not open the file");
     return -1;
                }

          yyin = test;

          while(yylex());

          fclose(test);

     return 0;
}