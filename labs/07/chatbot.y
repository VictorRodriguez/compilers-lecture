%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME WEATHER HOWAREYOU

%%

chatbot : greeting
        | farewell
        | query
        | name_query
        | weather_query
        | how_are_you_query
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

name_query : NAME { printf("Chatbot: My name is Chatito!\n"); }
           ;

weather_query : WEATHER { printf("Chatbot: I can't check the weather right now, but when I been created the weather was 32°C\n"); }
              ;

how_are_you_query : HOWAREYOU { printf("Chatbot: I'm just a bunch of code (or not), so I'm really good!\n"); }
                  ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, my name, how am I, ask for the weather, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
