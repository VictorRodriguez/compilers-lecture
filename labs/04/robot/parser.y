%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

char strings[100][50];
int numStrings = 0;
char str[50];

int posX = 0;
int posY = 0;
int orientation = 0;

/*  COORDINATE SYSTEM
    The origin (0,0) is on the top-left corner, with the positive 
    direction to the right horizontally and down vertically.

    The orientation is measured in angles, starting on the right 
    horizontally axis:
    0   - East
    90  - North
    180 - West
    270 - South
*/

void move(int number){
    // Move in the orientation
    switch ( orientation ) {
        case 0:
            posX += number;
            break;
        case 90:
            posY -= number;
            break;
        case 180:
            posX -= number;
            break;
        case 270:
            posY += number;
            break;
    }

    // Check for boundaries
    
    if ( posX < 0 || posX > 10 || posY < 0 || posY > 10 ) {
        printf("Caution - Robot will get out of grid (%d, %d)\n", posX, posY);
        exit(EXIT_FAILURE);
    }
    else {
        printf("Robot moved %d blocks (%d, %d) \n", number, posX, posY);
        
        sprintf(str, "MOVE, %d", number);
        strcpy(strings[numStrings], str);
        numStrings++;
    }

}

void turn(int number){
    // Check that is a valid turn value 
    if ( number%90 != 0){
        exit(EXIT_FAILURE);
    }

    // Ensure the orientation is within the range [0, 359]
    orientation = (orientation + number) % 360;

    printf("Robot turned %d degrees\n", number);

    sprintf(str, "TURN, %d", number);
    strcpy(strings[numStrings], str);
    numStrings++;


}

%}

%union {
 double dval;
}

%token ROBOT PLEASE MOVE TURN CONNECTOR BLOCKS DEGREES
%token <dval> NUMBER

%%
program: ROBOT PLEASE instructions                  
       ;

instructions: instructions CONNECTOR instruction
            | instruction 
            ;

instruction: MOVE NUMBER BLOCKS     { move($2); }
           | TURN NUMBER DEGREES    { turn($2); }
            ;

%%

int main() {
      
    yyparse();  

    FILE *file = fopen("instructions.asm", "w");

    for (int i = 0; i < numStrings; i++) {
        fprintf(file, "%s\n", strings[i]);
    }
    
    fclose(file);

    return 0;
}