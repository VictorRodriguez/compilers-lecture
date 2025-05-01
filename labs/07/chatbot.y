%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE THANKS HOWAREYOU NAME TIME GOODMORNING GOODAFTERNOON GOODEVENING DAY WEATHER

%%

chatbuddy : greeting
           | farewell
           | gratitude
           | inquiry
           | query
           ;

greeting : HELLO { printf("ChatBuddy: Hello! How can I assist you today?\n"); }
         | GOODMORNING { printf("ChatBuddy: Good morning! How can I assist you this morning?\n"); }
         | GOODAFTERNOON { printf("ChatBuddy: Good afternoon! How can I assist you this afternoon?\n"); }
         | GOODEVENING { printf("ChatBuddy: Good evening! How can I assist you this evening?\n"); }
         ;

farewell : GOODBYE { printf("ChatBuddy: Goodbye! Have a great day!\n"); }
         ;

gratitude : THANKS { printf("ChatBuddy: You're welcome!\n"); }
          ;

inquiry : HOWAREYOU { printf("ChatBuddy: I'm just a program, but I'm here to help you!\n"); }
        | NAME { printf("ChatBuddy: My name is ChatBuddy. Nice to meet you!\n"); }
        | DAY {
              time_t now = time(NULL);
              struct tm *local = localtime(&now);
              char buffer[100];
              strftime(buffer, 100, "ChatBuddy: Today is %A, %B %d, %Y.\n", local);
              printf("%s", buffer);
          }
        | WEATHER { printf("ChatBuddy: I'm not connected to the internet, so I can't tell you the weather right now.\n"); }
        ;

query : TIME { 
           time_t now = time(NULL);
           struct tm *local = localtime(&now);
           printf("ChatBuddy: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

%%

int main() {
    printf("ChatBuddy: Hi! You can greet me, ask for the time, day, weather, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "ChatBuddy: I didn't understand that.\n");
}
