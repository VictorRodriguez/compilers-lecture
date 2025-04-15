%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h> // For rand()
#include <string.h> // For strcmp()

void yyerror(const char *s);
%}

%token HELLO GOODBYE TIME NAME WEATHER FEELING

%%

chatbot : greeting
        | farewell
        | query
        ;

greeting : HELLO { printf("Chatbot: Hello there! 👋 What can I do for you?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: See ya! 👋\n"); }
         ;

query : NAME { printf("Chatbot: I'm Vane the best chatbot in the world better that Chatgpt 😉\n"); }
      | WEATHER { 
            int weather = rand() % 3; // Random weather condition
            switch (weather) {
                case 0:
                    printf("Chatbot: It's a beautiful day! ☀️\n");
                    break;
                case 1:
                    printf("Chatbot: It's a bit cloudy today. ☁️\n");
                    break;
                case 2:
                    printf("Chatbot: Brrr, it's a bit chilly! 🥶\n");
                    break;
            }
         }
      | FEELING { 
            int feeling = rand() % 3; // Random feeling
            switch (feeling) {
                case 0:
                    printf("Chatbot: I'm doing great! Thanks for asking! 😄\n");
                    break;
                case 1:
                    printf("Chatbot: I'm feeling a little tired. 😴\n");
                    break;
                case 2:
                    printf("Chatbot: I'm ready for some fun! 🥳\n");
                    break;
            }
         }
      | TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

%%

int main() {
    srand(time(NULL)); // Seed the random number generator
    printf("Chatbot: Hi! I'm ready to chat. Ask me anything! 😄\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I'm not sure I understand. 🤔\n");
}
