LEX = flex
CC = gcc
OUTPUT = lex_analyzer

all: $(OUTPUT)

$(OUTPUT): lex_analyzer.l
	$(LEX) lex_analyzer.l
	$(CC) lex.yy.c -o $(OUTPUT)

clean:
	rm -f lex.yy.c $(OUTPUT)
