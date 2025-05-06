%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);

//List of the top 50 most popular Tamagotchis
char *tamagotchis[50] = {
    "Mametchi", "Kuchipatchi", "Memetchi", "Gozarutchi", "Togetchi",
    "Masktchi", "Bill", "Zatchi", "Androtchi", "Ginjirotchi",
    "Pochitchi", "Nyatchi", "Mimitchi", "Hinotamatchi", "Kabutotchi",
    "Kusatchi", "Tarakotchi", "Pipotchi", "Hanatchi", "Dorotchi",
    "Debatchi", "Takotchi", "Hidatchi", "Yasaguretchi", "Shimashimatchi",
    "Sebiretchi", "Tsunotchi", "Kurokotchi", "Urutchi", "Hashizotchi",
    "Pyonkotchi", "Pyonchitchi", "Wooltchi", "Hatenatchi", "Charitchi",
    "Hapihapitchi", "Sunnytchi", "Chibipatchi", "Hanikamitchi", "Ginjirotchi",
    "Kinakomotchi", "Mizutamatchi", "Kuchitamatchi", "Young Mimitchi", "Ichigotchi",
    "Young Mametchi", "Obotchi", "Ojitchi", "Otogitchi", "Papamametchi"
};
%}

%token HELLO GOODBYE TIME WEATHER NAME MOOD TAMAGOTCHI

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
        | TAMAGOTCHI {
            srand(time(NULL));
            int index = rand() % 50;
            printf("Chatbot: The Tamagotchi of the day is %s.\n", tamagotchis[index]);
        }
        | WEATHER { printf("Chatbot: As of now, Mexico is extremely incredibly agonizingly hot.\n"); }
        | NAME { printf("Chatbot: My name is Chatbot! Nice to meet you!\n"); }
        | MOOD { printf("Chatbot: I'm incapable of feeling emotions, but I'm doing well!\n"); }
       ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask my name, ask me about the weather, ask for the Tamagotchi of the day, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}