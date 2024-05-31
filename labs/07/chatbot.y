%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);

char* user_name = NULL;
%}

%token HELLO GOODBYE TIME DATE WEATHER THANKS JOKE NAME NAME_IS HOW_ARE_YOU
%union {
    char *str;
}

%%

chatbot : greeting
        | farewell
        | query
        | thanks
        | joke
        | name_query
        | how_are_you
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
       | DATE {
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: Today's date is %02d/%02d/%04d.\n", local->tm_mday, local->tm_mon + 1, local->tm_year + 1900);
         }
       | WEATHER {
            // Aquí podrías integrar una API de clima real
            printf("Chatbot: The weather is sunny with a chance of rain.\n");
         }
       ;

thanks : THANKS { printf("Chatbot: You're welcome!\n"); }
       ;

joke : JOKE { printf("Chatbot: Why don't scientists trust atoms? Because they make up everything!\n"); }
     ;

name_query : NAME {
                if (user_name) {
                    printf("Chatbot: My name is Chatbot. Nice to meet you, %s!\n", user_name);
                } else {
                    printf("Chatbot: My name is Chatbot. What's your name?\n");
                }
             }
           | NAME_IS {
                user_name = strdup(yylval.str);
                printf("Chatbot: Nice to meet you, %s!\n", user_name);
             }
           ;

how_are_you : HOW_ARE_YOU { printf("Chatbot: I'm just a bunch of code, but I'm here to help you!\n"); }
           ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask for the date, ask about the weather, tell me your name, ask for a joke, ask how I am, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    if (user_name) {
        free(user_name);
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
