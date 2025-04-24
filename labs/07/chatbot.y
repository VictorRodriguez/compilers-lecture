%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME MOVIE RESTAURANT

%%

chatbot : greeting
        | farewell
        | query
        | movie
        | restaurant
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;
movie : MOVIE { printf("Chatbot: My recomendations are Walk the line, Day-shift & Life is beautiful.\n"); }
         ;
restaurant : RESTAURANT { printf("Chatbot: Some good places in GDA are Louie Burger, Sushi Factory & La pasteria.");}
        ;

query : TIME {
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, movies and restaurant recomendations, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
