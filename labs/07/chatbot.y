%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);

// Array of names of Formula 1 drivers (2024 grid)
const char *drivers[] = {
    "Max Verstappen",
    "Sergio Perez",
    "Lewis Hamilton",
    "George Russell",
    "Charles Leclerc",
    "Carlos Sainz",
    "Lando Norris",
    "Oscar Piastri",
    "Fernando Alonso",
    "Lance Stroll",
    "Anyone but Esteban Ocon",
    "Pierre Gasly",
    "Valtteri Bottas",
    "Zhou Guanyu",
    "Kevin Magnussen",
    "Nico Hulkenberg",
    "Yuki Tsunoda",
    "Daniel Ricciardo",
    "Alex Albon",
    "Logan Sargeant"
};

int driver_index;

%}

%token HELLO GOODBYE TIME NAME WEATHER HOWRU DRIVER

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
        | NAME {
            printf("Chatbot: Hi, my name is, what? My name is, who? My name is, chka-chka, Slim Shady\n");
        }
        | WEATHER {
            printf("Chatbot: It is burning hot.\n");
        }
        | HOWRU {
            printf("Chatbot: I'm doing good, thanks for asking. :) \n");
        }
        | DRIVER {
            printf("%s\n", drivers[driver_index]);
        }
       ;

%%

int main() {
    // Seed the random number generator
    srand(time(NULL));
    // Randomly choose one driver
    int array_size = sizeof(drivers) / sizeof(drivers[0]);
    driver_index = rand() % array_size;

    printf("Chatbot: Hi! You can greet me, ask for the time, say goodbye, or ask me who my favorite f1 driver is.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
