# Lab 01 instructions

## Objective

Make the students get familiar with the compiler tools and some basics as sw
developers such as:

* How to compile from the command line
* How to read the object file in the command line
* How to automate the analysis of ASM code

# Requirements

* Linux machine, either a VM or a baremetal host
* GCC compiler (at least version 4.8)
* Autotools
* shell scripting
* git send mail server installed and configured on your Linux machine

## Instructions

* Inside this directory read carefully and understand what's inside the Makefile
  file
* Compile using the Autotools make:

    ```
        $ make
    ```
* Execute the binary and check that the binary actually produces the expected
  result
* Analyze the object code with:

    ```
        objdump -d ./simple_foo | less
    ```
* Make a script (bash or python, is free for you to decide ) called
  asm-analytics.sh, this script will have the next requirements

    * Count how many different instructions you have
    * Count how many times each instruction is used
    * Count how many functions the binary has
    * Print the virtual address of each function

## Expected result:

    ```
        $ objdump -d ./simple_foo > log
        $ ./asm-analytics.sh log
        Hi, this is the output of the analysis:
            You have 7 kind of instructions in this object file:
                movq     : Executed 7 times
                movss    : Executed 3 times
                addss    : Executed 2 times
            You have 2 functions:
                main     : Located at 100000ef0 addr
                foo      : Located at 100000ef0 addr
    ```
## Please send the mail as git send mail:

    ```
        $ git add asm-analytics.sh
        $ git commit -s -m <STUDENT-ID>-homework-01
        $ git send-email -1

    ```
Do some tests sending the mail to your personal account, if you get the mail,
then you can be sure I will get the mail

# Time to do the homework:

    one week from the moment the mail is sent to students

