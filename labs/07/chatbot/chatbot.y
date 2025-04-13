%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>

void yyerror(const char *s);
int yylex(void);
float getWeather();

struct string {
    char *ptr;
    size_t len;
};

float getWeather();
float extractTemperature(const char *json);
size_t writefunc(void *ptr, size_t size, size_t nmemb, struct string *s);
void init_string(struct string *s);
char* getRandomJoke();
%}

%token HELLO GOODBYE TIME NAME WEATHER HOWAREYOU JOKE
%%

chatbot : greeting
        | farewell
        | query
        | name
        | weather
        | howareyou
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
        | JOKE { printf("Chatbot: Here's a joke for you:\n%s\n", getRandomJoke()); }
       ;

name : NAME { printf("Chatbot: My name is Roberto\n"); };

weather: WEATHER { 
            float temp = getWeather();
            if (temp == -1) {
                printf("Chatbot: Sorry, I couldn't fetch the temperature.\n");
            } else {
                printf("Chatbot: The current temperature is %.2f degrees Celsius.\n", temp); 
            }
        }
        ;

howareyou: HOWAREYOU { printf("Chatbot: I'm good :D\n"); };

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, weather, joke, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
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

float extractTemperature(const char *json) {
    const char *temp_ptr = strstr(json, "\"temp\":");
    if (!temp_ptr) {
        return -1; // Error: "temp" key not found
    }

    temp_ptr += 7; // Move past the "\"temp\":" part
    return strtof(temp_ptr, NULL);
}

float getWeather() {
    CURL *curl;
    CURLcode res;
    struct string s;
    init_string(&s);

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://api.openweathermap.org/data/2.5/weather?id=4005539&appid=0a1155aae5e461936d38d6f03bdf12f9&units=metric");
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writefunc);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &s);

        res = curl_easy_perform(curl);

        if(res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
            free(s.ptr);
            return -1;
        }

        curl_easy_cleanup(curl);
    }

    curl_global_cleanup();

    float temperature = extractTemperature(s.ptr);
    free(s.ptr);

    return temperature;
}

char* getRandomJoke() {
    char* jokes[] = {
        "Why don't scientists trust atoms? Because they make up everything!",
        "Parallel lines have so much in common. It's a shame they'll never meet.",
        "I told my wife she was drawing her eyebrows too high. She looked surprised.",
        "Why did the scarecrow win an award? Because he was outstanding in his field!",
        "Why did the bicycle fall over? Because it was two-tired!",
        "What do you call fake spaghetti? An impasta!",
        "I'm reading a book on anti-gravity. It's impossible to put down!",
        "I used to play piano by ear, but now I use my hands.",
        "Why don't skeletons fight each other? They don't have the guts.",
        "What do you get when you cross a snowman and a vampire? Frostbite!",
        "I told my computer I needed a break and now it won't stop sending me vacation ads.",
        "Why did the tomato turn red? Because it saw the salad dressing!",
        "I used to be a baker, but I couldn't make enough dough.",
        "Why don't eggs tell jokes? Because they might crack up!",
        "I'm on a whiskey diet. I've lost three days already!",
        "I'm trying to organize a hide and seek competition, but it's hard to find good players.",
        "I'm terrified of elevators, so I'm going to start taking steps to avoid them.",
        "Why did the coffee file a police report? It got mugged!",
        "I told my wife she was drawing her eyebrows too high. She looked surprised.",
        "What's a vampire's favorite fruit? A blood orange!",
        "Why was the math book sad? Because it had too many problems!",
        "I used to be a baker, but I couldn't make enough dough.",
        "Why did the scarecrow win an award? Because he was outstanding in his field!",
        "What do you call fake spaghetti? An impasta!",
        "Why don't skeletons fight each other? They don't have the guts.",
        "Why don't eggs tell jokes? Because they might crack up!",
        "Why did the bicycle fall over? Because it was two-tired!",
        "Why did the tomato turn red? Because it saw the salad dressing!",
        "Why don't scientists trust atoms? Because they make up everything!",
        "Why was the math book sad? Because it had too many problems!",
        "Why did the coffee file a police report? It got mugged!",
    };

    int num_jokes = 30;

    int random_index = rand() % num_jokes;

    return jokes[random_index];
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
