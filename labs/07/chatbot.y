%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME WEATHER MOOD HELP

%%

chatbot : greeting
        | farewell
        | time_query
        | name_query
        | weather_query
        | mood_query
        | help_query
        ;

greeting : HELLO { printf("MarIA: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("MarIA: Goodbye! Have a great day!\n"); }
         ;

time_query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("MarIA: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

name_query : NAME {
            printf("MarIA: My name is MarIA, nice to meet you!\n");
         }
        ;

weather_query : WEATHER { 
            int status = system("curl -s wttr.in > /dev/null");
            if (status == 0) {
                printf("MarIA: Here's the weather in Guadalajara, Mexico:\n");
                system("curl -s wttr.in/Guadalajara,Mexico | sed -n '3,7p'");
            } else {
                printf("MarIA: There seems to be an issue. Maybe try again later?\n");
            }
         }
       ;

mood_query : MOOD {
            printf("MarIA: I'm fine, thanks for asking.\n");
         }
        ;

help_query : HELP {
            printf("MarIA: You can\n");
            printf("        • Greet me\n");
            printf("        • Ask my name\n");
            printf("        • Ask how I am doing\n");
            printf("        • Ask for the time\n");
            printf("        • Ask for the weather\n");
            printf("        • Say goodbye\n");
         }
        ;

%%

int main() {
    printf("MarIA: Hi, I'm MarIA! Type 'help' to see what you can ask me.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "MarIA: I didn't understand that.\n");
}