compile:
	lex -o lex.yy.c chatbot.l
	bison -o y.tab.c chatbot.y -d
	gcc -o chatbot lex.yy.c y.tab.c -lcurl  
