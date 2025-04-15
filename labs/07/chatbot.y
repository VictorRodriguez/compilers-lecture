%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);

union {
    int intValue;
    float floatValue;
} yyval;
%}

%union {
    int intValue;
    float floatValue;
}

%token <intValue> INUM
%token <floatValue> FNUM
%token HELLO GOODBYE TIME SUM CALCULATION COMBO

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
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
        |
        COMBO INUM {
            char combos[6][30] = {
                "pollo con papas", 
                "hamburguesa con papas", 
                "hamburguesa con aros",
                "refresco con helado",
                "pollo y refresco",
                "hamburguesa con refresco"
            };
            int number = $2 - 1;
            printf("Chatbot: The combo number %d is %s", $2, combos[number]); 
        }

        |
        CALCULATION INUM SUM INUM {
            int res = $2 + $4;
            printf("Chatbot: The result is %d\n", res);
        }
        |
        CALCULATION FNUM SUM INUM {
            float res = $2 + $4;
            printf("Chatbot: The result is %f\n", res);
        }
        |
        CALCULATION INUM SUM FNUM {
            float res = $2 + $4;
            printf("Chatbot: The result is %f\n", res);
        }
        |
        CALCULATION FNUM SUM FNUM {
            float res = $2 + $4;
            printf("Chatbot: The result is %f\n", res);
        }
       ;



%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask for the result of a sum, ask for 1 of the 6 combos of the day or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}