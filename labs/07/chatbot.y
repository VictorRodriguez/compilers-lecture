%{
    #include <stdio.h>
    #include <time.h>

    void yyerror(const char *s);
    int yylex(void);
    void get_random_character();
%}

%token HELLO GOODBYE TIME NAME HOWAREYOU FELLOWSHIP JOURNEY

%%

chatbot : greeting
        | farewell
        | query
        | name
        | howAreYou
        | fellowship
        | journey
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

name : NAME { printf("Chatbot: My name is Gandalf the gray, pleased to meet you young traveller.\n");}
     ;

howAreYou : HOWAREYOU {printf("I'm alert in case Sauron's minions attack us, besides that, I'm excellent!\n");}
          ;

fellowship : FELLOWSHIP { get_random_character(); }
           ;

journey : JOURNEY {printf("Chatbot: I'm on my way to Mordor, along with mycompanions!\n");}
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

void get_random_character(){
    const char *fellowship_ring[] = {
        "Legolas",
        "Gimli",
        "Aragorn",
        "Boromir",
        "Frodo",
        "Sam",
        "Merry",
        "Pippin"
    };

    int n = sizeof(fellowship_ring)/sizeof(fellowship_ring[0]);
    int selection = rand() % n;

    printf("Each member is unique, but if I have to choose someone it definitely will be %s.\n",fellowship_ring[selection]);
}