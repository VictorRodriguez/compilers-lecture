%{
#include <stdio.h>
#include <time.h>
#include <string.h>
#include <curl/curl.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
void fetch_weather(void);
void print_weather_info(const char *weather_info);
void randomFeeling(void);

size_t write_callback(void *ptr, size_t size, size_t nmemb, void *stream) {
    strncat((char *)stream, (char *)ptr, size * nmemb);
    return size * nmemb;
}
%}

%token HELLO GOODBYE TIME NAME WEATHER FEELING ACTION

%%

chatbot : greeting
        | farewell
        | query
        | introduction
        | weather_query
        | feeling
        | action
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
introduction : NAME { printf("Chatbot: My name is Rata\n") ;}
        ;

weather_query : WEATHER { fetch_weather(); }
              ;
feeling : FEELING {  randomFeeling(); }
        ;

action : ACTION { printf("You should take some fresh air.\n") ;}
        ;
%%

int main() {
    srand(time(NULL));
    printf("Chatbot: Hi! You can greet me, ask for the time, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}


void fetch_weather(void) {
    CURL *curl;
    CURLcode res;
    char response[4096] = {0};
    // URL for weather in Guadalajara
    const char *url = "https://api.open-meteo.com/v1/forecast?latitude=20.6597&longitude=-103.3496&current_weather=true";

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();
    if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, response);

        res = curl_easy_perform(curl);

        if(res != CURLE_OK)
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        else {
            print_weather_info(response);
        }

        curl_easy_cleanup(curl);
    }

    curl_global_cleanup();
}

void print_weather_info(const char *weather_info) {
    char *ptr;
    ptr = strstr(weather_info, "\"current_weather\":{");
    if (ptr != NULL) {
        // print current information
        printf("Chatbot: Current Weather Information in Guadalajara\n");
        ptr += strlen("\"current_weather\":{");
        while (*ptr != '}') {
            // Extracting key
            char *key_start = strchr(ptr, '"') + 1;
            char *key_end = strchr(key_start, '"');
            *key_end = '\0';
            
            // Extracting value
            char *value_start = strchr(key_end + 1, ':') + 1;
            char *value_end;
            if (*value_start == '"') {
                value_start++;
                value_end = strchr(value_start, '"');
            } else {
                value_end = strpbrk(value_start, ",}");
            }
            *value_end = '\0';
            
            printf("%-15s : %s\n", key_start, value_start);
            
            ptr = value_end + 1;
            if (*ptr == ',') ptr++;
        }
    }
}


void randomFeeling() {
    // Random number between 1 and 3 
    int randomNumber = rand() % 3 + 1;

    // Different responses based on the number
    switch(randomNumber) {
        case 1:
            printf("Chatbot: Im feeling really good!\n");
            break;
        case 2:
            printf("Chatbot: Im tired\n");
            break;
        case 3:
            printf("Im perfect right now\n");
            break;
        default:
            printf("Im feeling okay\n");
    }
}
