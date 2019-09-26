all:
	yacc -d simplecalc.y
	lex simplecalc.l
	gcc y.tab.c lex.yy.c -ly -ll -o simplecalc

clean:
	rm -rf simplecalc
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch
