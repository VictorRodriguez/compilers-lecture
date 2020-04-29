# Lab 06 v2 instructions

## Objective

Design an RDP (recursive-descent-parser) for the next basic grammar:

```
S -> aBc
B -> bc | b
```

# Requirements

* Linux machine, either a VM or a bare metal host
* GCC compiler (at least version 4.8)
* YACC or BISON
* git send mail server installed and configured on your Linux machine

## Instructions

Create a program in YACC that taking as an example the grammar:

```
S -> aBc
B -> bc | b
```

* Read the token list from another file tokens.txt
* Print which ones are valid strings and which ones not

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


## Please send the mail as git send mail:

```
    $ git add syntax_analaizer.c
    $ git commit -s -m <STUDENT-ID>-homework-06
    $ git send-email -1

```
Do some tests sending the mail to your personal account, if you get the mail,
then you can be sure I will get the mail

## Time to do the homework:

One week from the moment the mail is sent to students

