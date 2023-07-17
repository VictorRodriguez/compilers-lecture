all:
	yacc -d parser.y
	lex lexer.l
	gcc y.tab.c lex.yy.c -ly -ll -o compiler

clean:
	rm -rf compiler
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch