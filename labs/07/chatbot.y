%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);

// List of favorite activities
char *activities[] = {
    "reading books", "coding", "playing chess", "hiking", "cooking", 
    "painting", "playing guitar", "running", "gardening", "watching movies"
};

void get_random_activity();
%}

%token HELLO GOODBYE TIME WEATHER NAME MOOD ACTIVITY

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
       | WEATHER { printf("Chatbot: It's sunny and warm outside.\n"); }
       | NAME { printf("Chatbot: My name is Chatbot! Nice to meet you!\n"); }
       | MOOD { printf("Chatbot: I'm a program, so I don't have feelings, but I'm here to help!\n"); }
       | ACTIVITY { get_random_activity(); }
       ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask my name, ask about the weather, inquire about my mood, ask about my favorite activity, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}

void get_random_activity() {
    int n = sizeof(activities) / sizeof(activities[0]);
    int selection = rand() % n;
    printf("Chatbot: My favorite activity is %s.\n", activities[selection]);
}