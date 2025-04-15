%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);

int should_exit = 0;

%}



%token HELLO GOODBYE TIME NAME WEATHER HOWAREYOU

%%

chatbot : greeting
        | farewell { should_exit = 1; }
        | query
        | name
        | weather
        | howareyou
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

name :
        NAME { printf("Chatbot: My name is Chatbot!\n"); }
        ;

weather :
        WEATHER { printf("Chatbot: I don't have acces to that. Maybe go outside and find out yourself?\n"); }

howareyou :
        HOWAREYOU { printf("Chatbot: I'm doing great, thank you. May I assist you with something?\n"); }

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, or say goodbye.\n");
    while (!should_exit && yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}