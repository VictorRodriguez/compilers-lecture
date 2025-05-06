%{
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <curl/curl.h>
#include "cJSON.h"

#define YYSTYPE char*

void yyerror(const char *s);
int yylex(void);

size_t write_callback(void *ptr, size_t size, size_t nmemb, void *data) {
    strncat((char*)data, (char *)ptr, size * nmemb);
    return size * nmemb;
}

void display_movie_info(const cJSON *movie) {
    printf("\nMovie Information:\n");

    cJSON *title = cJSON_GetObjectItemCaseSensitive(movie, "Title");
    cJSON *year = cJSON_GetObjectItemCaseSensitive(movie, "Year");
    cJSON *rated = cJSON_GetObjectItemCaseSensitive(movie, "Rated");
    cJSON *genre = cJSON_GetObjectItemCaseSensitive(movie, "Genre");
    cJSON *director = cJSON_GetObjectItemCaseSensitive(movie, "Director");
    cJSON *actors = cJSON_GetObjectItemCaseSensitive(movie, "Actors");
    cJSON *plot = cJSON_GetObjectItemCaseSensitive(movie, "Plot");
    cJSON *ratings = cJSON_GetObjectItemCaseSensitive(movie, "Ratings");

    if (title && year && rated && genre && director && actors && plot && ratings) {
        printf("Title: %s\n", cJSON_GetStringValue(title));
        printf("Year: %s\n", cJSON_GetStringValue(year));
        printf("Rated: %s\n", cJSON_GetStringValue(rated));
        printf("Genre: %s\n", cJSON_GetStringValue(genre));
        printf("Director: %s\n", cJSON_GetStringValue(director));
        printf("Actors: %s\n", cJSON_GetStringValue(actors));
        printf("Plot: %s\n", cJSON_GetStringValue(plot));

        cJSON *rating = NULL;
        cJSON_ArrayForEach(rating, ratings) {
            cJSON *source = cJSON_GetObjectItemCaseSensitive(rating, "Source");
            cJSON *value = cJSON_GetObjectItemCaseSensitive(rating, "Value");
            if (source && value) {
                printf("%s: %s\n", cJSON_GetStringValue(source), cJSON_GetStringValue(value));
            }
        }
        printf("\n");
    } else {
        printf("Error: Unable to retrieve movie information.\n");
    }
}

void search_movie(const char *query) {
    CURL *curl;
    CURLcode res;
    char url[256];
    char response[4096] = {0};

    curl = curl_easy_init();
    if (!curl) {
        fprintf(stderr, "Failed to initialize libcurl.\n");
        return;
    }

    char *encoded_query = curl_easy_escape(curl, query, 0);
    if (!encoded_query) {
        fprintf(stderr, "Failed to encode the query string.\n");
        curl_easy_cleanup(curl);
        return;
    }

    snprintf(url, sizeof(url), "http://www.omdbapi.com/?apikey=4f5a49d3&t=%s", encoded_query);
    curl_free(encoded_query);

    curl_easy_setopt(curl, CURLOPT_URL, url);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, response);

    res = curl_easy_perform(curl);
    if (res != CURLE_OK) {
        fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
    } else {
        cJSON *root = cJSON_Parse(response);
        if (root) {
            display_movie_info(root);
            cJSON_Delete(root);
        } else {
            fprintf(stderr, "Error: Unable to parse JSON response.\n");
        }
    }

    curl_easy_cleanup(curl);
}

%}

%token HELLO GOODBYE TIME WEATHER HELP DRAW MOVIE_INFO

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
        | WEATHER {
            printf("Chatbot: The weather is sunny with a chance of rain later today.\n");
         }
        | MOVIE_INFO {
            char *movieTitle = $1;

            if (movieTitle) {
                while (isspace(*movieTitle)) {
                    movieTitle++;
                }
                if (*movieTitle != '\0') {
                    char *end = movieTitle + strlen(movieTitle) - 1;
                    while (end >= movieTitle && isspace(*end)) {
                        *end-- = '\0';
                    }
                    printf("Chatbot: Let me see the movie: \"%s\".\n", movieTitle);
                    search_movie(movieTitle);
                } else {
                    printf("Chatbot: I couldn't find the movie title in your input.\n");
                }
                free(movieTitle);
            } else {
                printf("Chatbot: Invalid movie title.\n");
            }
        }
        | DRAW {
            printf("Chatbot: Here is a drawing for you!\n");
            printf("  _______\n");
            printf(" /       \\\n");
            printf("|  O   O  |\n");
            printf("|    ^    |\n");
            printf("|  \\___/  |\n");
            printf(" \\_______/\n");
         }
        | HELP {
            printf("Chatbot: I can help you with the following commands:\n");
            printf("  - Say 'hello', 'hi', 'hey' to greet me.\n");
            printf("  - Ask 'what is the time?' or 'what time is it?' to get the current time.\n");
            printf("  - Ask 'what's the weather like?' or 'what is the weather?' to get the weather.\n");
            printf("  - Say 'goodbye', 'bye', 'see you', or 'later' to end the conversation.\n");
            printf("  - Type 'draw something' to see an ASCII drawing.\n");
            printf("\n");
            printf("API FEATURE IN CHATBOT:");
            printf("  * If you want some specific movie information, let's try the OMDb API, type 'about <movietitle>' as in movie title try Avengers, Minions, etc.\n");
         }
        ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, weather, say goodbye, or even get some movie cool facts, FOR MORE INFO TYPE 'help'\n");
    while (yyparse() == 0) {
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
