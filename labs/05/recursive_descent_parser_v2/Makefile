all:
	gcc syntax_parser.c -o syntax_parser
	./syntax_parser grammar.conf tokens.txt > log
	dot log -Tpng >result.png

clean:
	rm -rf syntax_parser
	rm -rf result.png
