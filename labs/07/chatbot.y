%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

// Fernando López Gómez | A01639715

%token HELLO GOODBYE TIME CLASS NAME DOING

%%

chatbot : greeting
        | farewell
        | query
	| class
	| name
	| doing
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

class : CLASS{ printf("Chatbot: You are currently enrolled in TC3002B class\n"); }
      ;

name : NAME{ printf("Chatbot: My name is Chad the Chatbot\n" ); }
     ;

doing : DOING{ printf("Chatbot: I'm doing great. Thank you for asking! \n"); }
      ;




%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask for your class, or say g odbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: Sorry, I didn't understand that.\n");
}
