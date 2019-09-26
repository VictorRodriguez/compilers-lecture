# Lab 04 instructions

## Objective

Make the student understand the power of lex and yacc languages making a basic
calculator.

# Requirements

* Linux machine, either a VM or a bare metal host
* GCC compiler (at least version 4.8)
* lex compiler
* yacc compiler
* git send mail server installed and configured on your Linux machine

## Instructions

Please generate an application with lex and yacc that the next input from a file as valid

```
// comment

i a
i b
a = 5
b = a + 3
p b
```

Your output should be

```
8
```

Your calculator should accept:

* + - / and * 
* Catch divition by zero as an error before executing
* Only accept integers
* Only print valid variables

Your calculator only will be focus on the lexical and syntax analysis, do not
care about the semantic, i.e.:

* You dont need to catch if a variable is declared after the use of it


## Expected result:

* Code a calc.l and a calc.y  that fulfill the requirements
* Code a Makefile for this code

## Please send the mail as git send mail:

```
    $ git add lex_analaizer.c
    $ git commit -s -m <STUDENT-ID>-homework-04
    $ git send-email -1

```
Do some tests sending the mail to your personal account, if you get the mail,
then you can be sure I will get the mail

## Time to do the homework:

One week from the moment the mail is sent to students

