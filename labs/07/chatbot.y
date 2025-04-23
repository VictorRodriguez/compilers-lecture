%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HI BYE TIME FEELING NAME WEATHER 

%%

chatbot : greeting
        | farewell
        | query
        ;

greeting : HI { printf("Chatbot: Hello World, hope your doing fine.\n"); }
         ;

farewell : BYE { printf("Chatbot: Good goodbye, crocodile.\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: Right now the time is: %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
        | FEELING { printf("Chatbot: I do not have feelings.\n");}
        | NAME { printf("Chatbot: My name is HELLO.\n");}
        | WEATHER { printf("Chatbot: Check your window.\n");}
       ;

%%

int main() {
    printf("Chatbot: HE-LLO, you can say hi, bye or ask for the time :) \n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I can't understand you.\n");
}