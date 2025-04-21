%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

void tell_joke();
%}

%token HELLO GOODBYE TIME NAME JOKE WEATHER CAPABILITIES

%%

chatbot : greeting
        | farewell
        | query
        | name
        | joke
        | weather
        | capabilities
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

name : NAME { printf("Chatbot: My name is Chatbot! Nice to meet you.\n"); }
     ;

joke : JOKE { tell_joke(); }
     ;

weather : WEATHER { printf("Chatbot: The weather in Guadalajara, Jalisco, Mexico is usually warm and sunny.\n"); }
     ;


capabilities : CAPABILITIES { printf("Chatbot: I'm a Chatbot :)\n You can greet me, say goodbye, ask me the time, ask me to tell a joke.\n"); }
             ;

%%

void tell_joke() {
    // List of jokes
    const char *jokes[] = {
        "How do you tell HMTL from HTML5?\n Try it out in Internet Explorer \n Did it work? \n No? It's HMTL5.",
        "There are only 10 kinds of people in this world: those who know binary and those who don't.",
        "How do you make holy water? You boil the hell out of it.",
        "Your mother is so old, she knew Burger King while he was still a prince.",
        "I was struggling to figure out how lightning works, but then it struck me.",
        "I have a fish that can breakdance!\n Only for 20 seconds though\n And only once.",
        "A neutron walks into a bar and asks for a price on a drink. \n The bartender says: \n 'For you... no charge!'"
    };

    // Number of jokes in the list
    int num_jokes = sizeof(jokes) / sizeof(jokes[0]);

    // Seed the random number generator
    srand(time(NULL));

    // Select a random joke
    int joke_index = rand() % num_jokes;

    // Print the selected joke
    printf("Chatbot: %s\n", jokes[joke_index]);

}

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask me to tell a joke, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
