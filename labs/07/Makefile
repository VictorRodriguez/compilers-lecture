compile:
	lex chatbot.l
	yacc -d chatbot.y
	cc lex.yy.c y.tab.c -o chatbot -lfl -ly -lcurl
