# Lab 03 instructions

## Objective

Make the student develop the next part of the compiler, the lexical analyser of
the code that we will create : AC adding calculator

# Requirements

* Linux machine, either a VM or a baremetal host
* GCC compiler (at least version 4.8)
* Autotools
* git send mail server installed and configured on your Linux machine

## Instructions

Our language is called ac (for adding calculator). When compared with most
programming languages, ac is relatively simple, yet it serves nicely as a study
for examining the phases and data structures of a compiler. We first define ac
informally:

* Types: Most programming languages offer a significant number of predefined
  data types, with the ability to extend existing types or specify new data
  types. In ac, there are only two data types: integer and float. An integer
  type is a sequence of decimal numerals, as found in most programming
  languages. A float type allows five fractional digits after the decimal
  point.

* Keywords Most programming languages have a number of reserved keywords,
  such as if and while, which would otherwise serve as variable names. In ac,
  there are three reserved keywords, each limited for simplicity to a single
  letter: f (declares a float variable), i (declares an integer variable), and
  p (prints the value of a variable).

* Variables Some programming languages insist that a variable be declared by
  specifying the variable’s type prior to using the variable’s name. The ac
  language offers only 23 possible variable names, drawn from the lowercase
  Roman alphabet and excluding the three reserved keywords f, i, and p.
  Variables must be declared prior to using them.

Most programming languages have rules that dictate circumstances under which a
given type can be converted into another type. In some cases, such type
conversion is handled automatically by the compiler, while other cases require
explicit syntax (such as casts) to allow the type conversion. In ac, conversion
from integer type to float type is accomplished automatically. Conversion in
the other direction is not allowed under any circumstances.

For the target of translation, we use the widely available program dc (for desk
calculator), which is a stack-based calculator that uses reverse Polish
notation (RPN). When an ac program is translated into a dc program, the
resulting instructions must be acceptable to the dc program and must faithfully
represent the operations specified in an ac program.

The objective of this lab is the creation of lexical analyzer of ac.

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

Before validating if a code has syntax error with a CFG is necesary to
translate the code to an string of tokens such as:

```
floatdcl id intdcl id
id assign inum
id assign id plus fnum
print id
```

## Expected result:

* Code a lex file that fullfill the requirements
* Code a Makefile for this code
* Generate a random AC code with:

```
python3 code_generator.py > example.ac

```

* Compile and execute as follows:

```
lex lexic_analyzer.l (the lex code you generate in your homework)
gcc lex.yy.c -o lexical_scan -lfl
./lexical_scan <source code for ac language like example.ac>
```

This should generate kind of the following file: lex.out

```
floatdcl id intdcl id
id assign inum
id assign id plus fnum
print id
```


## Please send the mail as git send mail:

```
    $ git add lexic_analyzer.l
    $ git commit -s -m <STUDENT-ID>-homework-03
    $ git send-email -1

```
Do some tests sending the mail to your personal account, if you get the mail,
then you can be sure I will get the mail

## Performance test

The code generation has an option to generate stress examples:

```
python3 code_generator.py --stress
```

This will generate a huge AC random code

Try your solution with this option and check how much time to your solution to
do the lex part of the compiler. Consider that this is just the first part of
the compiler work, other parts are necesary in the future

Do you think that we could make it faster?

Why performance is important?

Suppose we want to implement a very fast compiler that can compile a program in
a few seconds. We will use 30,000 lines per minute (500 lines per second) as
our goal. (Compilers such as Turbo C++ achieve such speeds.) If an average line
contains 20 characters, the compiler must scan 10,000 characters per second. On
a processor that executes 10,000,000 instructions per second, even if we did
nothing but scanning, we would have only 1,000 instructions per input character
to spend. 

However, because scanning is not the only thing a compiler does, 250
instructions per character is more realistic. This is a rather tight budget,
considering that even a simple assignment takes several instructions on a
typical processor. 

Although faster processors are common these days and 30,000
lines per minute is an ambitious speed, clearly a poorly coded scanner can
dramatically impact a compiler’s performance.

## Time to do the homework:

One week from the moment the mail is sent to students

