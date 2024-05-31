%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME WEATHER HOW_ARE_YOU

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
       | NAME { printf("Chatbot: My name is Chatbot!\n"); }
       | WEATHER { printf("Chatbot: I'm sorry, I cannot provide weather information at the moment.\n"); }
       | HOW_ARE_YOU { printf("Chatbot: I'm doing well, thank you for asking.\n"); }
       ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, inquire about my name, weather, or ask how I am doing.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
