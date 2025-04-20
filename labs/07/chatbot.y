// Actividad 3.2: Gramáticas Libres De Contexto | Lab 07
// Alumno: León Emiliano García Pérez [A00573074]
// Fecha de Entrega: Viernes 31 de Mayo de 2024

%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
void getWeather();
%}

%token HELLO GOODBYE TIME NAME WEATHER HOWAREYOU HOWYOUDOING JOKE

%%

chatbot : greeting
        | farewell
        | timeQuery
        | nameQuery
        | weatherQuery
        | howareyouQuery
        | howyoudoingQuery
        | jokeQuery
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;

timeQuery : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time at Zapopan is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

nameQuery : NAME { printf("Chatbot: My name is Chad, your favorite Chatbot!\n"); }
           ;

weatherQuery : WEATHER { 
                   printf("Chatbot: Let me check the weather...\n");
                   getWeather(); 
               }
             ;

howareyouQuery : HOWAREYOU { printf("Chatbot: I'm fine, thanks for asking!\n"); break;}
           ;

howyoudoingQuery : HOWYOUDOING { printf("Chatbot: I'm doing great, thanks!\n"); break;}
           ;

jokeQuery : JOKE { 
                int joke_num = rand() % 3;
                switch(joke_num) {
                    case 0: printf("Chatbot: Why don't scientists trust atoms? Because they make up everything!\n"); break;
                    case 1: printf("Chatbot: Why was the math book sad? Because it had too many problems.\n"); break;
                    case 2: printf("Chatbot: Why don't programmers like nature? It has too many bugs.\n"); break;
                }
             }
           ;

%%

int main() {

    srand(time(NULL));

    printf("Chatbot: Hi! You can greet me, ask for the time, ask me for the weather, ask me how im doing, ask my name, ask for a joke, or just say goodbye.\n");

    while (yyparse() == 0) {
    }
    
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: Sorry, I didn't understand that.\n");
}

void getWeather() {
    char command[256];
    snprintf(command, sizeof(command), "python3 getWeather.py");
    system(command);
}