all:
	yacc -d calc.y
	lex calc.l
	gcc -ll lex.yy.c y.tab.c y.tab.h -o calc

clean:
	rm -rf *.c
	rm -rf *.h
	rm -rf a.out
	rm -rf calc
	rm -rf *.gch
