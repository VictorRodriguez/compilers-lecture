all:
	yacc -d lab3.y
	lex lab3.l
	gcc y.tab.c lex.yy.c -ly -ll -o analyzer

clean:
	rm -rf analyzer
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch
