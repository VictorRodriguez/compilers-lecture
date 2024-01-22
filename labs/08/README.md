# Lab 08 instructions

## Objective

Understand the optimizations generated from the compiler toolchain

## Requirements

* Linux machine, either a VM or a bare metal host
* GCC compiler
* git send mail server installed and configured on your Linux machine

## Instructions
Most C compilers (including the GCC compilers) allow a user to examine the
machine instructions generated for a given source program. Run the following
program through such a C compiler and examine the instructions generated for
the for loop. Next, recompile the program, enabling
optimization[1](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html)
[3](https://blog.linuxplumbersconf.org/2016/ocw/system/presentations/3795/original/GCC.pdf)
, and reexamine the instructions generated for the for loop. What improvements
have been made?

Assuming that the program spends all of its time in the for loop, estimate the
speedup obtained. Write a suitable main C function that allocates and
initializes a million-element array to pass to proc. Execute and time the
unoptimized and optimized versions of the program and evaluate the accuracy
of your estimate:


```C
int proc(int a[]) {
	int sum = 0, i;
	for (i=0; i < 1000000; i++)
		sum += a[i];
	return sum;
	}
```

## How teacher is going to review:

* Make a report following the next [overleaf template](https://github.com/VictorRodriguez/operating-systems-lecture/blob/master/projects/report.tex)

* Sections that are necesary:
	* Title
	* Abstract
	* Introduction
	* Objective
	* Development
	* Results
	* Conclusion
	* References
* Upload the template and put a link on the body of yoru commit
* Send the patch of a filecreated on this directory
* Patch must include:
	* optimizations.c
	* Makefile

More background about compiler optimizations at [2](https://www.youtube.com/watch?v=jVYnT_onb70)


## Please send the mail as git send mail:

```
    $ git add optimizations.c Makefile
    $ git commit -s -m <STUDENT-ID>-homework-06
    $ git send-email -1

```
Do some tests sending the mail to your personal
account, if you get the mail, then you can be sure I
will get the mail


## Time to do the homework:

One week from the moment the mail is sent to students


