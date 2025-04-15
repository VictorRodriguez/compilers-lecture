%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
void get_random_zelda_game();

%}

%token HELLO GOODBYE TIME NAME HOWAREYOU RECOMMEND_GAME

%%

chatbot : greeting
        | farewell
        | query
        | name
        | howAreYou
        | zeldaGame
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

name : NAME { printf("Chatbot: My name is Kratos.\n"); }
           ;

howAreYou : HOWAREYOU { printf("Chatbot: I dont have any feelings actually but I guess im doing alright, how about you?\n"); }
                ;

zeldaGame : RECOMMEND_GAME { get_random_zelda_game(); }
                     ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask my name, ask how I am, or if you feel like playing zelda I can recommend you one.\n");
    srand(time(NULL));  // Seed the random number generator
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}

void get_random_zelda_game() {
    const char *zelda_games[] = {
        "The Legend of Zelda",
        "Zelda II: The Adventure of Link",
        "The Legend of Zelda: A Link to the Past",
        "The Legend of Zelda: Link's Awakening",
        "The Legend of Zelda: Ocarina of Time",
        "The Legend of Zelda: Majora's Mask",
        "The Legend of Zelda: Oracle of Seasons",
        "The Legend of Zelda: Oracle of Ages",
        "The Legend of Zelda: Four Swords",
        "The Legend of Zelda: The Wind Waker",
        "The Legend of Zelda: Four Swords Adventures",
        "The Legend of Zelda: The Minish Cap",
        "The Legend of Zelda: Twilight Princess",
        "The Legend of Zelda: Phantom Hourglass",
        "The Legend of Zelda: Spirit Tracks",
        "The Legend of Zelda: Skyward Sword",
        "The Legend of Zelda: A Link Between Worlds",
        "The Legend of Zelda: Tri Force Heroes",
        "The Legend of Zelda: Breath of the Wild"
    };

    int num_games = sizeof(zelda_games) / sizeof(zelda_games[0]);
    int random_index = rand() % num_games;

    printf("Chatbot: How about you try %s?\n", zelda_games[random_index]);
}
