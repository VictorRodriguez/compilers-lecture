%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME WEATHER HOWAREYOU JOKE CAPABILITIES

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
       | NAME { printf("Chatbot: My name is Chatbot.\n"); }
       | WEATHER { printf("Chatbot: I can't check the weather right now, but it's always sunny in the virtual world!\n"); }
       | HOWAREYOU { printf("Chatbot: I'm just a program, so I don't have feelings, but thank you for asking!\n"); }
       | JOKE { printf("Chatbot: Why did the two Java methods get a divorce? Because they had constant arguments.\n"); }
       | CAPABILITIES { printf("Chatbot: I can greet you, tell you the time, tell you a joke, and more.\n"); }
       ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, my name, the weather, how I am, ask for a joke, or say goodbye.\n");
    while (yyparse() == 0) {
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
