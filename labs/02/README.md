# Lab 02 instructions

## Objective


The study of compilers is mainly a study of how we design the right
mathematical models and choose the right algorithms, while balancing the need
for generality and power against simplicity and efficiency.  Some of most
fundamental models are finite-state machines and regular expressions. This
homework/lab makes the student get familiar with the first level of the
compiler which is the lexical analysis.

The goal is to write a program to check a C program for rudimentary syntax
errors like unbalanced parentheses, brackets and braces. Don't forget about
quotes, both single and double, escape sequences, and comments. (This program
is hard if you do it in full generality.)


## Instructions

* Create a file named:
```my_compiler.c```

* Make a code in C that given a C code coudl detect these errors:
    * unbalanced parentheses
    * brackets
    * braces
    * quotes (both single and double)
    * comments
* Make a Makefileto build and clean (take as example the one from lab 01):



## Expected result:

Giving a sample C code as hello.c:

```
    #include <stdio.h>

    int main(){
        for (int x = 0; x < 10;x++){
            printf("hi\n");
        }
        return 0;
    }

```
Then you can build as:

```
    make
```

Run as:

```
    ./my_compiler hello.c
    There is no errors
```

Or modify to insert some errors:

```
    ./my_compiler hello.c
    There is a missing (  error in this line: (print line)
    There is a missing {  error in this line: (print line)
    There is a missing "  error in this line: (print line)
```

## Please send the mail as git send mail:

```
    $ git add ./my_compiler.c Makefile
    $ git commit -s -m <STUDENT-ID>-homework-02
    $ git send-email -1
```
Do some tests sending the mail to your personal account , if you get the mail ,
then you can be sure I will get the mail

# Time to do the homework:

1 week from the moment the mail is sent to students

