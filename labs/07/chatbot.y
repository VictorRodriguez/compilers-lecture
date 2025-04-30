%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <curl/curl.h>

void yyerror(const char *s);
int yylex(void);

size_t WriteCallback(void *contents, size_t size, size_t nmemb, void *userp) {
    size_t total_size = size * nmemb;
    strncat(userp, contents, total_size);
    return total_size;
}

void get_weather(char *buffer, size_t buffer_size, const char *city) {
    CURL *curl;
    CURLcode res;
    char url[256];
    char *encoded_city;

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();
    if (curl) {
        if (city) {
            encoded_city = curl_easy_escape(curl, city, 0);
            snprintf(url, sizeof(url), "https://wttr.in/%s?format=3", encoded_city);
            curl_free(encoded_city);
        } else {
            snprintf(url, sizeof(url), "https://wttr.in/?format=3");
        }

        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, buffer);

        res = curl_easy_perform(curl);
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        }

        curl_easy_cleanup(curl);
    }
    curl_global_cleanup();
}

void print_weather(const char *city) {
    char buffer[10000] = {0};
    get_weather(buffer, sizeof(buffer), city);

    if (strlen(buffer) > 0) {
        printf("Chatbot: %s", buffer);
    } else {
        printf("Chatbot: Sorry, I couldn't fetch the weather information.\n");
    }
}

void perform_calculation(char *expr) {
    char op;
    int num1, num2, result;
    sscanf(expr, "%d %c %d", &num1, &op, &num2);

    switch (op) {
        case '+':
            result = num1 + num2;
            break;
        case '-':
            result = num1 - num2;
            break;
        case '*':
            result = num1 * num2;
            break;
        case '/':
            if (num2 != 0)
                result = num1 / num2;
            else {
                printf("Chatbot: Cannot divide by zero.\n");
                return;
            }
            break;
        default:
            printf("Chatbot: Invalid operation.\n");
            return;
    }
    printf("Chatbot: The result of %d %c %d is %d.\n", num1, op, num2, result);
}


%}

%union {
    char *str;
}

%token HELLO GOODBYE TIME NAME WEATHER WEATHER_CITY ADD SUB MUL DIV
%type <str> WEATHER_CITY ADD SUB MUL DIV


%%

chatbot : greeting
        | farewell
        | query
        | name_query
        | weather_query
        | weather_city_query
        | calculation
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
name_query : NAME { printf("Chatbot: My name is Chatbot. My creator wasn't very original!\n"); }
           ;

weather_query : WEATHER { 
                   print_weather(NULL);
                 }
              ;

weather_city_query :  WEATHER_CITY { 
                        print_weather($1); free($1);
                      }
                   ;

calculation : ADD { perform_calculation($1); free($1); }
           | SUB { perform_calculation($1); free($1); }
           | MUL { perform_calculation($1); free($1); }
           | DIV { perform_calculation($1); free($1); }
           ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, inquire about the weather, I can help you with simple math expressions, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}