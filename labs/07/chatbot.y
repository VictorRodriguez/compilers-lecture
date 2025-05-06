%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
void get_random_riddle();

%}

%token HELLO GOODBYE TIME DATE DAY NAME HOW_ARE_YOU JOKE AGE RANDOM RIDDLE

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
        /* Added the date to the query */
       | DATE {
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: Today's date is %02d/%02d/%04d.\n", local->tm_mday, local->tm_mon + 1, local->tm_year + 1900);
         }
         /* Added the day to the query */
       | DAY {
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            char *days[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
            printf("Chatbot: Today is %s.\n", days[local->tm_wday]);
         }
        /* Added name, how are you, joke, age, random fact and a riddle to the query */
       | NAME { printf("My name is Chatbot: I was created using Lex and Yacc.\n"); }
       | HOW_ARE_YOU { printf("Chatbot: I'm good, but I'm here to help you!\n"); }
       | JOKE { printf("Chatbot: Why don't birds use Facebook? Because they already have Twitter.\n"); }
       | AGE { printf("Chatbot: I was created very recently, so I'm quite young!\n"); }
       | RANDOM { printf("Chatbot: Did you know? Octopuses have three hearts!\n"); }
       | RIDDLE { get_random_riddle(); }
       ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, date, day, what is my name, how am I,  my age, ask for a joke, a random fact, riddle or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}

// Function to get a random riddle
void get_random_riddle() {
    const char *riddles[] = {
        "What has keys but can't open locks? A piano.",
        "What has a heart that doesn't beat? An artichoke.",
        "What has hands but can't clap? A clock."
    };
    int num_riddles = sizeof(riddles) / sizeof(riddles[0]);
    int random_index = rand() % num_riddles;
    printf("Chatbot: %s\n", riddles[random_index]);
}
