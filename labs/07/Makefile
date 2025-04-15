all: 
	lex chatbot.l
	yacc -d chatbot.y
	gcc lex.yy.c y.tab.c -o chatbot