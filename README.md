# compilers-lecture

This GIT repository contains a list of workshops and labs for compilers' design
lecture. The level of complexity is for undergraduate students of computer
science careers at ITESM university

This is plan to be deliverable in a period of time of 4 to 6 months. It is
adjustable in time and order; however the expectations and basic topics should
keep the essence of the plan.

## Agenda:

* [Introduction to compilers](https://drive.google.com/open?id=18-tj7JEHmfY9QH7tDWEB0FHgfZslgUd3FQmgZh4uMCQ)
  * Language Processors
  * [Evolution of programing languages](https://docs.google.com/presentation/d/1eyi0sNu1XZ498knSle2CwgrozegSqYfVOvCGOxuL5rc/edit?usp=sharing)
  * The Structure of a Compiler
    * Lexical Analysis
    * Syntax Analysis
    * Semantic Analysis
    * Intermediate Code Generation
    * Code Optimization
    * Code Generation
    * Symbol-Table Management
    * The Grouping of Phases into Passes
    * Compiler-Construction Tools
* [Simple Syntax directed Translation](https://docs.google.com/presentation/d/1KE89YKtU4IDtK5locxnlciRHkWltg9VG_C42ORVR7WI/edit?usp=sharing)
  * Syntax definition
  * Definition of gramars
  * Parse Trees
  * Ambiguity
* [Lexical Analyser and Regex](https://docs.google.com/presentation/d/1kpLPDliaGBJbckxPY2lRWv38FHG55jfVX6OWH-FSPeM/edit?usp=sharing)
  * Regex
  * DFA
  * LEX
  * YACC
* [Grammars and Parsing](https://drive.google.com/open?id=1pUU1y9kDVrs9kkP_Zh1oC59G94Hi3FzSqehC9nmve0g)
  * Grammars in our lifes
  * Parse trees
  * Properties of CFGs
  * Reduced Gramars
  * Backus-Naur Form (BNF) notation
  * Parsers and Recognizers
* [Top-Down Parsing](https://docs.google.com/presentation/d/1b9ecDphpIwD-gSvFawZQzXSg1U_HAel7CmucwWCAtI4/edit?usp=sharing)
  * LL(k)
  * Recursive-descent parsers
  * Eliminating Ambiguity
  * Elimination of left recursion
* [Bottom-Up Parsing](https://drive.google.com/open?id=1WCBfCFD-7AuhNQYGEi1ZxJKsevSjsKCmL6kM0Uss5Mw)
  * LR(k)
  * Shift-reduce
  * Simple LR Parser algorithm  
* [Error Recovery](https://docs.google.com/presentation/d/1054xs2_vMLsILOO4l9YksCOTclGmcYHu94wOndmCaFA/edit?usp=sharing)
  * Panic mode
  * Statement mode
  * Error productions
  * Global correction
* [Abstract Syntax Trees](https://docs.google.com/presentation/d/1NeO-SkZLcOQAyYevel_xV5zBk-CL5Pw7c7fvEz7XKmY/edit?usp=sharing)
  * Example of Abstract Syntax Tree
  * Semantic Actions
  * Semantic Actions dependencies
* [Semantic Analysis](https://drive.google.com/open?id=1Tt-VbEa4nQLzoVRJnJ_sIgf4K-BWtsv74ygew1z13T8)
  * Scope resolution
  * Type checking
  * Array-bound checking
  * Semantic Errors
  * Attribute Grammar
  * Inherited attributes
* [Symbol Table & Intermediate Code Generation](https://docs.google.com/presentation/d/1-EP0_CbRf-g9clIx7GcAgLCe-UEFv_WRpCmrfRoJXxY/edit?usp=sharing)
* [Code optimization](https://drive.google.com/open?id=1sEwM70e70PzgdeEZ3g348ai_0xCntddm5W0nrFdxbrc)


## Extra topic Trainings ( in case you need them )
  * Git training
    * https://drive.google.com/file/d/0B7iKrGdVkDhINERiQnppOU5IVVk/view?usp=sharing
  * Bash Trainings:
    * https://drive.google.com/file/d/0B7iKrGdVkDhILU9QRWllWmNKM2M/view?usp=sharing
    * https://drive.google.com/file/d/0B7iKrGdVkDhIWGVhVzhtTlZjWGc/view?usp=sharing
    * https://drive.google.com/file/d/0B7iKrGdVkDhIRkVPSlNPdkdSS2c/view?usp=sharing
    * https://drive.google.com/file/d/0B7iKrGdVkDhIbkdKYWI1R19oMzQ/view?usp=sharing
  * GCC for performance Trainings:
    * https://drive.google.com/open?id=0B7iKrGdVkDhIUzZTVTduczJrQTg
  * GCC ROP attacks workshop:
    * https://github.com/VictorRodriguez/operating-systems-lecture/tree/master/labs/gcc/security
  * Makefile trainings:
    * [Tutorial 1](https://www.tutorialspoint.com/makefile/index.html)
    * [Tutorial 2](https://www.coursera.org/lecture/introduction-embedded-systems/6-make-18etg)
    * [Tutorial 3](https://github.com/lifeissweetgood/makefile-tutorial)

## Ponderation:

 * 35% First Term
   * 15% Weekly Quizzes
   * 5% Reading Summaries
   * 15% Labs

 * 35% Second Term
   * 15%  Weekly Quizzes
   * 5% Reading Summaries
   * 15% Labs

* 30% Final Exam ( if student decides to do final project it is = 10% and final
  exam 20 % )

## Bibliography:

### Mian Book : 
* Crafting a Compiler, by Charles N. Fischer 

### Other good books :

* Introduction to computer theory Book by Daniel I. A. Cohen
* Principles of Compiler Design Textbook by Alfred Aho and Jeffrey Ullman
* Compilers: Principles, Techniques, and Tools; Alfred Aho, Jeffrey Ullman, Monica S. Lam, and Ravi Sethi
* Languages and Machines: An Introduction to the Theory of Computer Science [3rd Edition](https://www.amazon.com/Languages-Machines-Introduction-Computer-Science/dp/0321322215)
* Assembly Language Step-by-Step: Programming with Linux 3rd Edition by Jeff Duntemann
