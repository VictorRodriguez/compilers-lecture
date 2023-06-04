%option noinput nounput noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
%}

%%


"please"  { return PLEASE; }
"and"   { return AND; }
"go" | "turn"   { return ACTION; }
"forward" | "backward" | "right" | "left"  { return DIRECTION; }
[0-9]+  { return NUMBER; }
"block" | "blocks" | "degrees"  { return UNIT; }
[ \t\n]     ;  // Skip whitespace


"\n"   { printf("\n"); }

\/\/.*  { /* ignore comments */ }
[ \t]  { /* ignore whitespace */ }


%%

int main(int argc, char** argv){
    yylex();
    return 0;
}
