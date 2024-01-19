all:
	lex example0.l
	gcc lex.yy.c -o example0 -lfl
	lex example1.l
	gcc lex.yy.c -o example1 -lfl
	lex example2.l
	gcc lex.yy.c -o example2 -lfl
	lex example3.l
	gcc lex.yy.c -o example3 -lfl

clean:
	rm -rf *.c
	rm -rf example0
	rm -rf example1
	rm -rf example2
	rm -rf example3
