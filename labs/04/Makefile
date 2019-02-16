all:
	lex example1.l
	gcc lex.yy.c -o example1 -ll
	lex example2.l
	gcc lex.yy.c -o example2 -ll


clean:
	rm -rf *.c
	rm -rf example1
	rm -rf example2
