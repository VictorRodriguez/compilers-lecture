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

greeting : HELLO { printf("Jazzybot: Hello! How can I be of service to you?\n"); }
         ;

farewell : GOODBYE { printf("Jazzybot: Goodbye! Have a great day!\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Jazzybot: Right now the time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       | NAME { printf("Jazzybot: My name is Abraham!\n"); }
       | WEATHER { printf("Jazzybot: I'm sorry, I cannot provide weather information at the moment.\n"); }
       | HOW_ARE_YOU { printf("Jazzybot: I'm doing well, thank you for asking.\n"); }
       ;

%%

int main() {
    printf("Jazzybot: Hello! You can GREET me, ask for the time, inquire about my name, weather, or ask how I am doing.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Jazzybot: I didn't understand that.\n");
}