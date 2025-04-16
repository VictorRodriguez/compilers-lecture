%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
FILE *yyin; 
%}


/*Option section*/
%option noyywrap
%option yylineno

/*basic reserve words*/

IF "if"|"IF"
WHILE "WHILE"|"while"
INTEGER_TAG "INT"|"int"
PRINTF "printf"
RETURN "return"
SCANF "scanf"
INCLUDE "#include"

/*token section*/
FLOAT [-+]?[1-9]*\.[0-9]+
ARCH_HEADER <.+>
DIGIT [0-9]
CHAR [a-zA-Z]
WHITESPACE [" "]
INIT_COMMENT [//]
CHAR_COMMA [","]
CHAR_DOT ["."]
CHAR_COLON [":"]
CHAR_SEMICOLON [";"]
HYPHEN [-]
UNDERSCORE [_]



HEADER {INCLUDE}{WHITESPACE}+{ARCH_HEADER}
IDENTIFIER {CHAR}({CHAR}|{DIGIT}|{HYPHEN}|{UNDERSCORE})*
CONST_STRING \"[^\n"]*\"
COMMENT {INIT_COMMENT}.*



/*logic and arithmetic Operators*/

OP_SUM [+]
OP_REST [-]
OP_MULT [*]
OP_DIV [/]
OP_ASSIGN [=]
OP_LESS [<]
OP_GREATER [>]
OP_LESSEQUAL "<="
OP_GREATEREQUAL ">="
OP_COMP_EQUAL "=="
OP_NEG [!]
OP_DISTINCT "!="

/*open, closed and end line characters*/
CBRACKET_O ["{"]
CBRACKET_C ["}"]
RBRACKET_O ["("]
RBRACKET_C [")"]
ENDL [";"]


%%

{FLOAT} {printf("\nFLOAT (%s)", yytext);}
{INCLUDE} {printf("\nINCLUDE (%s)", yytext);}
{HEADER} {printf("\nHEADER (%s)", yytext);}
{IF} {printf("\nIF (%s)", yytext);}
{WHILE} {printf("\nWHILE (%s)", yytext);}
{INTEGER_TAG} {printf("\nINTEGER_TAG (%s)", yytext);}
{PRINTF} {printf("\nPRINTF (%s)", yytext);}
{RETURN} {printf("\nRETURN (%s)", yytext);}
{SCANF} {printf("\nSCANF (%s)", yytext);}
{ENDL} {printf("\nENDL (%s)", yytext);}
{DIGIT} {printf("\nDIGIT (%s)", yytext);} 
{CHAR_COMMA} {printf("\nCHAR_COMMA (%s)", yytext);} 
{IDENTIFIER} {printf("\nIDENTIFIER (%s)", yytext);} 
{COMMENT} {printf("\nCOMMENT (%s)", yytext);} 
{CONST_STRING} {printf("\nCONST_STRING (%s)", yytext);} 
{OP_SUM} {printf("\nOP_SUM (%s)", yytext);} 
{OP_REST} {printf("\nOP_REST (%s)", yytext);} 
{OP_MULT} {printf("\nOP_MULT (%s)", yytext);} 
{OP_ASSIGN} {printf("\nOP_ASSIGN (%s)", yytext);} 
{OP_LESSEQUAL} {printf("\nOP_LESSEQUAL (%s)", yytext);} 
{OP_GREATEREQUAL} {printf("\nOP_GREATEREQUAL (%s)", yytext);} 
{OP_COMP_EQUAL} {printf("\nOP_COMP_EQUAL (%s)", yytext);} 
{OP_NEG} {printf("\nOP_NEG (%s)", yytext);}
{OP_DISTINCT} {printf("\nOP_DISTINCT (%s)", yytext);}
{CBRACKET_O} {printf("\nCBRACKET_O (%s)", yytext);}
{CBRACKET_C} {printf("\nCBRACKET_C (%s)", yytext);} 
{RBRACKET_O} {printf("\nRBRACKET_O (%s)", yytext);}
{RBRACKET_C} {printf("\nRBRACKET_C (%s)", yytext);}


.  /* Catch all rule for any other single character */
    
%%

int main(int argc, char *argv[]){
 if((yyin = fopen(argv[1], "rt")) == NULL){
  printf("\nNo: %s\n", argv[1]);
  return 1;
 }
 else {
  printf("\nYes %s:\n", argv[1]);
  yylex(); 
 }
 printf("\nFinish %s\n", argv[1]);
 fclose(yyin);
 return 0;
}
