all:
	yacc -d calc.y
	lex calc.l
	gcc y.tab.c lex.yy.c -ly -ll -o calc

clean:
	rm -rf calc
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch
