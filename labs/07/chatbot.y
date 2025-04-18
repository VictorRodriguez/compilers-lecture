%{
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

void get_weather();
%}

%token HELLO GOODBYE TIME NAME WEATHER MOOD

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
       | NAME { printf("Chatbot: My name is Aiden.\n"); }
       | WEATHER { get_weather(); }
       | MOOD {
            printf("Chatbot: I'm just a program, but let's pretend I'm feeling great today! How about you?\n");
         }
       ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, my name, the weather, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}

void get_weather() {
    char command[512];
    snprintf(command, sizeof(command), 
             "curl -s 'https://api.open-meteo.com/v1/forecast?latitude=20.6597&longitude=-103.3496&current_weather=true' | "
             "jq -r '.current_weather | \"Chatbot: The current weather in Guadalajara is \\(.weathercode) with a temperature of \\(.temperature)°C.\"'");

    FILE *fp = popen(command, "r");
    if (fp == NULL) {
        printf("Chatbot: Failed to retrieve weather information.\n");
        return;
    }

    char result[512];
    if (fgets(result, sizeof(result)-1, fp) != NULL) {
        // Map weather codes to human-readable descriptions
        char weather_description[50];
        int weather_code;
        float temperature;

        sscanf(result, "Chatbot: The current weather in Guadalajara is %d with a temperature of %f°C.", &weather_code, &temperature);

        switch(weather_code) {
            case 0: strcpy(weather_description, "Clear sky"); break;
            case 1:
            case 2:
            case 3: strcpy(weather_description, "Mainly clear, partly cloudy, and overcast"); break;
            case 45:
            case 48: strcpy(weather_description, "Fog and depositing rime fog"); break;
            case 51:
            case 53:
            case 55: strcpy(weather_description, "Drizzle: Light, moderate, and dense intensity"); break;
            case 56:
            case 57: strcpy(weather_description, "Freezing Drizzle: Light and dense intensity"); break;
            case 61:
            case 63:
            case 65: strcpy(weather_description, "Rain: Slight, moderate and heavy intensity"); break;
            case 66:
            case 67: strcpy(weather_description, "Freezing Rain: Light and heavy intensity"); break;
            case 71:
            case 73:
            case 75: strcpy(weather_description, "Snow fall: Slight, moderate, and heavy intensity"); break;
            case 77: strcpy(weather_description, "Snow grains"); break;
            case 80:
            case 81:
            case 82: strcpy(weather_description, "Rain showers: Slight, moderate, and violent"); break;
            case 85:
            case 86: strcpy(weather_description, "Snow showers slight and heavy"); break;
            case 95: strcpy(weather_description, "Thunderstorm: Slight or moderate"); break;
            case 96:
            case 99: strcpy(weather_description, "Thunderstorm with slight and heavy hail"); break;
            default: strcpy(weather_description, "Unknown weather condition"); break;
        }

        printf("Chatbot: The current weather in Guadalajara is %s with a temperature of %.2f°C.\n", weather_description, temperature);
    } else {
        printf("Chatbot: Failed to parse weather information.\n");
    }

    pclose(fp);
}
