# Lab 07 instructions

## Objective

Make the student create a CFG for the calculator previusly created using YACC

# Requirements

* Linux machine, either a VM or a bare metal host
* GCC compiler
* git send mail server installed and configured on your Linux machine
* YACC

## Instructions
Taking as imput the following code:

```
$ cat FILE

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
Reuse the code created in lab 04 to generate:

```
$ cat tokens.out

floatdcl id
intdcl id
id assign inum
id assign id plus fnum
print id
```
IMPORTANT: calculator should accept + - * / as operator


Before we reuse our code from lab 05 to:

	* Detect nonterminals that cannot be reached from a CFG’s goal symbol.
	* Detect nonterminals that cannot derive any terminal string in a CFG.

Since we already did this in HW 06 is not necessary to do it again

## How could it be tested:
```

make ( compile everything )

./lexic_analyzer <CODEFILE>

```
This will generate the tokens.out

Use then for generate the parse tree:

```
./syntax-calc tokens.out
```
And generate a CFG derivation tree in this format:

```
digraph D {

  A -> {B, C, D} -> {F}

}


IMPORTANT: Use this code as base

https://avinashsuryawanshi.files.wordpress.com/2016/10/9.pdf

It will give you a basic example of how to make the AST

```

View of this tree, put this code in:

https://dreampuf.github.io/GraphvizOnline

More info about DOT code:

https://renenyffenegger.ch/notes/tools/Graphviz/examples/index

## Please send the mail as git send mail:

```
    $ git add syntax-calc.c Makefile
    $ git commit -s -m <STUDENT-ID>-homework-07
    $ git send-email -1

```
Do some tests sending the mail to your personal
account, if you get the mail, then you can be sure I
will get the mail


## Time to do the homework:

One week from the moment the mail is sent to students

