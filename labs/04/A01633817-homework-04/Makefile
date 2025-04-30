all:
	flex lex_analaizer.l
	gcc lex.yy.c -o lex_analaizer -lfl

run: all
	./lex_analaizer example.ac

clean:
	rm -f lex.yy.c lex_analaizer

