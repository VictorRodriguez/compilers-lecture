%{
#include <stdio.h>
%}


%%
"i"             {printf("int");}
"f"             {printf("float");}
"p"             {printf("print");}
[0-9]+\.[0-9]+  {printf("fnum");}
[0-9]+          {printf("inum");}
[a-zA-Z]*       {printf("id");}
"="             {printf("assign");}
"-"             {printf("minus");}
"+"             {printf("plus");}
"*"             {printf("mult");}
"/"             {printf("div");}
"\n "           {printf("NewL");}
[\t]+           {/*ignore*/}
\/\/[^\n]*	{printf("comentario");}

%%
FILE* outputFile;
int main(int argc, char* argv[]) {
    // Open the output file
    outputFile = fopen("lex.out", "w");
    if (!outputFile) {
        printf("Couldn't open the output file!");
        return -1;
    }

    // open a file handle to a particular file
    FILE* myfile = fopen(argv[1], "r");

    // make sure it's valid
    if (!myfile) {
        printf("Couldn't open the file!");
        return -1;
    }

    // set lex to read from it instead of defaulting to STDIN
    yyin = myfile;

    // lex through the input
    while (yylex());

    // close the input file
    fclose(myfile);

    // Close the output file
    fclose(outputFile);

    return 0;
}
int ywrap(){
        return 1;
}

