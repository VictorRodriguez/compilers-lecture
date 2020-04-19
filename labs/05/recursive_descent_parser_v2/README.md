# Lab 05 v3 instructions

## Objective

Design an algorithm that reads an LL(1) gramar and produces the corresponding AST.

# Requirements

* Linux machine, either a VM or a bare metal host
* GCC compiler (at least version 4.8)
* [DOT grapviz](http://www.graphviz.org) library
* git send mail server installed and configured on your Linux machine

## Instructions

Create a program in C that taking as an example the gramar in Figure 1:

* Read the gramar from an external file [gramar.conf](gramar.conf)
* Gramar will be in Backus-Naur Form (BNF) notation
* Read the token list from another file tokens.txt
* Assume that is an LL(1) gramar
* Create the abstrct syntax tree as an struct in C code
* Print the AST graph using [DOT grapviz](http://www.graphviz.org) library

Figure 1

Example of tokens.txt:

```
floatdcl id
intdcl id
id assign inum
id assign id plus fnum
print id

```

## Expected result:


The image can be generated as:
```
./sytax_parser <gramar.conf> <tokens.txt> > log
dot log -Tpng >result.png
```


```

```

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

