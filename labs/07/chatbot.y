%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>
#include <jansson.h>

void yyerror(const char *s);
int yylex(void);

extern char character_name[];

size_t write_callback(void *, size_t, size_t, void *);
int fetch_data_from_swapi(char *);
void get_parsed_character_request(char *, char *);
void make_request(char *, char *);
char* replaceSpaces(const char*);

const char* faild_message = "Mmmh... I cannot understand you :/\n>";
%}



%token HELLO GOODBYE TIME CHECK_CHARACTER

%%

chatbot : greeting
        | farewell
        | query
        | queryStarwars
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today? You can ask me about Start Wars characters\n>"); }
        ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Come back anytime!\n"); }
        ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n>", local->tm_hour, local->tm_min);
        }
        ;
queryStarwars : CHECK_CHARACTER {
    char *baseURL = "https://swapi.dev/api/people/?search=";

    // Append the base url to the character_name received from lex
    size_t url_len = strlen(baseURL);
    size_t name_len = strlen(character_name);
    char *queryURL = (char *)malloc(url_len + name_len + 1);
    if (queryURL == NULL) {
        fprintf(stderr, "%s [Memory allocation failed]\n>", faild_message);
        return 1;
    }
    strcpy(queryURL, baseURL);
    strcat(queryURL, character_name);

    // Make sure each space on the final url gets converted into "%20"
    queryURL = replaceSpaces(queryURL);

    // fetch
    make_request(queryURL, character_name);
}
%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask for a Star Wars character, or say goodbye.\n>");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that. If you tried to look for a Star Wars Character, try 'Tell me about Luke?'\n");
}

char* replaceSpaces(const char* str) {
    int spaceCount = 0;
    int length = 0;
    const char *temp = str;

    while (*temp) {
        if (*temp == ' ') {
            spaceCount++;
        }
        length++;
        temp++;
    }


    int newLength = length + spaceCount * 2;

    char *result = (char *)malloc(newLength + 1);
    if (result == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    const char *original = str;
    char *newStr = result;

    while (*original) {
        if (*original == ' ') {
            *newStr++ = '%';
            *newStr++ = '2';
            *newStr++ = '0';
        } else {
            *newStr++ = *original;
        }
        original++;
    }

    *newStr = '\0';

    return result;
}

size_t WriteCallback(void *contents, size_t size, size_t nmemb, void *userp) {
    size_t realsize = size * nmemb;
    char **buffer = (char **)userp;

    *buffer = realloc(*buffer, strlen(*buffer) + realsize + 1);
    if (*buffer == NULL) {
        perror("realloc");
        return 0;
    }

    strncat(*buffer, (char *)contents, realsize);
    return realsize;
}

void make_request(char *url, char *character_name) {
    CURL *curl;
    CURLcode res;
    char *output = NULL;

    output = malloc(1);
    if (output == NULL) {
        perror("malloc");
        return;
    }
    output[0] = '\0';

    curl = curl_easy_init();
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)&output);
        res = curl_easy_perform(curl);

        if (res != CURLE_OK) {
            fprintf(stderr, "%s [curl_easy_perform() failed]: %s\n>", faild_message, curl_easy_strerror(res));
        } else {
            get_parsed_character_request(output, character_name);

        }

        curl_easy_cleanup(curl);
    }

    free(output);
}


void get_parsed_character_request(char *json_string, char *character_name) {
    json_error_t error;
    json_t *root = json_loads(json_string, 0, &error);

    if (!root) {
        puts("Mmmh, that's an odd name... Are you sure you spell it right? Does it even exist?\n>");
        return;
    }

    json_t *results = json_object_get(root, "results");

    if (!json_is_array(results)) {
        printf("Mmmh, '%s' is an odd name... Are you sure you spell it right? Does it even exist?\n>", character_name);
        json_decref(root);
        return;
    }

    // If the results array length, is most liekly the wasn't any name matched on the API.
    // Returning something to make understand that the name wasn't found
    size_t results_len = json_array_size(results);
    if (results_len == 0) {
        printf("Mmmh, '%s' is an odd name... Are you sure you spell it right? Does it even exist?\n>", character_name);

        json_decref(root);
        return;
    }


    // FINALLY THE ACTUAL JSON PARSING!!! 
    size_t index;
    json_t *value;
    json_array_foreach(results, index, value) {
        const char *name = json_string_value(json_object_get(value, "name"));
        const char *height = json_string_value(json_object_get(value, "height"));
        const char *mass = json_string_value(json_object_get(value, "mass"));
        const char *birth_year = json_string_value(json_object_get(value, "birth_year"));
        const char *skin_color = json_string_value(json_object_get(value, "skin_color"));
        const char *gender = json_string_value(json_object_get(value, "gender"));

        printf("\n%s was born in %s.\n", name, birth_year);
        printf("They are %s tall and their skin tone is %s.\n", height, skin_color);
        printf("Oh, and %s's gender is %s.\nGo ahead and ask me about someone else!\n>", name, gender);
    }

    json_decref(root);
}
