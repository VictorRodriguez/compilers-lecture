%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME HOWAREYOU CREATOR PURPOSE COLOR JOKE

%%

chatbot : greeting
        | farewell
        | query
        | name_query
        | howareyou_query
        | creator_query
        | purpose_query
        | color_query
        | joke_query
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

name_query : NAME { printf("Chatbot: My name is Tranquilino Espinosa de los Monteros.\n"); }
           ;

howareyou_query : HOWAREYOU { printf("Chatbot: I'm really well, thanks for asking! Hope you are doing well too!\n"); }
                ;

creator_query : CREATOR { printf("Chatbot: I was created by Ricardo.\n"); }
              ;

purpose_query : PURPOSE { printf("Chatbot: My purpose is to assist and provide information.\n"); }
              ;

color_query : COLOR { printf("Chatbot: My favorite color is blue.\n"); }
            ;

joke_query : JOKE { printf("Chatbot: Why don't scientists trust atoms? Because they make up everything!\n"); }
           ;

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