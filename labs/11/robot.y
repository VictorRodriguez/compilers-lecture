%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror();
void spaceError();
FILE *resultFile;
int direction = 0; //0 - right; 1 - down; 2 - left; 3 - up;
int stepsH = 0; 
int stepsV = 0; 
%}


%union {
    int degrees;
    int steps;
}


%token ROBOT
%token POLITE
%token MOVE
%token TURN
%token ENDLINE
%token <degrees> DEGREES
%token <steps> STEPS


%%
sentence_sequence:
| sentence_sequence sentence
;

sentence: ROBOT POLITE action ENDLINE
;

action: movement action
| movement
;

movement: MOVE STEPS                    { fprintf(resultFile, "MOV,%d\n", $2); if(direction == 0) {stepsH += $2;} else if(direction == 1) {stepsV += $2;} else if(direction == 2) {stepsH -= $2;} else {stepsV -= $2;} if(stepsH < 0 || stepsH > 9) spaceError(); if(stepsV < 0 || stepsV > 9) spaceError();}
| TURN DEGREES                          { fprintf(resultFile, "TURN,%d\n", $2); if(direction == 0) {if($2 == 90) direction = 1; else if($2 == 180) direction = 2; else if($2 == 270) direction = 3; else direction = 0;} else if(direction == 1) {if($2 == 90) direction = 2; else if($2 == 180) direction = 3;else if($2 == 270) direction = 0; else direction = 1;} else if(direction == 2) {if($2 == 90) direction = 3; else if($2 == 180) direction = 0; else if($2 == 270) direction = 1; else direction = 2;} else {if($2 == 90) direction = 0; else if($2 == 180) direction = 1; else if($2 == 270) direction = 2; else direction = 3;}}
;


%%

int main(int argc, char **argv) {

    FILE *inputFile = fopen(argv[1], "r");
    if (!inputFile) {
        fprintf(stderr, "Error: file not found...\n");
        return 1;
        }

        resultFile = fopen("instrunctions.asm", "w"); 
        if (!resultFile) {
        fprintf(stderr, "Error: couldn't create results file...\n");
        fclose(inputFile);
        return 1;
        }

    yyin = inputFile;
    yyparse();

    fclose(inputFile);
    fclose(resultFile);  
    return 0;
}

void yyerror() {}

void spaceError() {
    printf("Error: the instruction takes the robot out of the delimited space (10x10 matrix).\n");
    exit(1);
}
