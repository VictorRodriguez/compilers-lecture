%{
#include <stdio.h>

void yyerror(const char *s);
int yylex(void);
%}

%token WHAT_IS_FC_BARCELONA WHO_IS_COACH WHO_IS_CAPTAIN HOW_MANY_TITLES HOW_MANY_UCL_TITLES COLORS EXIT

%%

chatbot : what_is_fc_barcelona
         | who_is_coach
         | who_is_captain
         | how_many_titles
         | colors
         | exit
         ;

what_is_fc_barcelona : WHAT_IS_FC_BARCELONA { printf("Chatbot: FC Barcelona is a professional football club based in Barcelona, Catalunya.\n"); }
                     ;

who_is_coach : WHO_IS_COACH { printf("Chatbot: The current coach of FC Barcelona is Hansi Flick.\n"); }

who_is_captain : WHO_IS_CAPTAIN { printf("Chatbot: FC Barcelona has more than one captain (5), and they are: Sergi Roberto, Marc Andre Terstegen, Ronald Araujo and Frenkie de Jong.\n"); }

how_many_titles : HOW_MANY_TITLES { printf("Chatbot: FC Barcelona has won 27 La Liga titles.\n"); }

how_many_ucl_titles : HOW_MANY_UCL_TITLES { printf("Chatbot: FC Barcelona has won 5 UEFA Champions League titles. They will win the sixth one soon with Flickwagen!\n"); }

colors : COLORS { printf("Chatbot: The colors of FC Barcelona are blue and garnet (dark red).\n"); }

exit : EXIT { printf("Chatbot: Goodbye!\n"); }

%%

int main() {
    printf("Chatbot: Hi! Ask me anything about FC Barcelona. Type 'exit' to quit.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}