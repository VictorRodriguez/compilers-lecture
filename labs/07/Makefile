all:
	lex chatbot.l
	bison -d -b y chatbot.y
	gcc lex.yy.c y.tab.c -o chatbot -lcurl -ljson-c
clean:
	rm -rf *.c
	rm -rf y.tab.*
	rm chatbot
