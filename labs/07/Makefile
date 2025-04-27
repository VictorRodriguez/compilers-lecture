all:
	lex chatbot.l
	yacc -d chatbot.y
	cc lex.yy.c y.tab.c -o chatbot -ll

clean:
	rm y.tab.*
	rm lex.yy.c