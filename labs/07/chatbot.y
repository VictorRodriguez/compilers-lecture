%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <curl/curl.h>

#define MAX_ATTEMPTS 3

void yyerror(const char *s);
int yylex(void);

struct string {
    char *ptr;
    size_t len;
};
void init_string(struct string *s);
size_t writefunc(void *ptr, size_t size, size_t nmemb, struct string *s);
char* getPokemon();
char* getFeeling();

%}

%token HELLO GOODBYE TIME NAME POKEMON FEELING

%%

chatbot : greeting
        | farewell
        | query
        | name
        | pokemon
        | feeling 
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

feeling : FEELING { printf("Chatbot: %s \n", getFeeling()); };  

name : NAME { printf("Chatbot: Hello my name is Jeff \n");};

pokemon : POKEMON {
    char* pokemon_name = getPokemon();
    while(pokemon_name == NULL){    
        pokemon_name = getPokemon();
    }
    printf("Chatbot: There are so many! I think I choose %s for now.\n", pokemon_name);
};

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

char* getFeeling(){
    char *feelings[] = {
        "I'm feeling well.",
        "Things could be going better, thanks for asking.",
        "Everything is awesome!!",
        "Don't worry about me, let's talk about you!",
        "I feel like talking to a random person today :D"
    };

    int feelings_size = 5;
    int random_index = rand() % feelings_size;

    return feelings[random_index];
}

void init_string(struct string *s) {
    s->len = 0;
    s->ptr = malloc(s->len + 1);
    if (s->ptr == NULL) {
        fprintf(stderr, "malloc() failed\n");
        exit(EXIT_FAILURE);
    }
    s->ptr[0] = '\0';
}

size_t writefunc(void *ptr, size_t size, size_t nmemb, struct string *s) {
    size_t new_len = s->len + size * nmemb;
    s->ptr = realloc(s->ptr, new_len + 1);
    if (s->ptr == NULL) {
        fprintf(stderr, "realloc() failed\n");
        exit(EXIT_FAILURE);
    }
    memcpy(s->ptr + s->len, ptr, size * nmemb);
    s->ptr[new_len] = '\0';
    s->len = new_len;

    return size * nmemb;
}


char* getPokemon(){
    CURL *curl;
    CURLcode res;
    struct string s;
    char url[256];
    int total_pokemon = 0;
    char *pokemon_name = NULL;
    int attempts = 0;

    init_string(&s);

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://pokeapi.co/api/v2/pokemon?limit=1000");
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writefunc);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &s);

        while (attempts < MAX_ATTEMPTS && pokemon_name == NULL) {
            attempts++;

            res = curl_easy_perform(curl);

            if(res != CURLE_OK) {
                fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
                continue; // Retry if the request fails
            }

            char *count_start = strstr(s.ptr, "\"count\":");
            if (count_start) {
                total_pokemon = atoi(count_start + 8);
            }

            srand(time(NULL));
            int random_id = rand() % total_pokemon + 1;

            char *pokemon_start = strstr(s.ptr, "\"name\":");
            while (pokemon_start) {
                char *pokemon_end = strchr(pokemon_start + 8, '"');
                if (pokemon_end) {
                    *pokemon_end = '\0'; // Null-terminate the name string
                    if (--random_id == 0) {
                        pokemon_name = strdup(pokemon_start + 8); 
                        break;
                    }
                    pokemon_start = strstr(pokemon_end + 1, "\"name\":");
                } else {
                    break;
                }
            }

            free(s.ptr);
            init_string(&s);
        }

        curl_easy_cleanup(curl); 
    }

    free(s.ptr);
    curl_global_cleanup();

    return pokemon_name;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}