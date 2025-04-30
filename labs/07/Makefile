all:
        yacc -d chatbot.y
        lex chatbot.l
        gcc y.tab.c lex.yy.c -o chatbot

clean:
        rm -rf chatbot
        rm -rf lex.yy.c
        rm -rf y.tab.c
        rm -rf y.tab.h
        rm -rf y.tab.h.gch
