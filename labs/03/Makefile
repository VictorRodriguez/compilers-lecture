all: lexical_scan

lexical_scan: lex.yy.c
        gcc lex.yy.c -o lexical_scan -lfl

lex.yy.c: lex_analyzer.l
        flex lex_analyzer.l

clean:
        rm -f lex.yy.c lexical_scan
