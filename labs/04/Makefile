LDFLAGS = -L/opt/homebrew/opt/flex/lib
CPPFLAGS = -I/opt/homebrew/opt/flex/include

# generate 
example: code_generator.py 
	python3 code_generator.py > example.ac

# compile 
gen_lex:
	lex language_ac.l
	gcc $(CPPFLAGS) $(LDFLAGS) lex.yy.c -o lexical_scan -lfl

test: example.ac
	./lexical_scan < example.ac
# run lex, then compile lex.yy.c then run lexical_scan
#
stress:
	lex language_ac.l
	gcc $(CPPFLAGS) $(LDFLAGS) lex.yy.c -o lexical_scan -lfl
	python3 code_generator.py --stress
	./lexical_scan < random_code.ac
run:
	lex language_ac.l
	gcc $(CPPFLAGS) $(LDFLAGS) lex.yy.c -o lexical_scan -lfl
	python3 code_generator.py > example.ac
	./lexical_scan < example.ac

# Limpiar archivos generados
clean:
	rm -f lex.yy.c lexical_scan example.ac
