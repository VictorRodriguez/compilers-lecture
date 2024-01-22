# Lab 06 v3 instructions

## Objective

Make the student create an abstract syntax tree and generate Syntax-Directed
Translation

# Requirements

* Linux machine, either a VM or a bare metal host
* GCC compiler
* git send mail server installed and configured on your Linux machine

## Instructions

Consider the grammar:

```
E ->  int | ( E ) | E + E | E - E | E * E
```

And the string

5 + (2 + 3)

Create a C code that:

* Do a top down parsing to check if a string is valid
* Consider input of 1 digit (10 +2 is not valid) to make it more simple
* Generate an abstract syntax tree and generate Syntax-Directed Translation
* Produce the output:

```assembly
	add 2,3,acum 		\\ 2 + 3 and store result in acum register
	add &acum,5,acum 	\\ acum register + 5 and store result in acum register
```
Reuse the code created in lab 04 if possible

## How could it be tested:

```

make ( compile everything )

./calculator <CODEFILE>

```

Example of CODEFILE:

```
5 + (2 - 3)
5 + (2 * (2+4))
(3+1)
```

Example of output:

```assembly
sub 2,3,acum
add &acum,5,acum

add 2,4,acum
mul &acum,2,acum
add &acum,5,acum

add 3,1,acum
```

## Please send the mail as git send mail:

```
    $ git add syntax-direct-translator.c Makefile
    $ git commit -s -m <STUDENT-ID>-homework-06
    $ git send-email -1

```
Do some tests sending the mail to your personal
account, if you get the mail, then you can be sure I
will get the mail


## Time to do the homework:

One week from the moment the mail is sent to students

## References to use:

* [SYNTAX-DIRECTED-TRANSLATION](http://pages.cs.wisc.edu/~fischer/cs536.s06/course.hold/html/NOTES/4.SYNTAX-DIRECTED-TRANSLATION.html)

