%option noinput nounput noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
%}

%%

"i"    { printf("intdcl "); }
"f"    { printf("floatdcl "); }
"p"    { printf("print "); }
[0-9]+ { printf("inum "); }
[0-9]+"."[0-9]{1,5} { printf("fnum "); }
[a-z] { printf("id "); }

"="    { printf("assign "); }
"+"    { printf("plus "); }
"-"    { printf("minus "); }
"*"    { printf("times "); }
"/"    { printf("divide "); }
"\n"   { printf("\n"); }

\/\/.*  { /* ignore comments */ }
[ \t]  { /* ignore whitespace */ }
.      { printf("error "); }

%%

int main(int argc, char** argv){
    yylex();
    return 0;
}
