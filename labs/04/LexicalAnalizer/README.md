# Lexical Analizer
This is a simple lexical analyzer implemented using Lex. Lex is a lexical analyzer generator used to create lexical analyzers and scanners.

## Homework 
Name: Brandon Josue Magaña Mendoza  
Student_id: A01640162


## Requirements
- Lex (often available as part of the Lex & Yacc or Flex & Bison toolset)
- C compiler (e.g., GCC)

## How to Use 
1. Clone this repository to your local machine.k
2. Navigate to the project directory.
3. Compile the Lex specification to generate the lexer source code. Use the command:
    ```bash
    lex lexer.l
    ```
4. Compile the generated C code to produce an executable. Use the command:
    ```bash
    cc lex.yy.c -o lexer -ll
    ```
5. Run the executable providing input source code as an argument.
    ```bash
    ./lexer <input_file.*>
    ```
