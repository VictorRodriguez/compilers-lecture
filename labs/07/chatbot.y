%{
#include <stdio.h>
#include <time.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
void get_weather();
%}

%token HELLO GOODBYE TIME NAME WEATHER

%%

chatbot : greeting
        | farewell
        | query
        | name
        | weather
        ;

greeting : HELLO { printf("Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Goodbye! Have a great day!\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;
name : NAME { printf("I currently don't have a name, but you can call me: Terrible Bot Attempt that Alyx tried to make! If that's too long then just Alyx's bot!\n"); }
     ;

weather : WEATHER { get_weather(); }
        ;

%%

int main() {
    printf("Chatbot: Hello human! You can greet me, ask for the time, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Oh sorry, i didn't catch that.\n");
}

void get_weather() {
    char *api_key = "5de3c1410efd4a1db75233550243105"; //API key requested as trial, it will die by 14/jun/2024
    char *location = "Zapopan";
    char command[512];
    snprintf(command, sizeof(command), "curl -s \"http://api.weatherapi.com/v1/current.json?key=%s&q=%s&aqi=no\"", api_key, location);

    FILE *fp = popen(command, "r");

    if (fp == NULL) {
        printf("Ay mijo, something failed while retrieving data from the API\n");
        return;
    }

    char response[2048];
    size_t response_len = fread(response, 1, sizeof(response) - 1, fp);
    response[response_len] = '\0';
    pclose(fp);

    
    char *temp_ptr = strstr(response, "\"temp_c\":");
    if (temp_ptr != NULL) {
        float temp;
        sscanf(temp_ptr, "\"temp_c\":%f", &temp);
        printf("Current temperature in Guadalajara is %.1f°C.\n", temp);
    } else {
        printf("Ay mijo, there's something wrong retrieving that data, why don't you go outside and see?\n");
    }
}