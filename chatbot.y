%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME FEELING WEATHER JOKE

%%

chatbot : greeting
        | farewell
        | query
	| name
	| feeling
	| weather       
	| joke
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
       ;

name : NAME { printf("Chatbot: My name is Rotceh.\n"); }
     ;

feeling : FEELING { printf("Chatbot: I'm doing well, thanks for asking!\n"); }
        ;

weather : WEATHER { 
		printf("Chatbot: The weather of the place you live looks like the following:\n");
		/* 
		Makes a request to wttr.in in silent mode to prevent from
		displaying the progress meter or error messages, and then 
		passes the result of the weather information to the sed 
		command and with the "-n" option it suppresses the printing 
		of every line that it reads and then it just prints the first 
		line and also prints from lines 8 to 17. 
		*/ 
		system("curl -s wttr.in | sed -n '1p;8,17p'");
		printf("\n");
	  }
	; 

joke : JOKE {
	char jokes[5][69] = {"What do you call a pile of cats? A meow-ntain.", 
			     "Why did the bicycle fall over? Because it was two tired.",
			     "What do you call a fish without an eye? Fsh.",
			     "How many tickles does it take to make an octopus laugh? Ten-tickles.",
			     "What do math books wear under their covers? Alge-bras."};
	srand(time(NULL));
	/* 
	Modulus operator is used on rand() % 5, and 5 is used to ensure
	that the result of this operation is a number in the range
	from 0 - 4 with 0 and 4 being inclusive in this range, this is
	done so a valid index can be used to access an
	element from the array of strings called jokes. 
	*/
	int pseudo_random_index = rand() % 5;
	char random_joke[69];
	strcpy(random_joke, jokes[pseudo_random_index]);
	printf("Chatbot: %s\n", random_joke);	
       }
     ;

%%

int main() {
    // Added a line break at the start of the Chatbot's message
    printf("\nChatbot: Hi! You can greet me, ask me for the time, ask me what's my name, ask me what's the weather like where you live, request me to tell you a joke or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
