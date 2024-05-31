all:
	yacc -d ambi_calculator.y
	lex ambi_calculator.l
	gcc y.tab.c lex.yy.c -ly -ll -o ambi_calculator

clean:
	rm -rf ambi_calculator
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch
