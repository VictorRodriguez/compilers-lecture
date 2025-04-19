
%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

%}

%token HELLO GOODBYE TIME MOOD NAME WEATHER MUSIC


%%

chatbot : greeting
        | farewell
        | query
        | name_query
        | howis
        | weather_query
        | artist
;

greeting : HELLO { printf("Kane: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Kane: Goodbye! Have a great day!\n"); }
         ;

query : TIME {
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Kane: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;
name_query : NAME {printf("My creator loves playing with Harry Kane on FIFA too much...\n"); }
        ;

howis : MOOD {printf("I'm doing quite well thank you! I compile quite well.\n"); }
        ;
artist : MUSIC {printf("I'm a chatbot, so I don't have that much a music taste. However, my creator's favorite artist at the moment is Izal!\n"); }
        ;
weather_query : WEATHER {printf("Sadly, my creator tried to connect an API (and failed) so I can only guess it's quite hot outside. I recommend some sunscreen!\n"); }
        ;

%%

int main() {
    printf("Hello, I'm Kane! You can greet me, ask for the time, say goodbye, ask me for a music artist, the weather or ask me about my name.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Kane: I didn't understand that.\n");
}