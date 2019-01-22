# Lab 01 instructions

## Objective

Make the students get familiar with the compiler tools and some basics as sw
develoepers such as:

* How to compile from command line
* How to read the object file in command line
* How to automate the analysis of ASM code

## Instructions

* Inside this directory read carfully and undertand whats inside the Makefile
  file
* Compile using the autotools make:

    ```
        $ make
    ```
* Execute the binary and check that the binary actually produces the expected
  result
* Analize the object code with:

    ```
        objdump -d ./simple_foo | less
    ```
* Make a script (bash or python , is free for you to decide ) called
  asm-analitics.sh, this script will have the next requirments

    * Count how many diferent instructions yu have
    * Count how many times each instruction is ussed
    * Count how many functions the binary has
    * Print the virtual address of each function

## Expected result:

    ```
        $ objdump -d ./simple_foo > log
        $ ./asm-analitics.sh log
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
        $ git add asm-analitics.sh
        $ git commit -s -m <STUDENT-ID>-homework-01
        $ git send-email -1

    ```
Do some tests sending the mail to your personal account , if you get the mail ,
then you can be sure I will get the mail

# Time to do the homework:

    1 week from the moment the mail is sent to students

