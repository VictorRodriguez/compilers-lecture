%{
  #include <stdlib.h>
%}

DIGIT		[0-9]
STRING		[a-zA-Z][a-zA-Z0-9]*

%%
{DIGIT}+ 						{ printf("inum "); }
{DIGIT}*"."{DIGIT}+				{ printf("fnum "); }
^[f]							{ printf("floatdcl "); }
^[i]							{ printf("intdcl "); }
^[s]							{ printf("stringdcl "); }
^[p]							{ printf("print "); }
{STRING}					{ printf("id "); }
[+]							{ printf("plus "); }
[-]							{ printf("less "); }
[*]							{ printf("multiplies "); }
[/]							{ printf("divides "); }
[=]							{ printf("assign "); }
\"							{ printf("quote "); }
\{							{ printf("obrace "); }
\}							{ printf("ebrace "); }
\(							{ printf("oparenth "); }
\)							{ printf("eparenth "); }
"//".*						{ printf("COMMENT"); }
[\n]+						{ printf("\n"); }
;							{ printf("semicolon "); }
[ \t]+						/* ignore whitespace */;
%%

int main(int argc, char **argv) {
    FILE    *fd;

    if (argc == 2)
    {
        if (!(fd = fopen(argv[1], "r")))
        {
            perror("Error: ");
            return (-1);
        }
        yyset_in(fd);
        yylex();
	printf("\n");
        fclose(fd);
    }
    else
        printf("Usage: ./a.out FILENAME\n");
    return (0);
}