all:
	yacc -d simplecalc.y
	flex simplecalc.l
	gcc -lfl lex.yy.c y.tab.c y.tab.h -o simplecalc

clean:
	rm -rf simplecalc
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch
