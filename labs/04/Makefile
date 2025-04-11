all:
	python3 code_generator.py > example.ac
	lex lexic_analyzer.l
	gcc lex.yy.c -o lexical_scan -lfl
	./lexical_scan < example.ac
