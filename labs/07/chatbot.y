%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h>


void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME WEATHER HOWRU

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
        | WEATHER { system("python3 get-weather.py"); }
        | HOWRU { printf("Chatbot: I'm doing well, thank you for asking!\n"); }
        | NAME { printf("Chatbot: My name is Chatbot. What's your name?\n"); }
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