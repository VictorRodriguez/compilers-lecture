%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
void print_random_response(void);
void print_random_mood(void);

%}

%token HELLO GOODBYE TIME WEATHER MAGIC_8_BALL PING MOOD

%%

chatbot : greeting
        | farewell
        | query
        | query2
        | magic_8_ball
        | ping
        | mood
        ;

ping : PING {printf("Chatbot: Pong\n");}

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

query2 : WEATHER { 
            system("curl wttr.in/?format=%l:+%c+%f+%h+%p+%P+%m+%w+%S+%");
            printf("\n");
         }
       ;

magic_8_ball : MAGIC_8_BALL { print_random_response(); }
            ;

mood : MOOD { print_random_mood(); }
             ;

%%

int main() {
    srand(time(NULL));  // Inicializa la semilla para la generación de números aleatorios
    printf("Chatbot: Hi! You can greet me, ask for the time, say goodbye, ask the weather, ask my mood, or ask the magic 8-ball.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}

void print_random_response() {
    const char *responses[] = {
        "It is certain",
        "Reply hazy, try again",
        "Don’t count on it",
        "It is decidedly so",
        "Ask again later",
        "My reply is no",
        "Without a doubt",
        "Better not tell you now",
        "My sources say no",
        "Yes definitely",
        "Cannot predict now",
        "Outlook not so good",
        "You may rely on it",
        "Concentrate and ask again",
        "Very doubtful",
        "As I see it, yes",
        "Most likely",
        "Outlook good",
        "Yes",
        "Signs point to yes"
    };

    int num_responses = sizeof(responses) / sizeof(responses[0]);
    int random_index = rand() % num_responses;
    printf("Chatbot: %s\n", responses[random_index]);
}

void print_random_mood() {
    const char *moods[]  = {
    "Happy 😊", "Sad 😢", "Excited 🤩", "Angry 😠", "Content 😌", "Frustrated 😤", "Nervous 😰", 
    "Relaxed 😎", "Anxious 😟", "Joyful 😁", "Bored 😐", "Confident 😏", "Disappointed 😞", 
    "Hopeful 🙏", "Surprised 😲", "Scared 😨", "Calm 😇", "Lonely 😔", "Grateful 🙌", "Curious 🤔", 
    "Energetic ⚡", "Tired 😴", "Peaceful 🕊️", "Depressed 😭", "Proud 🥳", "Ashamed 😳", 
    "Embarrassed 😳", "Enthusiastic 😃", "Gloomy 🌧️", "Insecure 😬", "Inspired 🌟", "Jealous 😒", 
    "Melancholic 😿", "Mischievous 😈", "Optimistic 🌞", "Pessimistic 🌧️", "Relieved 😌", 
    "Resentful 😠", "Skeptical 🤨", "Sympathetic 🥺", "Tender 🥰", "Thoughtful 🤔", "Timid 😶", 
    "Trusting 🤝", "Vulnerable 😢", "Weary 😩", "Worried 😟", "Indifferent 😐", "Euphoric 🤗", 
    "Affectionate 😍"
    };


    int num_responses = sizeof(moods) / sizeof(moods[0]);
    int random_index = rand() % num_responses;
    printf("Chatbot: I am %s\n", moods[random_index]);
}
