# Lab 04 instructions

## Objective

Make the student understand the power of lex language making a C code that
performs the lexical analysis of the ac src program

# Requirements

* Linux machine, either a VM or a bare metal host
* GCC compiler (at least version 4.8)
* lex compiler
* Autotools
* git send mail server installed and configured on your Linux machine

## Instructions

Please generate a LEX code to parse the previous example of lab 03.

A valid line of code in ac could be:

```
// basic code

//float b
f b

// integer a
i a

// a = 5
a = 5

// b = a + 3.2
b = a + 3.2

//print 8.5
p b
```

Your output should be

```
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
print id
```

## Expected result:

* Code a lex_analaizer.L that fulfill the requirements
* Generate a random AC code with:

```
python3 code_generator.py > example.ac

```

* Compile your code with the makefile and execute as follows:

```
./lex_analaizer example.ac
```


## Please send the mail as PR:

```
    $ git add lex_analaizer.c
    $ git commit -s -m <STUDENT-ID>-homework-04
```
Do some tests sending the mail to your personal account, if you get the mail,
then you can be sure I will get the mail

## Good links for Hints

* [lextutorial](https://ds9a.nl/lex-yacc/cvs/lex-yacc-howto.html)
* [lex & yacc Second
Edition](https://www.amazon.com/lex-yacc-Doug-Brown/dp/1565920007)
At the end of chapter 1 there is a very similar code as the one requested in
this homework, you just need to read chapter 1 of this book :)
* [useoflexinc](https://www.quora.com/What-is-the-function-of-yylex-yyin-yyout-and-fclose-yyout-in-LEX)

## Time to do the homework:

One week from the moment the mail is sent to students

