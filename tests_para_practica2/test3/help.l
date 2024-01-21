%{
/*
 * Word recognizer with a symbol table.
 */

enum {
      LOOKUP =0, /* default - looking rather than defining. */
      INTEGER,
      FLOATING
};

int state;

int add_word(int type, char *word);
int lookup_word(char *word);
%}

%%
\n    { state = LOOKUP; }   /* end of line, return to default state */

      /* whenever a line starts with a reserved part of speech name */
      /* start defining words of that type */
^i { state = INTEGER;}
^f  { state = FLOATING; }


[a-zA-Z]+ {
                /* a normal word, define it or look it up */
           if(state != LOOKUP) {
                /* define the current word */
                add_word(state, yytext);
              } else {
                 switch(lookup_word(yytext)) {
                 case INTEGER: printf("inum"); break;
                 case FLOATING: printf("fnum"); break;
                 default:
                         printf("%s: don't recognize\n", yytext);
                         break;
                 }
          }
         }

.    /* ignore anything else */ ;

%%

int main()
{
      yylex();
}

/* define a linked list of words and types */
struct word {
      char *word_name;
      int word_type;
      struct word *next;
};

struct word *word_list; /* first element in word list */

extern void *malloc() ;

int add_word(int type, char *word)
{
      struct word *wp;

      if(lookup_word(word) != LOOKUP) {
            printf("!!! warning: word %s already defined \n", word);
            return 0;
      }

      /* word not there, allocate a new entry and link it on the list */

      wp = (struct word *) malloc(sizeof(struct word));

      wp->next = word_list;

      /* have to copy the word itself as well */

      wp->word_name = (char *) malloc(strlen(word)+1);
      strcpy(wp->word_name, word);
      wp->word_type = type;
      word_list = wp;
      return 1;  /* it worked */
}

int lookup_word(char *word)
{
      struct word *wp = word_list;

      /* search down the list looking for the word */
      for(; wp; wp = wp->next) {
      if(strcmp(wp->word_name, word) == 0)
            return wp->word_type;
      }

      return LOOKUP;       /* not found */
}
