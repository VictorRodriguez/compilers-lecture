# Activity 3.1: Lexical Analyzer (SCANNER)

Author: Emilio Berber Maldonado A01640603

## Purpose
The objective of this activity is to develop a basic lexical analyzer (scanner) using Flex. This analyzer processes a source code file and outputs the corresponding tokens, recognizing keywords, identifiers, numbers, operators, unknown digits and cooments.

## Requirements
- Install Flex (Fast Lexical Analyzer Generator)
- Install GCC or another C compiler
- Unix-like environment or terminal (Linux, macOS, or Git Bash/MSYS2 for Windows)

## Files
- `lex_analaizer.l`: The Flex definition file containing the lexical rules
- `example.ac`: Sample input file with code to analyze
- `lex_analyzer.exe`: Compiled executable generated from the `.l` file (on Windows)
- lex.yy.c

## How to Compile and Run

1. Generate the C source from the `.l` file:
   ```bash
   flex lex_analaizer.l
   ```

2. Compile the generated `lex.yy.c` file:
   ```bash
   gcc lex.yy.c -o lex_analyzer
   ```

3. Run the analyzer with your test input:
   ```bash
   ./lex_analyzer example.ac
   ```
## Output Format
Each recognized token is printed to standard output on a separate line. Comments and unknown characters are also reported as `COMMENT` and `UNKNOWN`, respectively. Whitespace and line breaks are ignored in tokenization but respected in output formatting for clarity.

## Example

### Input: (`example.ac`)
```
a =    3
// Emilio Berber
// Mi matrícula es: A01640603
h = 123131312321312
// basic code
//float b
f b

// integer a
i a

// a = 5
a =           5

// b = a + 3.2
b = a + 3.2

// print 8.5
p 8.5
?
```

### Output:
```
id assign inum
COMMENT
COMMENT
id assign inum
COMMENT
COMMENT
floatdcl id
COMMENT
intdcl id
COMMENT
id assign inum
COMMENT
id assign id plus fnum
COMMENT
print fnum
UNKNOWN
```

## Recognized Tokens
| Token      | Description                        |
|------------|------------------------------------|
| `floatdcl` | Float declaration (`f`)            |
| `intdcl`   | Integer declaration (`i`)          |
| `print`    | Print statement (`p`)              |
| `id`       | Identifier (variable name)         |
| `assign`   | Assignment operator (`=`)          |
| `plus`     | Addition operator (`+`)            |
| `inum`     | Integer number                     |
| `fnum`     | Floating point number              |
| `COMMENT`  | Line comment (starts with `//`)    |
| `UNKNOWN`  | Any unrecognized symbol (e.g., `?`)|