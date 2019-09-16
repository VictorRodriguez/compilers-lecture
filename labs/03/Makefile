all:
	lex -o lexic_analyzer.c parser.l
	gcc lexic_analyzer.c -lfl -o parser.out
	python3 code_generator.py > example.ac
	cat example.ac
	./parser.out example.ac
	 
