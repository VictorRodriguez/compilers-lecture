%{
#include <stdio.h>
#include <curl/curl.h>
#include <ctype.h>
#include <string.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
size_t write_callback(char *ptr, size_t size, size_t nmemb, char **activity);
char *get_random_activity();
%}

%token HELLO GOODBYE TIME BORED THANKS

%%

chatbot : greeting
       | farewell
       | query
       | bored
       | thanking
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

bored : BORED {
            printf("Chatbot: Oh, you're bored? Let me think about something interesting...\n");
            char *activity = get_random_activity();
            if (activity) {
                printf("Chatbot: Why don't you try to %s?\n", activity);
                free(activity);
            } else {
                printf("Chatbot: Sorry, I couldn't think of anything.\n");
            }
        }
      ;

thanking : THANKS { printf("Chatbot: You're welcome!\n"); }
      ;

%%

int main() {
   printf("Chatbot: Hi! You can greet me, ask for the time, or say goodbye.\n");
   while (yyparse() == 0) {
       // Loop until end of input
   }
   return 0;
}

size_t write_callback(char *ptr, size_t size, size_t nmemb, char **activity) {
    int realsize = size * nmemb;
    char *start, *end;

    start = strstr(ptr, "\"activity\":\"");
    if (start) {
        start += 12; // move pointer past "activity":""
        end = strchr(start, '"');
        if (end) {
            *end = '\0';
            *activity = strdup(start);

            (*activity)[0] = tolower((*activity)[0]); // first letter is always capitalized
        }
    }

    return realsize;
}

char *get_random_activity() {
    CURL *curl;
    CURLcode res;
    char *activity = NULL;

    curl = curl_easy_init();
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://bored-api.appbrewery.com/random");
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &activity);
        res = curl_easy_perform(curl);
        curl_easy_cleanup(curl);
    }

    return activity;
}

void yyerror(const char *s) {
   fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
