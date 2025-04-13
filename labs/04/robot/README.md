
## Ejecutar el compilador
Para ejecutar el compilador por primera vez use:
````
$ make
````

También puede ejecutar los comandos individualmente:
````
$ yacc -d parser.y
$ lex lexer.l
$ gcc y.tab.c lex.yy.c -ly -ll -o robot_compiler
````

Para probar los ejemplos puede utilizar:
````
$ ./robot_compiler < ./examples/invalid01.ac
$ ./robot_compiler < ./examples/valid02.ac
````

#### Miguel Santamaria - A01366795

