#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
//FIXME

/***************************
Example:
Grammar:
E --> c E' d
E' -->  b c | a
***************************/

char l;


bool E_alpha();
bool E_alpha_1();
bool E_alpha_2();

void error(){
	printf("Error\n");
	exit(-1);
}
// Match function
bool match(char t) {
    if (l == t) {
        l = getchar();
		return true;
    }
    else
		error();
}

// Definition of E' as per the given production
bool E_alpha(){
	printf("Enter funciton E_Alpha\n");
	if(E_alpha_1() || E_alpha_2()){
		return true;
	}else{
		error();
	}
}

// Definition of E_1' as per the given production
bool E_alpha_2() {
	printf("Enter function E_Alpha2\n");
	if (match('a')){
		return true;
	}else{
		return false;
	}
}

// Definition of E_2' as per the given production
bool E_alpha_1() {
	printf("Enter funciton E_Alpha1\n");
    if (l == 'b') {
		if(match('b') && match('c'))
			return true;
    }else{
		return false;
	}
}

// Definition of E, as per the given production
bool E() {
	printf("Enter funciton E\n");
    if (l == 'c') {
        if (match('c') && E_alpha() && match('d')){
			return true;
		}
    }else{
		error();
	}
}

int main() {

    do {
        l = getchar();
		// E is a start symbol.
	    E();

    } while (l != '\n' && l != EOF);

    if (l == '\n')
        printf("Parsing Successful\n");
}
