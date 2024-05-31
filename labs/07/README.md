# Practice Exercise: Building a Simple Chatbot with `lex` and `yacc`

#### Objective
In this exercise, you will create a simple chatbot using `lex` (for lexical analysis) and `yacc` (for parsing). The chatbot will be able to respond to greetings, queries about the time, and farewells. This practice will help you understand how to use `lex` and `yacc` to build a basic interactive application.

#### Prerequisites
- Basic understanding of C programming.
- Familiarity with `lex` and `yacc` tools.
- Basic knowledge of lexical analysis and parsing.

#### Instructions

1. **Setup Your Environment**:
   - Ensure you have `lex` (or `flex`) and `yacc` (or `bison`) installed on your system.
   - Create a working directory for this exercise.

2. **Create the Lex Specification**:
   - Create a file named `chatbot.l`.
   - Define patterns to match user inputs for greetings, farewells, and time queries.

   ```c
   %{
   #include "y.tab.h"
   %}

   %%

   hello           { return HELLO; }
   hi              { return HELLO; }
   hey             { return HELLO; }
   goodbye         { return GOODBYE; }
   bye             { return GOODBYE; }
   time            { return TIME; }
   what[' ']is[' ']the[' ']time  { return TIME; }
   what[' ']time[' ']is[' ']it  { return TIME; }
   \n              { return 0; }  /* End of input on newline */

   .               { return yytext[0]; }

   %%

   int yywrap() {
       return 1;
   }
   ```

3. **Create the Yacc Specification**:
   - Create a file named `chatbot.y`.
   - Define grammar rules to handle different types of user inputs.

   ```c
   %{
   #include <stdio.h>
   #include <time.h>

   void yyerror(const char *s);
   int yylex(void);
   %}

   %token HELLO GOODBYE TIME

   %%

   chatbot : greeting
           | farewell
           | query
           ;

   greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
            ;

   farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
            ;

   query : TIME { 
               time_t now = time(NULL);
               struct tm *local = localtime(&now);
               printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
            }
          ;

   %%

   int main() {
       printf("Chatbot: Hi! You can greet me, ask for the time, or say goodbye.\n");
       while (yyparse() == 0) {
           // Loop until end of input
       }
       return 0;
   }

   void yyerror(const char *s) {
       fprintf(stderr, "Chatbot: I didn't understand that.\n");
   }
   ```

4. **Compile the Lex and Yacc Files**:
   - Open a terminal in your working directory.
   - Run the following commands to compile the lex and yacc files:

   ```sh
   lex chatbot.l
   yacc -d chatbot.y
   cc lex.yy.c y.tab.c -o chatbot -ll -ly
   ```

5. **Run the Chatbot**:
   - Execute the compiled chatbot program:

   ```sh
   ./chatbot
   ```

   - Test the chatbot by typing various inputs:
     - Greetings like "hello", "hi", or "hey".
     - Time queries like "what is the time", "what time is it", or simply "time".
     - Farewells like "goodbye" or "bye".

6. **Extend the Chatbot**:
   - Add more patterns and responses to the chatbot. Think of additional questions users might ask and how the chatbot should respond. For example:
     - Ask for the chatbot's name: "what is your name".
     - Inquire about the weather: "what is the weather".
     - Ask how the chatbot is doing: "how are you".

 
#### Submission
Create a pull request and submit the following files:
- `chatbot.l`
- `chatbot.y`

Ensure your code is well-commented to explain your logic and any enhancements you made.

#### Assessment
You will be evaluated on:
- Correctness of the lexical and grammar rules.
- Functionality of the chatbot based on the provided and additional commands.
- Code readability and comments.

By completing this exercise, you will gain practical experience in using `lex` and `yacc` to build and extend a basic interactive application, laying the foundation for more complex projects in the future.
