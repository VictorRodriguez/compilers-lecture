%
{

#include <stdio.h>

%
}

%%

\/\/(.*)
^f                                                      {printf("floatdcl");}
^i                                                      {printf("intdcl");}
^p                                                      {printf("print");}
[ \t]=[ \t]                                             {printf(" assign ");}
[ \t]\+[ \t]                                            {printf(" plus ");}
[ \t]\-[ \t]                                            {printf(" minus ");}
[ \t]\*[ \t]                                            {printf(" multiply ");}
[ \t]\/[ \t]                                            {printf(" divide ");}
[a-z]*                                                  {printf("id");}
-?[0-9]+                                                {printf("inum");}
-?(([0-9]+)|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)         {printf("fnum");}
\n                                                      {printf("\n");}
\t                                                      {printf("\t");}

%%

int main(int argc, char* argv[])
{
  // open a file handle to a particular file:
  FILE *myfile = fopen(argv[1], "r");
  
  // make sure it's valid:
  if (!myfile) 
  {
    printf("Couldnt open the file!");
    return -1;
  }
  
  // set lex to read from it instead of defaulting to STDIN:
  yyin = myfile;

  // lex through the input:
  while(yylex());
  fclose(myfile);
}