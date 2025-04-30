all:
	lex lex.l
	gcc lex.yy.c -o lex -ll
	python3 code_generator.py > example.ac
	./lex example.ac


clean:
	rm -rf *.c
	rm -rf lex