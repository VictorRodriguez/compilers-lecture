all:
	lex lab.l
	gcc lex.yy.c -o lab -ll

run:
	lex lab.l
	gcc lex.yy.c -o lab -ll
	./lab random_code.ac

clean:
	rm -rf *.c
	rm -rf lab
