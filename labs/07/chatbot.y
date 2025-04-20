%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h> 

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME DICE NAME GAME

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

      | DICE {
            srand(time(NULL));
            printf("Chatbot: Of course! The result is: %d \n", 1 + rand() % 6);
        }

      | NAME {
            printf("Chatbot: My name is Wheatley. I was named after the Portal 2 character and was created using Lex & Yacc!!\n");
        }

      | GAME {
            int n;
            char userInput, randomNumber;
        
            srand(time(NULL));
            n = rand() % 100;
        
            if (n < 33)
                randomNumber = 'r';
        
            else if (n > 33 && n < 66)
                randomNumber = 'p';
        
            else
                randomNumber = 's';
        
            printf("\nEnter r for rock, p for paper and s for scissor\n");
            scanf("%c", &userInput);
            while ((getchar()) != '\n');

            if (userInput == randomNumber)
                printf("Tie !!\n");

            else if (userInput == 'r' && randomNumber == 'p')
                printf("Hey, I won!!\n");
 
            else if (userInput == 'p' && randomNumber == 'r')
                printf("You won!!\n");

            else if (userInput == 'r' && randomNumber == 's')
                printf("You won!!\n");
        
            else if (userInput == 's' && randomNumber == 'r')
                printf("Hey, I won!!\n");
        
            else if (userInput == 'p' && randomNumber == 's')
                printf("Hey, I won!!\n");
        
            else if (userInput == 's' && randomNumber == 'p')
                printf("You won!!\n");
            
            else
                printf("Mmm... That's not how you are supposed to play\n");
        }
       ;

%%

int main() {
    printf("Chatbot: Hi! you can greet me, ask for the time, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}