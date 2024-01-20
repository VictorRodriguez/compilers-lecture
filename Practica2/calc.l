%{
#include <stdio.h>

enum {
      LOOKUP =0, /* default - looking rather than defining. */
      FLOATING,
      INTEGER
};

int state;

int add_word(int type, char *word);
int lookup_word(char *word);

%}

%%
[0123456789]+           printf("NUMBER\n");
[a-zA-Z][a-zA-Z0-9]*    printf("WORD\n");
%%

\n    { state = LOOKUP; }   /* end of line, return to default state */
      /* whenever a line starts with a reserved part of speech name */
      /* start defining words of that type */
^f { state = FLOATING; }
^i  { state = INTEGER; }

int main(int argc, char **argv) {
    FILE    *fd;

    if (argc == 2)
    {
        if (!(fd = fopen(argv[1], "r")))
        {
            perror("Error: ");
            return (-1);
        }
        yyset_in(fd);
        yylex();
        fclose(fd);
    }
    else
        printf("Usage: a.out filename\n");
    return (0);
}
