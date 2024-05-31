%{
#include <stdio.h>
#include <time.h>
#include <curl/curl.h>
#include <stdlib.h>
#include <string.h>
#include <json-c/json.h> // Correct include for json-c library

void yyerror(const char *s);
int yylex(void);
void get_joke(void);
void get_pokemon(void);

%}

%token HELLO GOODBYE TIME LONELY SAD HAPPY POKEMON MONEY JOKE

%%

chatbot : greeting
        | farewell
        | time
        | joke
        | lonely
        | sad
        | happy
        | pokemon
        | money
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;

time : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

joke : JOKE { get_joke(); }
       ;

happy : HAPPY { printf("Chatbot: yyaaaayy everyone is happy today!!.\n"); }
        ;

lonely : LONELY { printf("Chatbot: Tec med is there for you! 33.3669.3005.\n"); }
        ;

sad : SAD { printf("Chatbot: Tec med is there for you! 33.3669.3005.\n"); }
     ;

pokemon : POKEMON { get_pokemon(); }
         ;

money : MONEY { printf("Chatbot: You should start working instead of talking to a bot.\n"); }
       ;

%%

// Additional C Functions for API Calls

struct Response {
    char *data;
    size_t size;
};

size_t write_response(void *ptr, size_t size, size_t nmemb, struct Response *response) {
    size_t new_len = response->size + size * nmemb;
    response->data = realloc(response->data, new_len + 1);
    if (response->data == NULL) {
        fprintf(stderr, "realloc() failed\n");
        exit(EXIT_FAILURE);
    }
    memcpy(response->data + response->size, ptr, size * nmemb);
    response->data[new_len] = '\0';
    response->size = new_len;

    return size * nmemb;
}

size_t write_response2(void *ptr, size_t size, size_t nmemb, char *data) {
    strcat(data, (char *)ptr);
    return size * nmemb;
}

void get_joke() {
    CURL *curl;
    CURLcode res;
    struct Response response;
    response.data = malloc(1);
    response.size = 0;

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://official-joke-api.appspot.com/random_joke");
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_response);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);

        res = curl_easy_perform(curl);
        if(res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        } else {
            // Parsing the joke response using json-c
            struct json_object *parsed_json;
            struct json_object *setup;
            struct json_object *punchline;

            parsed_json = json_tokener_parse(response.data);
            if (json_object_object_get_ex(parsed_json, "setup", &setup) &&
                json_object_object_get_ex(parsed_json, "punchline", &punchline)) {
                printf("Chatbot: Here's a joke for you: %s %s\n",
                       json_object_get_string(setup), json_object_get_string(punchline));
            } else {
                printf("Chatbot: Failed to parse the joke properly.\n");
            }

            json_object_put(parsed_json); // Free memory
        }
        curl_easy_cleanup(curl);
    }
    curl_global_cleanup();
    free(response.data);
}

void get_pokemon() {
    CURL *curl;
    CURLcode res;
    struct Response response;
    response.data = malloc(1);
    response.size = 0;

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if(curl) {
        int pokemon_id = rand() % 151 + 1;
        char url[100];
        snprintf(url, sizeof(url), "https://pokeapi.co/api/v2/pokemon/%d", pokemon_id);

        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_response);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);

        res = curl_easy_perform(curl);
        if(res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        } else {
            struct json_object *parsed_json;
            struct json_object *name;
            struct json_object *abilities;
            struct json_object *types;
            struct json_object *ability;
            struct json_object *type;
            struct json_object *ability_name;
            struct json_object *type_name;
            size_t i;

            parsed_json = json_tokener_parse(response.data);
            if (json_object_object_get_ex(parsed_json, "name", &name) &&
                json_object_object_get_ex(parsed_json, "abilities", &abilities) &&
                json_object_object_get_ex(parsed_json, "types", &types)) {
                
                printf("Chatbot: You got a Pokémon! Its name is %s.\n", json_object_get_string(name));
                printf("Abilities:\n");
                for (i = 0; i < json_object_array_length(abilities); i++) {
                    ability = json_object_array_get_idx(abilities, i);
                    if (json_object_object_get_ex(ability, "ability", &ability_name)) {
                        printf("- %s\n", json_object_get_string(json_object_object_get(ability_name, "name")));
                    }
                }
                
                printf("Types:\n");
                for (i = 0; i < json_object_array_length(types); i++) {
                    type = json_object_array_get_idx(types, i);
                    if (json_object_object_get_ex(type, "type", &type_name)) {
                        printf("- %s\n", json_object_get_string(json_object_object_get(type_name, "name")));
                    }
                }
            } else {
                printf("Chatbot: Failed to parse the Pokémon data properly.\n");
            }

            json_object_put(parsed_json); // Free memory
        }
        curl_easy_cleanup(curl);
    }
    curl_global_cleanup();
    free(response.data);
}

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask for a pokemon, ask for a quote, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: My creator is lazy and didn't teach me how to answer to that question :c .\n");
}