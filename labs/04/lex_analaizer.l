%{
    #include <stdio.h>
%}

%%

"//".*  {printf("comment");}
f   {printf("floatdcl");}
i   {printf("intdlc");}
p   {printf("print");}
=   {printf("assign");}
\+  {printf("plus");}
[0-9]+    {printf("inum");}
[0-9]+"."[0-9]* {printf("inum");}
[a-zA-Z_][a-zA-Z0-9]*   {printf("id");}


%%

int main(int argc,char *argv[]){
    ++argv,--argc;
    if (argc > 0)
            yyin=fopen(argv[0],"r");
    else
            yyin = stdin;
    yylex();
}
 