# Compiler and flags
CC = gcc
CFLAGS = -Wall -I.
LDFLAGS = -lcurl

# Files
LEX_FILE = chatbot.l
YACC_FILE = chatbot.y
CJSON_FILE = cJSON.c
LEX_GEN_C = lex.yy.c
YACC_GEN_C = y.tab.c
YACC_HEADER = y.tab.h
EXECUTABLE = chatbot

# Targets and rules
all: $(EXECUTABLE)

$(EXECUTABLE): y.tab.o lex.yy.o cJSON.o
	$(CC) -o $@ $^ $(LDFLAGS)

y.tab.o: $(YACC_GEN_C)
	$(CC) $(CFLAGS) -c -o $@ $<

lex.yy.o: $(LEX_GEN_C)
	$(CC) $(CFLAGS) -c -o $@ $<

cJSON.o: $(CJSON_FILE)
	$(CC) $(CFLAGS) -c -o $@ $<

$(YACC_GEN_C) $(YACC_HEADER): $(YACC_FILE)
	yacc -d $(YACC_FILE)

$(LEX_GEN_C): $(LEX_FILE)
	flex $(LEX_FILE)

clean:
	rm -f $(EXECUTABLE) y.tab.c y.tab.h lex.yy.c *.o

.PHONY: all clean
