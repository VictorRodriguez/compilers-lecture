# Lab 06 instructions

## Objective

Make the student create a CFG for the calculator previusly created

# Requirements

* Linux machine, either a VM or a bare metal host
* GCC compiler
* git send mail server installed and configured on your Linux machine

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


Reuse your code from lab 05 to:

	* Detect nonterminals that cannot be reached from a CFG’s goal symbol.
	* Detect nonterminals that cannot derive any terminal string in a CFG.

(reuse the same code , no need to re write in C, just call as a process)

Once we know that the Grammer propoused for the calculator has none of these
errors, please create a code in C that will take as input the gramar specified
in a FILE in Backus-Naur Form (BNF) notation to create a perser and a
recognizer for the calculator: i.e:


```
cat my_gramar.txt

<name-part> ::= <personal-part> <last-name> <opt-suffix-part> <EOL>
			| <personal-part> <name-part>
```


## How could it be tested:
```

make ( compile everything )

./lexic_analyzer <CODEFILE>

This will generate the tokens.out

./gramar_analyser my_gramar.txt
True/False and print the clean gramar

./syntax-calc tokens.out my_gramar.txt
```
And generate a CFG derivation tree in this format:

```
digraph D {

  A -> {B, C, D} -> {F}

}

```

View of this tree, put this code in:

https://dreampuf.github.io/GraphvizOnline

More info about DOT code:

https://renenyffenegger.ch/notes/tools/Graphviz/examples/index

```

## Please send the mail as git send mail:

```
    $ git add syntax-calc.c Makefile
    $ git commit -s -m <STUDENT-ID>-homework-06
    $ git send-email -1

```
Do some tests sending the mail to your personal
account, if you get the mail, then you can be sure I
will get the mail


## Time to do the homework:

One week from the moment the mail is sent to students

