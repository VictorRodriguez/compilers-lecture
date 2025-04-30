%{
#include <stdio.h>
%}

%%
"//".                       printf("COMMENT\n ");
"f"                         printf("floatdcl ");
"i"                         printf("intdcl ");
[a-zA-Z]+                   printf("id\n");
[1-9][0-9]*\.[0-9]+         printf("fnum\n");
[1-9][0-9]*                 printf("inum\n");
"p"                         printf("print ");
"-"                         printf("minus ");
"="                         printf("assign ");
"+"                         printf("plus ");
"/"                         print("divide " )
"*"                         print ("multiply ")
[ \t\n]+			{ /* empty spaces */ }
.					{ printf("UNKOWN CHAR '%s'\n", yytext); }
%%

int main(int argc, char **argv) {
	if(argc > 1) {
		FILE *file = fopen(argv[1], "r");
		if(!file) {
			perror("[!] Couldnt open file");
			return 1;
		}
		yyin = file;
	}
	yylex();
	return 0;
}