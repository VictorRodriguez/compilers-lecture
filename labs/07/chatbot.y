%{
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME HOW_ARE_YOU WHAT_UP NAME WEATHER

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
       | HOW_ARE_YOU { printf("Chatbot: I'm just a program, but thanks for asking!\n"); }
       | WHAT_UP { printf("Chatbot: Not much, just here to assist you!\n"); } // A more casual line for what up
       | NAME { printf("Chatbot: My name is Chatbot.\n"); } 
       | WEATHER { printf("Chatbot: Fetching weather information...\n");
            system("curl wttr.in"); // Execute the curl command 
	}
	; // It uses the wttr.in which locates ip for weather 

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
