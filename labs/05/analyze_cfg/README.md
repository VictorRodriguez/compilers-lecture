# Lab 05 v1 instructions

## Objective

Make the student understand how to analyze a valid CFG

# Requirements

* Linux machine, either a VM or a bare metal host
* git send mail server installed and configured on your Linux machine

## Instructions


A grammar is reduced if each of its nonterminals and productions participates
in the derivation of some string in the grammar’s language. Nonterminals that
can be safely removed are called useless.

```
 <expr> ::= <a> | <b>

 <a> ::= a

 <b> ::= <B>b

 <c> ::= c
```

The above grammar contains two kinds of nonterminals that cannot participate in any derived string:

• With S as the start symbol, the nonterminal C cannot appear in any phrase.
• Any phrase that mentions B cannot be rewritten using the grammar’s rules to contain only terminals.

Referring to Section 4.2.1 of the book: Crafting a Compiler 2nd edition

	* Devise an algorithm to detect nonterminals that cannot be reached from a CFG’s goal symbol.
	* Devise an algorithm to detect nonterminals that cannot derive any terminal string in a CFG.

The code could be in any of the following lenguages:

* C ( recomended )
* C++
* python
* Java

```
make
./gramar_analyser <FILE>

```

## Please send the mail as git send mail:

```
    $ git add gramar_analyser.* Makefile
    $ git commit -s -m <STUDENT-ID>-homework-05
    $ git send-email -1

```
Do some tests sending the mail to your personal account, if you get the mail,
then you can be sure I will get the mail


## Time to do the homework:

One week from the moment the mail is sent to students

