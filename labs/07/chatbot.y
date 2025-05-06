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
        | name_query
        | weather_query
        | how_are_you_query
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

name_query : NAME { printf("Chatbot: My name is Enrique Sidrax SukiBot.\n"); }
           ;

weather_query : WEATHER { printf("Chatbot: The weather in Zapopan is 35°C. It's a sunny day. And we have a 10%% chance of rain before 6:00 PM.\n"); }
              ;

how_are_you_query : HOW_ARE_YOU { printf("Chatbot: I'm doing great! Thanks for asking.\n"); }
                  ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, my name, the weather, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
