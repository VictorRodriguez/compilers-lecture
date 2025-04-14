%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>  // Include the string.h header

void yyerror(const char *s);
int yylex(void);

void get_temperature();  // Declare the function to get temperature
void recommend_song();   // Declare the function to recommend a song
%}

%token HELLO GOODBYE TIME NAME TEMPERATURE SONG

%%

chatbot : greeting
        | farewell
        | query
        | name
        | temperature
        | song
        ;

greeting : HELLO { printf("Siri: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Siri: Goodbye! Have a great day!\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Siri: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

name : NAME { printf("Siri: My name is Siri!\n"); }
         ;

temperature : TEMPERATURE { get_temperature(); }
            ;

song : SONG { recommend_song(); }
            ;

%%

int main() {
    printf("Siri: Hi! You can greet me, ask for the time, ask for the temperature, ask for a song recommendation, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Siri: I didn't understand that.\n");
}

void get_temperature() {
    // Use wttr.in to fetch the current temperature for San Francisco
    char command[] = "curl -s 'http://wttr.in/sanfrancisco?format=%t'";

    FILE *fp = popen(command, "r");
    if (fp == NULL) {
        printf("Siri: Failed to get temperature.\n");
        return;
    }

    char result[256];
    if (fgets(result, sizeof(result), fp) != NULL) {
        printf("Siri: The current temperature in San Francisco USA is %s\n", result);
    } else {
        printf("Siri: Failed to get temperature.\n");
    }

    pclose(fp);
}

void recommend_song() {
    // Use curl to fetch the XML response from ChartLyrics API and pipe it directly to xmllint
    char command[] = "curl -s \"http://api.chartlyrics.com/apiv1.asmx/SearchLyricText?lyricText=love\" | xmllint --xpath 'string(//*[local-name()=\"Song\"][1])' -";

    FILE *fp = popen(command, "r");
    if (fp == NULL) {
        printf("Siri: Failed to get song recommendation.\n");
        return;
    }

    char result[256];
    if (fgets(result, sizeof(result), fp) != NULL) {
        // Remove any trailing newline character from the result
        result[strcspn(result, "\n")] = 0;
        printf("Siri: I recommend you listen to '%s'.\n", result);
    } else {
        printf("Siri: Failed to get song recommendation.\n");
    }

    pclose(fp);
}