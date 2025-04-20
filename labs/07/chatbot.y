%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME WHEATHER NAME FEEL

%%

chatbot : greeting
        | farewell
        | query
        | presentation
        | climate
        | feeling
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

presentation : NAME { printf("Chatbot: My name is Malevolgia, and I am here to conquer the world! :3\n");}
             ;

climate : WHEATHER {printf("It's very sunny today, but I hope it rains.\n");}
        ;

feeling : FEEL {printf("I am doing great! and you?\n");}
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