%{
#include <stdio.h>
#include <time.h>
// Could not make Curl work

void yyerror(const char *s);
int yylex(void);
void print_tree();
void get_weather();

void print_tree();
void get_weather();

%}

%token HELLO GOODBYE TIME NAME TREE WEATHER MOOD
%%

chatbot : greeting
        | farewell
        | query
        | name
        | mood
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); } ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); } ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
         | TREE { printf("Chatbot: Of course, there is a tree:\n");
                  print_tree();
         } ;

name : NAME { printf("Chatbot: My name is YePeeTee, nice to meet you!!!\n"); } ;

mood : MOOD { printf("Chatbot: I'm doing great, thanks :)\n"); } ;
%%

void print_tree()
{
    int levels = 10;
    for (int i = 0; i < levels; i++) {
        // Print spaces
        for (int j = 0; j < levels - i - 1; j++) {
            printf(" ");
        }
        // Print stars
        for (int k = 0; k < 2 * i + 1; k++) {
            printf("*");
        }
        // Move to the next line
        printf("\n");
    }

    // Print the trunk of the tree
    for (int i = 0; i < levels - 1; i++) {
        printf(" ");
    }
    printf("|\n");
}

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