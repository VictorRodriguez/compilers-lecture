all:
	lex chatbot.l
	yacc -d chatbot.y
	gcc y.tab.c lex.yy.c -o chatbot
	./chatbot

clean:
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h