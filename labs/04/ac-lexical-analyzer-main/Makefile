# Makefile for the 'ac' lexical analyzer

CC=gcc
LEX=lex
LEXFLAGS=
OUT=lex_analaizer

all: $(OUT)

$(OUT): lex_analaizer.l
	$(LEX) lex_analaizer.l
	$(CC) lex.yy.c -o $(OUT)

run: $(OUT)
	@python code_generator.py > example.ac
	@echo '=== INPUT (example.ac) ==='
	@cat example.ac
	@echo '\n=== OUTPUT (Tokens) ==='
	@./$(OUT) example.ac

clean:
	rm -f lex.yy.c $(OUT) example.ac

testcase:
	@echo '=== INPUT (test_case.ac) ==='
	@cat test_case.ac
	@echo '\n=== OUTPUT (Tokens) ==='
	@./lex_analaizer test_case.ac
