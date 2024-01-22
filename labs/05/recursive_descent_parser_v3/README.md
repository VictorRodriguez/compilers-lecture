# Lab 05 v3 instructions

## Objective

Design an RDP (recursive-descent-parser) for the next basic grammar:

```
S -> aBc
B -> bc | b
```

It should check an input string and generate the Syntax Tree using [DOT
grapviz](http://www.graphviz.org) library.

# Requirements

* Linux machine, either a VM or a bare metal host
* GCC compiler (at least version 4.8)
* [DOT grapviz](http://www.graphviz.org) library installed
* git send mail server installed and configured on your Linux machine

## Instructions

Create a program in C that taking as an example the grammar:

```
S -> aBc
B -> bc | b
```

* Read the token list from another file tokens.txt
* Create the abstrct syntax tree as an struct in C code
* Print the AST graph using [DOT grapviz](http://www.graphviz.org) library

Example of tokens:

```
abbbbbc
abbbb
abc
abcbcbcc
ac
```

## Expected result:

Your sytax tree should:

* Detect if each list of tokens has a sytanx error
* If it does not have a syntax error, print the AST graph using [DOT
grapviz](http://www.graphviz.org) library
* Test the output in: [webgraphviz](http://www.webgraphviz.com/)



## Please send the mail as git send mail:

```
    $ git add syntax_analaizer.c
    $ git commit -s -m <STUDENT-ID>-homework-04
    $ git send-email -1

```
Do some tests sending the mail to your personal account, if you get the mail,
then you can be sure I will get the mail

## Time to do the homework:

One week from the moment the mail is sent to students

