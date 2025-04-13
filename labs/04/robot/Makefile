all:
	yacc -d parser.y
	lex lexer.l
	gcc y.tab.c lex.yy.c -ly -ll -o robot_compiler

clean:
	rm -rf instructions.asm
	rm -rf robot_compiler
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch