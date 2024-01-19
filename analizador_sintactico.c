#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

//FIXME

/***************************
Lenguaje

S -> a B c
B -> b c | b
***************************/

char l;

bool B();
bool B_alpha1();
bool B_alpha2();
bool S();

// Funcion de error
void error(){
	printf("Error\n");
	exit(-1);
}
//Match funtion

bool match(char t) {
    if (l == t) {
        l = getchar();
        return true;
    } else {
        error();
    }
}

//Si es igual a "bc"

bool B_alpha1() {
	if (l == 'b'){
        match('b');
        if (l == 'c') {
            match('c');
			return true;
		}
		else{
			return false;
		}
		
	}else{
		return false;
	}
}

//Si es igual a "b" o a salto

bool B_alpha2() {
	if (l == 'b'){
		return true;
	}else{
		return false;
	}
}

// Definition of B
bool B(){
	if(B_alpha1() || B_alpha2()){
		return true;
	}else{
		error();
	}
}


// Definition of S_alpha
bool S() {
    if (l == 'a') {
        match('a');
        if (B()) {
            if (l == 'c') {
                match('c');
                return true;
            }
        }
    }
	else{
		error();
	}
}



int main() {

    do {
        l = getchar();
		// S is a start symbol.
	    S();

    } while (l != '\n' && l != EOF);

    if (l == '\n')
        printf("Parsing Successful\n");
}


// Estructura

typedef struct Node {
    char label;
    struct Node* children[2]; // En este caso, hay máximo 2 hijos por nodo
} Node;

// Función para crear un nuevo nodo
Node* newNode(char label) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->label = label;
    node->children[0] = NULL;
    node->children[1] = NULL;
    return node;
}

// Funciones para construir el AST según la gramática



