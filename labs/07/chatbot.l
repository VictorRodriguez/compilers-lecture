%{
#include "y.tab.h"
char character_name[100];  // Buffer to store character name

void extract_character_name(const char* text, const char* prefix) {
    int prefix_length = strlen(prefix);
    strncpy(character_name, text + prefix_length, sizeof(character_name) - 1);
    character_name[sizeof(character_name) - 1] = '\0';
}

%}

%%

hello           { return HELLO; }
hi              { return HELLO; }
hey             { return HELLO; }
goodbye         { return GOODBYE; }
bye             { return GOODBYE; }
time            { return TIME; }
what[' ']is[' ']the[' ']time  { return TIME; }
what[' ']time[' ']is[' ']it  { return TIME; }
tell[' ']me[' ']about[' '][a-zA-Z0-9 áéíóúÁÉÍÓÚ]+ {
                    extract_character_name(yytext, "tell me about ");
                    return CHECK_CHARACTER;
                }
who[' ']is[' '][a-zA-Z0-9]+ {
                    extract_character_name(yytext, "who is ");
                    return CHECK_CHARACTER;
                }

\n              { return 0; }  /* End of input on newline */

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}