%{
#include <stdio.h>
%}
%option noyywrap
%%
\/\/.*	   {printf("COMMENT\n");}
f          { printf("floatdcl"); }
i	   { printf("intdcl"); }
p	   { printf("print"); }
[a-eg-hj-oq-z] { printf("id"); }
[a-eg-hj-oq-z]" "*\n { printf("id\n"); }
=	   { printf("assign"); }
\+	   { printf("plus"); }
-	   { printf("minus"); }
[0-9]+	   { printf("inum"); }
[0-9]+" "*\n { printf("inum\n"); }
[0-9]+.[0-9]+	{ printf("fnum"); }
[0-9]+.[0-9]+" "*\n	{ printf("fnum\n"); }
\n	   { /* Don't print line breaks to console  */  }
%%

int main() {
    yylex();
    return 0;
}
