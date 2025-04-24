all:
	lex chatbot.l
	yacc -d chatbot.y
	gcc y.tab.c lex.yy.c -ly -ll -o chatbot

clean:
	rm -rf chatbot
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch
