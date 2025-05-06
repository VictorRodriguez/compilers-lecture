%{
#include <stdio.h>
#include <time.h>
#include <string.h>
#include "cJSON.h"
#include <ctype.h>

void yyerror(const char *s);
int yylex(void);
void get_player(const char *player_name);

%}

%union{
    char* str;
}

%token HELLO GOODBYE TIME HOWAREYOU NAME 
%token <str> PLAYER

%%

chatbot : greeting
        | farewell
        | query
        | howareu
        | name
        | player
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); };

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); };

query : TIME {
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         };

howareu : HOWAREYOU { printf("Chatbot: I'm fine, thank you! How about you?\n"); };

name: NAME { printf("Chatbot: I don't have a name, I guess you can call me Chatbot.\n"); };

player : PLAYER { 
    char player_name[256];
    strcpy(player_name, $1);
    free($1);
    int capitalize_next = 1;
    for (char *p = player_name; *p; p++) {
        if (capitalize_next && isalpha(*p)) {
            *p = toupper((unsigned char)*p);
            capitalize_next = 0;
        } else if (*p == ' ') {
            *p = '_';
            capitalize_next = 1;
        }
    }
    get_player(player_name);
};

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask for my name, put a soccer player's name, or say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}

void get_player(const char *player_name) {
    char request[512];
    snprintf(request, sizeof(request), "powershell.exe -Command \"(Invoke-WebRequest 'https://www.thesportsdb.com/api/v1/json/3/searchplayers.php?p=%s').Content\"", player_name);

    FILE *filepath = popen(request, "r");
    if (!filepath) {
        printf("Chatbot: Failed to execute the request.\n");
        return;
    }

    char *buffer = malloc(204800);
    if (!buffer) {
        fprintf(stderr, "Chatbot: Memory allocation error.\n");
        pclose(filepath);
        return;
    }

    size_t total_read = 0;
    char temp_buffer[102400];

    while (fgets(temp_buffer, sizeof(temp_buffer), filepath) != NULL) {
        size_t temp_len = strlen(temp_buffer);
        if (total_read + temp_len >= 307200 ) {
            printf("Chatbot: I know way too much about that player, but I can't tell you because of memory constraints.\n");
            free(buffer);
            pclose(filepath);
            return;
        }
        strcpy(buffer + total_read, temp_buffer);
        total_read += temp_len;
    }

    pclose(filepath);

    cJSON *root = cJSON_Parse(buffer);
    if (root == NULL) {
        printf("Chatbot: I know way too much about that player, but I can't tell you because of memory constraints.\n");
        free(buffer);
        return;
    }

    cJSON *player_array = cJSON_GetObjectItemCaseSensitive(root, "player");
    if (!cJSON_IsArray(player_array)) {
        printf("Chatbot: I don't know about that player.\n");
        cJSON_Delete(root);
        free(buffer);
        return;
    }

    cJSON *player_object = cJSON_GetArrayItem(player_array, 0);
    if (!player_object) {
        printf("Chatbot: I don't know about that player.\n");
        cJSON_Delete(root);
        free(buffer);
        return;
    }

    cJSON *description = cJSON_GetObjectItemCaseSensitive(player_object, "strDescriptionEN");
    if (!description || !cJSON_IsString(description)) {
        printf("Chatbot: I don't know about that player.\n");
        cJSON_Delete(root);
        free(buffer);
        return;
    }

    char *desc_str = cJSON_GetStringValue(description);
    printf("Chatbot: %s\n", desc_str);
    cJSON_Delete(root);
    free(buffer);
}
