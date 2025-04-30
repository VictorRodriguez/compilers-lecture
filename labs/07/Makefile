# Define the compiler and flags
CC = gcc
LEX = flex
YACC = bison
YFLAGS = -d
CFLAGS = -ll -ly -lcurl

# Define the source files and output executable
LEX_SRC = chatbot.l
YACC_SRC = chatbot.y
LEX_OUT = chatbot.c
YACC_OUT = chatbot.tab.c
YACC_HEADER = chatbot.tab.h
EXEC = chatbot

# Define the test input and output files
TEST_INPUT = in.txt
EXPECTED_OUTPUT = out.txt
ACTUAL_OUTPUT = actual_output.txt

# Default target
all: $(EXEC)

# Compile the executable
$(EXEC): $(LEX_OUT) $(YACC_OUT)
	$(CC) $(LEX_OUT) $(YACC_OUT) -o $(EXEC) $(CFLAGS)

# Generate the lex and yacc output files
$(LEX_OUT): $(LEX_SRC)
	$(LEX) $(LEX_SRC)

$(YACC_OUT): $(YACC_SRC)
	$(YACC) $(YFLAGS) $(YACC_SRC)

# Run the tests
test: $(EXEC)
	./$(EXEC) < $(TEST_INPUT) > $(ACTUAL_OUTPUT)
	diff -u $(EXPECTED_OUTPUT) $(ACTUAL_OUTPUT) || true

# Clean up the generated files
clean:
	rm -f $(LEX_OUT) $(YACC_OUT) $(YACC_HEADER) $(EXEC) $(ACTUAL_OUTPUT)

# Phony targets
.PHONY: all clean test
