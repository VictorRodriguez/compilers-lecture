# Lab 02 instructions

## Objective


The study of compilers is mainly a study of how we design the right
mathematical models and choose the right algorithms while balancing the need
for generality and power against simplicity and efficiency.  Some of the most
fundamental models are finite-state machines and regular expressions. This
homework/lab makes the student get familiar with the first level of the
compiler which is the lexical analysis.

The goal is to write a program to check a C program for rudimentary syntax
errors like unbalanced parentheses, brackets, and braces. Don't forget about
quotes, both single and double, escape sequences and comments. (This program
is hard if you do it in full generality.)


## Instructions

* Create a file named:
```my_compiler.c```

* Make a code in C that given a C code could detect these errors:
    * unbalanced parentheses
    * brackets
    * braces
    * quotes (both single and double)
    * comments
* Make a Makefile to build and clean (take as an example the one from lab 01):


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

Run as:

```
    ./my_compiler hello.c
    There are no errors
```

Or modify to insert some errors  and comments like hello-errors.c:

```
    #include <stdio.h>
    // coment (this should not be detected
    int main(){
        for (int x = 0; x < 10;x++)
            printf("hi\n);
        }
        return 0;
    }

```

```
    ./my_compiler hello.c
    There is a missing { (optional : error in this line: 
    There is a missing " (optional : error in this line: 
```

If your code can detect these errors it is more than fine.


## Please send the mail as git send mail:

```
    $ git add ./my_compiler.c Makefile
    $ git commit -s -m <STUDENT-ID>-homework-02
    $ git send-email -1
```
Do some tests sending the mail to your personal account, if you get the mail,
then you can be sure I will get the mail

# Time to do the homework:

1 week from the moment the mail is sent to students

# How the teacher is going to test your homework

* Copy your patch form the mail to test.patch
* patch -p1 < test.patch
* make
* ./my_compiler hello.c ( should print no errors )
* ./my_compiler hello-errors.c ( should print the errors )

Test by yourself this flow, you can generate your patch with: 

```
git format-patch -1
```
The generated file should be like:
```
0001-<studentid>-homework-02.patch
```

