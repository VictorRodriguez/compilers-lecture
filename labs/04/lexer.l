%{
    #include <stdio.h>
%}

%option noyywrap

%%

\/\/^\n                 { printf("comment\n"); }
"f"                     { printf("floatdcl\n"); }   
"i"                     { printf("intdcl\n"); }
"p"                     { printf("print\n"); }
[a-zA-Z_][a-zA-Z0-9]*   { printf("variable\n"); }
[0-9]+                  { printf("inum\n"); }
[0-9]+"."[0-9]+         { printf("fnum\n"); }
"+"                     { printf("plus\"); }
"="                     { printf("assing\n"); }
"*"                     { printf("multiplication\n"); }
"/"                     { printf("division\n"); }
"\n"                    { printf("\n"); }
.                       {/*Ignore other characters*/}

%%


int main(int argc,char **arg){
    yylex();
    return 0;
}
