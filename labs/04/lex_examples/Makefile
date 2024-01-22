all:
	lex example0.l
	gcc lex.yy.c -o example0 -ll
	lex example1.l
	gcc lex.yy.c -o example1 -ll
	lex example2.l
	gcc lex.yy.c -o example2 -ll
	lex example3.l
	gcc lex.yy.c -o example3 -ll

clean:
	rm -rf *.c
	rm -rf example0
	rm -rf example1
	rm -rf example2
	rm -rf example3
