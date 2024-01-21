CC = gcc
CFLAGS = -Wall

calculator: lex.yy.c calc.tab.c
	$(CC) $(CFLAGS) -o calculator lex.yy.c calc.tab.c -lfl

lex.yy.c: calc.l
	flex calc.l

calc.tab.c: calc.y
	bison -d calc.y

clean:
	rm -f calculator lex.yy.c calc.tab.c calc.tab.h

