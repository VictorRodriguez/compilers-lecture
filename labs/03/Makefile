all:
	yacc -d sentence.y
	lex sentence.l
	gcc y.tab.c lex.yy.c -ly -ll -o sentence

clean:
	rm -rf sentence
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch
