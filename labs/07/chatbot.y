%{
#include <stdio.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include <sqlite3.h>

void yyerror(const char *s);
int yylex(void);

sqlite3 *db;

void get_recommendation(const char *type);
void sing_song();
%}

%token HELLO GOODBYE TIME NAME WEATHER JOKE NUMBER ARTISTREC ALBUMREC SONGREC SING THANKS

%%

chatbot : greeting
        | farewell
        | query
        | name
        | weather
        | joke
        | operation
        | recommendations
        | sing
        | thanks
        ;

greeting : HELLO { printf("Lea: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Lea: Goodbye! Have a great day!\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Lea: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

name : NAME { printf("Lea: My name is Lea\n");}

weather: WEATHER {
    system("curl -s 'wttr.in?0'");
    printf("\n");
    }

joke: JOKE {
    system("curl -s 'https://v2.jokeapi.dev/joke/Any?blacklistFlags=nsfw,religious,political,racist,sexist,explicit&format=txt&type=single'");
    printf("\n");
}

operation:
    expression   { printf("Lea: the result is = %d\n", $1); }
    ;

expression:
    expression '+' term   { $$ = $1 + $3; }
    | expression '-' term { $$ = $1 - $3; }
    | term                { $$ = $1; }
    ;

term:
    term '*' factor { $$ = $1 * $3; }
    | term '/' factor { $$ = $1 / $3; }
    | factor          { $$ = $1; }
    ;

factor:
    '(' expression ')' { $$ = $2; }
    | NUMBER { $$ = $1; }
    ;

recommendations: 
    ARTISTREC {get_recommendation("Artists");}
    | SONGREC {get_recommendation("Songs");}
    | ALBUMREC{get_recommendation("Albums");}
    ;

sing: SING {
    sing_song();
}

thanks: THANKS {
    const char* phrases[] = {
        "You're welcome",
        "No problem",
        "Anytime",
        "Happy to help",
    };
    
    int num_phrases = sizeof(phrases) / sizeof(phrases[0]);
    int random_index = rand() % num_phrases;
    const char* random_phrase = phrases[random_index];
    printf("Lea: %s\n", random_phrase);
}
%%

int main() {
    if (sqlite3_open("chatbot.db", &db)) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        return 1;
    }

    printf("\n"
        "  .---.       .-''-.     ____                .--.  ____     __   ____        _______    _______   .--.     \n"
        "  | ,_|     .'_ _   \\  .'  __ `.            / ,-'  \\   \\   /  /.'  __ `.    /   __  \\  \\  ____  \\ `-. \\    \n"
        ",-./  )    / ( ` )   '/   '  \\  \\          /_/      \\  _. /  '/   '  \\  \\  | ,_/  \\__) | |    \\ |    \\_\\   \n"
        "\\  '_ '`) . (_ o _)  ||___|  /  |         _( )_      _( )_ .' |___|  /  |,-./  )       | |____/ /   _( )_  \n"
        " > (_)  ) |  (_,_)___|   _.-`   |        (_ o _) ___(_ o _)'     _.-`   |\\  '_ '`)     |   _ _ '.  (_ o _) \n"
        "(  .  .-' '  \\   .---..'   _    |         (_,_) |   |(_,_)'   .'   _    | > (_)  )  __ |  ( ' )  \\  (_,_)  \n"
        " `-'`-'|___\\  `-'    /|  _( )_  |          \\ \\  |   `-'  /    |  _( )_  |(  .  .-'_/  )| (_{;}_) |   / /   \n"
        "  |        \\\\       / \\ (_ o _) /           \\ `-\\.      /     \\ (_ o _) / `-'`-'     / |  (_,_)  /.-' /    \n"
        "  `--------` `'-..-'   '.(_,_).'             `--' `-..-'       '.(_,_).'    `._____.'  /_______.' `--'     \n"
        "                                                                                                           \n");
    
    printf("✿==============================Lea: Hi! Here are some things you can do:=================================✿\n");
    printf("||        ･ﾟ✿ Greet me ✿･ﾟ              ･ﾟ✿ Ask for the time ✿･ﾟ         ･ﾟ✿ Check the weather ✿･ﾟ      ||\n");
    printf("|| ･ﾟ✿ Ask my name (hint: it's Lea) ✿･ﾟ   ･ﾟ✿ Hear a joke ✿･ﾟ    ･ﾟ✿ Do a math operation (+,-,*,/()) ✿･ﾟ||\n");
    printf("||   ･ﾟ✿ Get music recommendations ✿･ﾟ   ･ﾟ✿ Ask me to sing ✿･ﾟ             ･ﾟ✿ Say goodbye ✿･ﾟ         ||\n");
    printf("✿================================For more info, see the README.md file.==================================✿\n");

    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Lea: I didn't understand that.\n");
}

#include <stdio.h>
#include <stdlib.h>
#include <sqlite3.h>
#include <time.h>

void get_recommendation(const char *type) {
    const char* phrases[] = {
        "I recommend",
        "You might enjoy",
        "Consider giving a listen to",
        "Here's a suggestion:",
        "You could give a try to",
        "I think you'd like",
    };
    
    int num_phrases = sizeof(phrases) / sizeof(phrases[0]);
    srand(time(NULL));  // Initialize random number generator
    int random_index = rand() % num_phrases;
    const char* random_phrase = phrases[random_index];

    sqlite3_stmt *stmt;
    const char *sql;

    if (strcmp(type, "Songs") == 0) {
        sql = "SELECT Songs.name, Artists.name FROM Songs JOIN Artists ON Songs.artist_id = Artists.id ORDER BY RANDOM() LIMIT 1";
    } else if (strcmp(type, "Albums") == 0) {
        sql = "SELECT Albums.name, Artists.name FROM Albums JOIN Artists ON Albums.artist_id = Artists.id ORDER BY RANDOM() LIMIT 1";
    } else if (strcmp(type, "Artists") == 0) {
        sql = "SELECT name FROM Artists ORDER BY RANDOM() LIMIT 1";
    } else {
        fprintf(stderr, "Lea: Sorry, I don't know this kind of recommendation (%s).\n", type);
        return;
    }

    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) != SQLITE_OK) {
        fprintf(stderr, "Failed to prepare statement: %s\n", sqlite3_errmsg(db));
        return;
    }

    int ret_code = sqlite3_step(stmt);
    if (ret_code == SQLITE_ROW) {
        if (strcmp(type, "Artists") == 0) {
            const char *artist_name = (const char *)sqlite3_column_text(stmt, 0);
            printf("Lea: %s %s.\n", random_phrase, artist_name);
        } else {
            const char *retrieved_name = (const char *)sqlite3_column_text(stmt, 0);
            const char *artist_name = (const char *)sqlite3_column_text(stmt, 1);
            printf("Lea: %s %s by %s.\n", random_phrase, retrieved_name, artist_name);
        }
    } else {
        fprintf(stderr, "No results found.\n");
    }

    sqlite3_finalize(stmt);
}

void sing_song() {
    sqlite3_stmt *stmt;
    const char *sql = "SELECT short_lyrics FROM songs ORDER BY RANDOM() LIMIT 1";

    // Prepare the SQL statement
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) != SQLITE_OK) {
        printf("Lea: Sorry! Something went wrong. Please try again later.\n");
        return;
    }

    // Execute the SQL statement and check the result
    int ret_code = sqlite3_step(stmt);
    if (ret_code == SQLITE_ROW) {
        // Retrieve the name and age from the result row
        const char *retrieved_song = (const char *)sqlite3_column_text(stmt, 0);
        printf("Lea: ♫⋆｡♪ ₊˚♬ ﾟ. %s\n", retrieved_song);
    } 

    sqlite3_finalize(stmt);
}