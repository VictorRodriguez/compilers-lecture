%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <curl/curl.h>

#define MAX_ATTEMPTS 3

void yyerror(const char *s);
int yylex(void);
void get_current_weather();
char* find_second_occurrence(const char* json_str, const char* key);
%}

%token HELLO GOODBYE TIME NAME WEATHER DICE ADVICE 
%%

chatbot : greeting
        | farewell
        | timeQuery
        | weatherQuery
        | rollDice
        | name
        | advice 
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Bye bye! See you soon!\n"); }
         ;

timeQuery : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
            }
          ;

weatherQuery : WEATHER { get_current_weather(); }
             ;

rollDice : DICE {
           srand(time(NULL));
           int dice_roll = (rand() % 6) + 1;
           printf("Chatbot: The result of the dice roll is: %d.\n", dice_roll);
         }
         ;

name : NAME { printf("Chatbot: Hi again, my name is Gepeto.\n");};

advice : ADVICE {
            srand(time(NULL));
            if (rand() % 2 == 0){
                printf("Chatbot: Go for it!\n");
            }else{
                printf("Chatbot: Maybe you shouldn't do it this time.\n");
            }
        }
        ;

%%

// Structure to store response data
struct ResponseData {
    char *data;
    size_t size;
};

// Callback function to write received data
size_t write_callback(void *ptr, size_t size, size_t nmemb, struct ResponseData *data) {
    size_t total_size = size * nmemb;
    data->data = realloc(data->data, data->size + total_size + 1);
    if (data->data == NULL) {
        fprintf(stderr, "Failed to allocate memory.\n");
        return 0;
    }
    memcpy(&(data->data[data->size]), ptr, total_size);
    data->size += total_size;
    data->data[data->size] = '\0';
    return total_size;
}

void get_current_weather(){
    CURL *curl;
    CURLcode res;
    struct ResponseData response_data = {NULL, 0};
    curl = curl_easy_init();

    if (curl) {
        // Set the URL
        const char *url = "https://api.open-meteo.com/v1/forecast?latitude=20.6668&longitude=-103.3918&current=temperature_2m";
        curl_easy_setopt(curl, CURLOPT_URL, url);

        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);

        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response_data);

        // Perform the request
        res = curl_easy_perform(curl);

        // Check for errors
        if (res != CURLE_OK)
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));

        char *data = response_data.data;
        char *temp = find_second_occurrence(data, "\"temperature_2m\"");
        
        printf("Chatbot: The current temperature at Zapopan,Jal. is: %s°C.\n", temp);

        // Cleanup
        curl_easy_cleanup(curl);
        free(response_data.data);
        free(temp);
    }
}

char* find_second_occurrence(const char* json_str, const char* key) {
    const char* pos = json_str;
    int key_len = strlen(key);
    int key_count = 0;
    char* value = NULL;

    while ((pos = strstr(pos, key)) != NULL) {
        key_count++;
        if (key_count == 2) {
            // Skip the key and colon
            pos += key_len;
            pos = strchr(pos, ':');
            if (pos) {
                // Skip colon and whitespace
                pos++;
                while (*pos == ' ' || *pos == '\t' || *pos == '\n' || *pos == '\r') {
                    pos++;
                }
                // Extract the value
                if (*pos == '\"') { // Value is a string
                    pos++;
                    const char* end_quote = strchr(pos, '\"');
                    if (end_quote) {
                        int value_len = end_quote - pos;
                        value = (char*)malloc(value_len + 1);
                        strncpy(value, pos, value_len);
                        value[value_len] = '\0';
                    }
                } else { // Value is not a string
                    const char* value_start = pos;
                    while (*pos != ',' && *pos != '}' && *pos != '\0') {
                        pos++;
                    }
                    int value_len = pos - value_start;
                    value = (char*)malloc(value_len + 1);
                    strncpy(value, value_start, value_len);
                    value[value_len] = '\0';
                }
                break;
            }
        } else {
            // Move to the next character after the current key occurrence
            pos++;
        }
    }

    return value;
}


int main() {
    printf("Chatbot: Hi I am Gepeto! Your personal chatbot.\n");
    printf("You can greet me, ask for the time, the weather and other things :).\n");

    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
