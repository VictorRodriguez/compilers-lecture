%{
#include <stdio.h>
%}

%option noyywrap

letter		[a-eg-hj-opq-z]
digit		[0-9]
integer		{digit}+
float		(0|[1-9]{digit}*)\.({digit}*[1-9]|0)
comment		\/{2}.*
id			{letter}({letter}|{digit})*

%%
^i			{printf("INT_DEC ");}
^f			{printf("FLOAT_DEC ");}
^p          {printf("PRINT ");}
\=			{printf("ASSIGN ");}
\-			{printf("MINUS ");}
\+			{printf("PLUS ");}
\/			{printf("DIVI ");}
\*			{printf("MULTI ");}
{id}		{printf("ID ");}
{integer}	{printf("INT ");}
{float}		{printf("FLOAT ");}
{comment}	{printf("COMMENT ");}
%%

int main(){
	yylex();
	return 0;
}
