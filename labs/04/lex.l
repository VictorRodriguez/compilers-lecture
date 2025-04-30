%{
#include <stdio.h>
%}

%%
if 		printf("if ");
else		printf("else ");
elif		printf("elif ");
while		printf("while ");
for		printf("for ");
return		printf("return ");
def		printf("def ");
class		printf("class ");
import  	printf("import");
[False|FALSE]	printf("false");
[True|TRUE]	printf("true");
in		printf("in");
range		printf("range");
not		printf("not");
\[		printf("OPENBRACKET ");
\]		printf("CLOSEBRACKET ");
\<		printf("GREATER_THAN ");
\>		printf("LOWER_THAN ");
\,		printf("COMMA ");
\:		printf("COLON ");
\"		printf("QUOTE ");
\(		printf("OPENPARENTHESIS ");
\)		printf("COLSEPARENTHESIS ");
\+		printf("PLUS ");
\=		printf("EQUAL ");
\'		printf("SIMPLEQUOTE ");
\n		printf("\n");
\*		printf("MULTIPLICATION ");
\/		printf("DIVISION ");
\-		printf("MINUS ");
\#		printf("COMMENT ");
[0-9]+		printf("NUMBER ");
[a-zA-Z]+		printf("VARIABLE ");
[a-zA-Z0-9\/.-]*        printf("FILENAME ");
%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Could not open %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }
    yylex();
    return 0;
}