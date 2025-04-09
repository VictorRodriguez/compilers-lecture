%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>

void yyerror(const char *s);
int yylex(void);

struct MemoryStruct {
    char *memory;
    size_t size;
};

static size_t WriteMemoryCallback(void *contents, size_t size, size_t nmemb, void *userp) {
    size_t realsize = size * nmemb;
    struct MemoryStruct *mem = (struct MemoryStruct *)userp;

    char *ptr = realloc(mem->memory, mem->size + realsize + 1);
    if(ptr == NULL) {
        printf("Not enough memory (realloc returned NULL)\n");
        return 0;
    }

    mem->memory = ptr;
    memcpy(&(mem->memory[mem->size]), contents, realsize);
    mem->size += realsize;
    mem->memory[mem->size] = 0;

    return realsize;
}

void getWeather(const char *city) {
    CURL *curl;
    CURLcode res;

    struct MemoryStruct chunk;
    chunk.memory = malloc(1);  // initial size
    chunk.size = 0;

    curl_global_init(CURL_GLOBAL_ALL);
    curl = curl_easy_init();

    if(curl) {
        char url[256];
        snprintf(url, sizeof(url), "http://wttr.in/%s?format=3", city);

        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)&chunk);
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);  // Follow redirects

        res = curl_easy_perform(curl);

        if(res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s", curl_easy_strerror(res));
        } else {
            // Print the weather data
            printf("Mr.White: Current weather in %s", chunk.memory);
        }

        // Cleanup
        curl_easy_cleanup(curl);
        free(chunk.memory);
    }

    curl_global_cleanup();
}
%}

%token HELLO GOODBYE TIME YOURNAME WEATHER COOK HOWRU

%%

chatbot : greeting
        | farewell
        | query
        | yname
        | waltuh
        | status
        ;

greeting : HELLO { printf("Mr.White: Hello! what can I do for you?\n"); }
         ;

farewell : GOODBYE { printf("Mr.White: Goodbye. Remember, I'm always watching.\n"); }
         ;

yname : YOURNAME { printf("Mr.White: My name? You know who I am. I'm the one who knocks.\n"); }
      ;

waltuh : COOK { printf("Mr.White: Jesse we need to cook!\n"); }
       ;

status : HOWRU { printf("Mr.White: How am I? Let's just say, I'm in control. Everything I've done, I've done for my family. But now, it's about more than just that. It's about legacy. It's about building an empire. So, ask yourself—how are you?\n"); }
       ;

query : TIME { 
            printf("Mr.White: It's time to get back to work. Time waits for no one.\n");
         }
       | WEATHER { 
            const char *city = "Albuquerque";  
            getWeather(city);
         }
       ;

%%

int main() {
    printf("Mr.White: Good evening. My name is Walter White. Some of you might know me as Heisenberg. I was once a high school chemistry teacher in Albuquerque, New Mexico. But circumstances forced me to take drastic measures to ensure my family's future.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Mr.White: I don't understand. But I'll figure it out. I always do.\n");
}
