all:
    yacc -d sentence.y
    lex sentence.l
    gcc y.tab.c lex.yy.c -ly -ll -l sentence
