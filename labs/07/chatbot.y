%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME EXIT

%%

conversation : statement 
             | statement conversation
             ;

statement : greeting 
          | farewell 
          | query
          | exit_command
          ;

greeting : HELLO { printf("Assistant: Hi there! What can I do for you?\n"); }
         ;

farewell : GOODBYE { printf("Assistant: Take care! See you next time!\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Assistant: It's currently %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

exit_command : EXIT { printf("Assistant: Goodbye! Ending chat.\n"); exit(0); }
             ;

%%

int main() {
    printf("Assistant: Welcome! Feel free to greet, ask for the time, or say goodbye.\n");
    while (1) {
        yyparse();
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Assistant: I didn't catch that. Could you repeat?\n");
}