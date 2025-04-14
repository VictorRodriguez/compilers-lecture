%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME WEATHER HOWAREYOU FLIP_COIN

%%

chatbot : greeting
        | farewell
        | query
        | inquiry
        | coinflip
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

inquiry : NAME { printf("Chatbot: My name is Jeff.\n"); }
        | WEATHER { 
            srand(time(NULL)); 
            int temperature = 25 + rand() % 16; 
            printf("Chatbot: The weather today is %d degrees Celsius outside.\n", temperature); 
          }
        | HOWAREYOU { 
            srand(time(NULL));
            const char *moods[] = {
                "happy 😊",
                "sad 😢",
                "excited 😆",
                "angry 😠",
                "bored 😐",
                "confused 😕",
                "surprised 😮",
                "tired 😴",
                "scared 😱",
                "calm 😌"
            };
            int moodIndex = rand() % 10;
            printf("Chatbot: I'm feeling %s\n", moods[moodIndex]);
          }
        ;

coinflip: FLIP_COIN {
            srand(time(NULL));
            int result = rand() % 2;
            if (result == 0) {
                printf("Chatbot: It's heads! 🪙\n");
            } else {
                printf("Chatbot: It's tails! 🪙\n");
            }
          }
        ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask my name, ask my mood, inquire about the weather, flip a coin, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}

