%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);

const char* get_month_name(int month) {
    static const char* months[] = {
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    };
    if (month >= 0 && month < 12)
        return months[month];
    return "Unknown";
}

const char* get_day_suffix(int day) {
    if (day % 10 == 1 && day != 11) {
        return "st";
    } else if (day % 10 == 2 && day != 12) {
        return "nd";
    } else if (day % 10 == 3 && day != 13) {
        return "rd";
    } else {
        return "th";
    }
}
%}

%token HELLO GOODBYE NAME TIME EMOTION DATE

%%

chatbot : greeting
        | farewell
        | query
        | called
        | emotion
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;

called : NAME { printf("Chatbot: My name is Jeff!\n"); }
       ;

emotion : EMOTION { if (rand() % 2 == 0) {
                        printf("Chatbot: Couldn't be better! :D\n");
                    } else {
                        printf("Chatbot: Please ask later... T-T\n");
                    }
                }
        ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
         | DATE {
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: Today's date is %s %d%s, %d.\n",
                   get_month_name(local->tm_mon),
                   local->tm_mday,
                   get_day_suffix(local->tm_mday),
                   local->tm_year + 1900);
         }

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