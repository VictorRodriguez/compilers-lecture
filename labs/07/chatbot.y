%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
   

%}

%token HELLO GOODBYE TIME RANDOM WEATHER
%token NUMBER PLUS WHATIS

%%

chatbot : greeting
	   | farewell
	   | query
	   ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
		;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
		;

query : TIME { 
		   time_t now = time(NULL);
		   struct tm *local = localtime(&now);
		   printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
		}
		| RANDOM {
			printf("Chatbot: Generating a random number...\n");
			srand(time(NULL));
			int r = rand() % 3;
			printf("Chatbot: This is a random number: %d.\n", r);
		}
		| WHATIS NUMBER PLUS NUMBER {
			int result = $2 + $4;
			printf("Chatbot: The result is %d.\n", result);
		}
	  ;


%%

int main() {
   printf("Chatbot: Hi! You can greet me, ask for the time, or say goodbye.\n");
   while (yyparse() == 0) {
	   // Loop until end of input
   }
   return 0;
}

void yyerror(const char *s) {
   fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
