all:
	lex -o lex_analaizer.c lex_analaizer.l
	gcc lex_analaizer.c -o lex_analaizer -ll
	./lex_analaizer example.ac

clean:
	rm -rf *.c
	rm -rf lex_analaizer
