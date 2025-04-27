%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);

void print_time();
void print_forecast();

%}

%token HELLO GOODBYE TIME NAME WEATHER HOW
%token PLAY_MUSIC STOP_MUSIC SET_ALARM JOKE ADD_MILK

%%

chatbot : command
        ;

command : greeting
        | farewell
        | query
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;

query : TIME { print_time(); }
      | NAME { printf("Chatbot: My name is Chatbot.\n"); }
      | HOW { printf("Chatbot: I'm fine, thank you!\n"); }
      | WEATHER { print_forecast(); }
      | PLAY_MUSIC { printf("Chatbot: Playing music.\n"); }
      | STOP_MUSIC { printf("Chatbot: Stopping music.\n"); }
      | SET_ALARM { printf("Chatbot: Setting an alarm.\n"); }
      | JOKE { printf("Chatbot: Why don't scientists trust atoms? Because they make up everything!\n"); }
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

void print_time() {
    time_t now = time(NULL);
    struct tm *local = localtime(&now);
    printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
}

void print_forecast() {
    printf("Chatbot: The weather is sunny.\n");
}
