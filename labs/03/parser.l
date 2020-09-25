%{
        #include <stdio.h>
%}

%%
[\t ]+
[/]{2}[[a-zA-Z0-9]*[\t ]*]*\n printf("comment\t\n");
f 	 printf("floatdcl\t");
i  	printf("intdcl\t");
p  printf("print\t");
[a-e]|[g-h]|[j-o]|[q-z] 	printf("id\t");
= printf("assign\t"); 
\+ 	printf("plus\t");
- 	printf("minus\t");
[0-9]+ 	printf("inum\t");
[0-9]+\.[0-9]+ printf("fnum\t");
%% 

main(argc,argv)
int argc;
char **argv;
{
	if(argc > 1){
		FILE *file;
		
		file = fopen(argv[1], "r");
		if(!file){
			printf("Error opening file\n");
			exit(1);
			}
			yyin = file;
		}
	yylex();
	return 0;
}
