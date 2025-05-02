#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>
#include <json-c/json.h>

// Structure to store response data
struct string {
    char *ptr;
    size_t len;
};

// Function to initialize the string structure
void init_string(struct string *s) {
    s->len = 0;
    s->ptr = malloc(s->len + 1);
    if (s->ptr == NULL) {
        fprintf(stderr, "malloc() failed\n");
        exit(EXIT_FAILURE);
    }
    s->ptr[0] = '\0';
}

// Callback function for handling response data
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

char response[128];

const char* queryWeatherIn(char *city) {
    CURL *curl;
    CURLcode res;
    struct string s;

    init_string(&s);

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if (curl) {
        const char *api_key = "a3db4382bcc6705886e5452d5310b9ef";  // Replace with your API key
        char url[256];

        snprintf(url, sizeof(url), "http://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s&units=metric", city, api_key);

        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writefunc);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &s);

        res = curl_easy_perform(curl);
        long http_code = 0;
        curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &http_code);

        if (res != CURLE_OK) {

            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));

        } else if(http_code == 200){

            // Parse the JSON response
            struct json_object *parsed_json;
            struct json_object *main;
            struct json_object *temp, *weather_array, *weather, *weather_type;

            parsed_json = json_tokener_parse(s.ptr);
            //printf("Full JSON response:\n%s\n", json_object_to_json_string_ext(parsed_json, JSON_C_TO_STRING_PRETTY));

            json_object_object_get_ex(parsed_json, "main", &main);
            json_object_object_get_ex(main, "temp", &temp);
    

            json_object_object_get_ex(parsed_json, "weather", &weather_array);
            weather = json_object_array_get_idx(weather_array, 0);
            json_object_object_get_ex(weather, "description", &weather_type);
            
            snprintf(response, sizeof(response), "%s is currently at %.2f°C and has %s", city, json_object_get_double(temp), json_object_get_string(weather_type));

            json_object_put(parsed_json); // Free memory allocated for JSON objects
        } else {
            snprintf(response, sizeof(response), "Sorry, city '%s' couldn't be found", city);
        }

        free(s.ptr);
        curl_easy_cleanup(curl);
    }

    curl_global_cleanup();

    return response;
}