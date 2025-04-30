LDFLAGS="-L/opt/homebrew/opt/flex/lib"
CPPFLAGS="-I/opt/homebrew/opt/flex/include"

python:
	rm -f example.ac
	python3 code_generator.py > example.ac

stress:
	python3 code_generator.py --stress
	lex lexic_analyzer.l
	gcc  $(CPPFLAGS) $(LDFLAGS) lex.yy.c -o lexical_scan -lfl
	./lexical_scan < random_code.ac

run:
	lex lexic_analyzer.l
	gcc  $(CPPFLAGS) $(LDFLAGS) lex.yy.c -o lexical_scan -lfl
	./lexical_scan < example.ac

clean:
	rm -f lex.yy.c lexical_scan
