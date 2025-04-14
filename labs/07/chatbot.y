                                                                                      
%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME STATUS NAME TIMEJ

%%

chatbot : greeting
        | farewell
        | querytime
        | wellbeing
        | name
        ;

greeting : HELLO { printf("Chatbot: Hey Bro! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;

querytime : TIME {
            /*time zone established in Mexico*/
            setenv("TZ", "America/Mexico_City", 1);
            tzset();
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time in Mexico is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;
wellbeing : STATUS {
            /*Response to status question*/
            printf("Chatbot: I'm doing well, thanks for asking\n");
         }
        ;
name : NAME {
            /*Response to name question*/
            printf ("Chatbot: I'm BeatBot\n");
         }
        ;
querytime : TIMEJ {
            /*time zone established in Japan*/
            setenv("TZ", "Asia/Tokyo", 1);
            tzset();
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time in Japan is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

%%

int main() {
    printf("Chatbot: Hi! I'm BeatBot. You can ask me for the time in Mexico and Japan, my name, greet me, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}