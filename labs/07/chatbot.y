%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME WEATHER FEELINGS NAME 

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
        | WEATHER {
            printf("Va llover! Corre a tu casa.");
        }
        | FEELINGS {
            printf("Ya me quiero graduar :c");
        }
        | NAME {
            printf("Soy RODO, soy tu...");
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