%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME WEATHER HOWAREYOU WRYD SINGREQUEST

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
                setenv("TZ", "CST6", 1);
                tzset();
                time_t now = time(NULL);
                struct tm *local = localtime(&now);
                printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
        }
;

query : WEATHER {
                printf("Chatbot: It seems like the weather in Zapopan, Jalisco is quite charming at the moment!\n");
        }
;

query : HOWAREYOU {
                printf("Chatbot: Feeling the heat, but still keeping it cool!\n");
        }
;

query : WRYD {
                printf("Chatbot: Answering your questions!\n");
        }
;

query : SINGREQUEST {
        printf("Chatbot:\n"
                "Twinkle, twinkle little star\n"
                "How I wonder what you are\n"
                "Up above the world so high\n"
                "Like a diamond in the sky\n\n"

                "Twinkle, twinkle little star\n"
                "How I wonder what you are\n\n"

                "Twinkle, twinkle little star\n"
                "How I wonder what you are\n"
                "Up above the world so high\n"
                "Like a diamond in the sky\n\n"

                "Twinkle, twinkle little star\n"
                "How I wonder what you are\n");
        }
;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask me for the weather, ask me what I'm doing, ask me how I'm doing, ask me to sing a song or $
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
