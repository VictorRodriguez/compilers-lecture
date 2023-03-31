#include <stdio.h>

#define MAX_LINE_LENGTH 1024

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Error: Could not open file '%s'\n", argv[1]);
        return 1;
    }

    char line[MAX_LINE_LENGTH];
    int line_number = 1;
    int parentheses = 0;
    int brackets = 0;
    int braces = 0;
    int single_quotes = 0;
    int double_quotes = 0;
    int in_comment = 0;

    while (fgets(line, MAX_LINE_LENGTH, file) != NULL) {
        int len = 0;
        while (line[len] != '\0' && line[len] != '\n') {
            len++;
        }
        for (int i = 0; i < len; i++) {
            if (line[i] == '(') {
                parentheses++;
            } else if (line[i] == ')') {
                parentheses--;
            } else if (line[i] == '[') {
                brackets++;
            } else if (line[i] == ']') {
                brackets--;
            } else if (line[i] == '{') {
                braces++;
            } else if (line[i] == '}') {
                braces--;
            } else if (line[i] == '\'') {
                if (single_quotes) {
                    single_quotes = 0;
                } else {
                    single_quotes = 1;
                }
            } else if (line[i] == '\"') {
                if (double_quotes) {
                    double_quotes = 0;
                } else {
                    double_quotes = 1;
                }
            } else if (line[i] == '/' && i < len - 1 && line[i+1] == '*') {
                in_comment = 1;
                i++;
            } else if (line[i] == '*' && i < len - 1 && line[i+1] == '/') {
                in_comment = 0;
                i++;
            }
        }
        line_number++;
    }

    if (parentheses != 0) {
        printf("There is a missing ( \n");
    }

    if (brackets != 0) {
        printf("There is a missing [ \n");
    }

    if (braces != 0) {
        printf("There is a missing { \n");
    }

    if (single_quotes != 0) {
        printf("There is a missing ' \n");
    }

    if (double_quotes != 0) {
        printf("There is a missing double quotes \n");
    }

    if (in_comment != 0) {
        printf("There is are a missing / \n");
    }
    else{
	printf("There are no errors");
    }
    fclose(file);
    return 0;
}
