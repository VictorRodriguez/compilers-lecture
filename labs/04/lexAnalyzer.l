%{
#include <stdio.h>	
%}

%%
"//".*				{ printf("COMMENT\n"); }
"f"					{ printf("floatdcl\n"); }
"i"					{ printf("intdcl\n"); }
"p"					{ printf("print\n"); }
[a-zA-Z]			{ printf("id\n"); }
[0-9]+\.[0-9]+		{ printf("fnum\n"); }
[0-9]+				{ printf("inum\n"); }
"="					{ printf("assign\n"); }
"+"					{ printf("plus\n"); }
"-"					{ printf("minus\n"); }
"*"					{ printf("multiply\n"); }
"/"					{ printf("divide\n"); }
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