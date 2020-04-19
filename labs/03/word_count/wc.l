%{
#include <stdio.h>
unsigned long charCount = 0, wordCount = 0, lineCount = 0;
%}

word	[^ \t\n]+
eol 	\n

%%
{word}	{wordCount++;charCount +=yyleng;}
{eol} 	{charCount++;lineCount++;}
.		{charCount++;}
%%

int main(){
	yylex();
	printf("%lu %lu %lu\n",lineCount,wordCount,charCount);
	return 0;
}

