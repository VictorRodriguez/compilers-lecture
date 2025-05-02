%{
#include <stdio.h>
#include <time.h>
#include <stdbool.h>
#include "weather.h"

char user_name[128];
bool is_user_name_set = false;

void introduction(){
    if(is_user_name_set){
        printf("Chatbot: %s, ", user_name);
    } else {
        printf("Chatbot: ");
    }
}

void yyerror(const char *s);
int yylex(void);
%}

%union {
 char *sval;
}

%token <sval> GIVEN_NAME
%token HELLO GOODBYE TIME_QUERY NAME_QUERY WEATHER_QUERY USER_NAME_QUERY

%%

chatbot : greeting
        | farewell
        | query
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;

query : TIME_QUERY { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);

            introduction();
            printf("The current time is %02d:%02d\n", local->tm_hour, local->tm_min);
      }
      | NAME_QUERY {
            //print a different name depending on who's shift it is
            time_t now = time(NULL);
            struct tm *local = localtime(&now);

            introduction();
            if(local->tm_hour < 8){
                printf("My name is Ramiro, I'm on duty until 08:00\n");
            } else if(local->tm_hour < 16){
                printf("My name is Luisa, I'm on duty until 16:00\n");
            } else {
                printf("My name is Maria, I'm on duty until midnight\n");
            }
      }
      | WEATHER_QUERY GIVEN_NAME {
        introduction();
        printf("%s\n", queryWeatherIn($2));
      }
      | USER_NAME_QUERY GIVEN_NAME {
        strcpy(user_name, $2);
        is_user_name_set = true;

        printf("Chatbot: Alright, I'll call you %s from now on\n", user_name);
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