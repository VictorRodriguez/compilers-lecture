%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME ANIME SPORT WEATHER FOOD

%%

chatbot : greeting
        | farewell
        | query
	| serie
	| exercise
	| sky
	| plate
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

serie : ANIME {printf("Chatbot: JOJO is the only correct answer\n");}
      ;

exercise : SPORT {printf("Chatbot: Tennis is the only correct answer\n");}
       ;

sky : WEATHER {printf("Chatbot: You are in HEEEEELLLLLLL!!!!\n");}
    ;

plate : FOOD {printf("Chatbot: PIZZAAAAA 'Pizza with pineaple is the best'!!!\n");}

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
