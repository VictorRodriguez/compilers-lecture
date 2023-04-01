%{
#include <stdio.h>
#include <stdlib.h>
%}

%%

[0-9]+ 	{printf("inum");}
[0-9]+"."[0-9]{1,5}	{printf("fnum");}

"i"	{printf("intdcl");}
"f"	{printf("floatdcl");}
"p"	{printf("print");}

[a-z]	{printf("id");}

"="	{printf("assign");}
"+"	{printf("plus");}

%%

int main(int argc, char** argv){
	FILE* input = fopen(argv[1], "r");

	yyin = input;
	yylex();
	fclose(input);
	return 0;
}