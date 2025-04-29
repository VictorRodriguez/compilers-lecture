%{
#include <stdio.h>
%}

%option noyywrap

letter		[A-Za-z]
integer		[0-9]+
float		(0|[1-9][0-9]*)\.([0-9]*[1-9]|0)
comment		\/\/.*
id			{letter}({letter}|[0-9])*

%%
^p          {printf("print ");}
^f			{printf("floatdcl ");}
^i			{printf("intdcl ");}
{id}		{printf("id ");}
{integer}	{printf("inum ");}
{float}		{printf("fnum ");}
{comment}	{printf("COMMENT ");}
\*			{printf("multiply ");}
\=			{printf("assign ");}
\-			{printf("minus ");}
\+			{printf("sum ");}
\/			{printf("div ");}
%%

int main(){
	yylex();
	return 0;
}