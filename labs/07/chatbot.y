%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME WEATHER HOWAREYOU COLOR AGE HOBBY

%%

chatbot : greeting
        | farewell
        | query
        | name
        | weather
        | howareyou
        | color
        | age
        | hobby
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

name : NAME { printf("Chatbot: My name is Bailey.\n"); }
     ;

weather : WEATHER { printf("Chatbot: I'm not sure about the weather, but I hope it's nice!\n"); }
        ;

howareyou : HOWAREYOU { printf("Chatbot: I'm functioning as expected. How about you?\n"); }
          ;

color : COLOR { printf("Chatbot: My favorite color is pink!\n"); }
      ;

age : AGE { printf("Chatbot: I don't age, I'm just a program.\n"); }
    ;

hobby : HOBBY { printf("Chatbot: I enjoy chatting with users like you!\n"); }
      ;

%%

int main() {
    printf("Chatbot: Hi! Ask me something.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}