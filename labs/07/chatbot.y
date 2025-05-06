%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}


%token HELLO GOODBYE TIME DATE HELP HOWAREYOU JOKE FACT RANDOMNUMBER

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
       | DATE {
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: Today's date is %02d-%02d-%04d.\n", local->tm_mday, local->tm_mon + 1, local->tm_year + 1900);
         }
       | HELP { printf("Chatbot: That's what I'm here for! What do you need assistance with?\n"); }
       | HOWAREYOU { printf("Chatbot: I don't have feelings, but if I did, I could tell you that I feel great!\n"); }
       | JOKE { printf("Chatbot: Why don't scientists trust atoms? Because they make up everything!\n"); }
       | FACT { printf("Chatbot: Did you know that honey never spoils? Archaeologists have found pots of honey in ancient Egyptian tombs that are over 3,000 years old and still perfectly edible.\n"); }
       | RANDOMNUMBER {
            int num = rand() % 100;  // Generate a random number between 0 and 99
            printf("Chatbot: Here is a random number for you: %d\n", num);
         };

%%

int main() {
    srand(time(NULL));  // Initialize random number generator
    printf("Chatbot: Hi! You can greet me, ask for the time, date, a joke, a fact, a random number, or a percentage calculation. You can also ask for help, inquire about my well-being, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
