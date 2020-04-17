#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

//FIXME

/***************************
Example:
Grammar:
E --> i E'
E' --> + i E' | e
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
	if(E_alpha_1() || E_alpha_2()){
		return true;
	}
}

// Definition of E_1' as per the given production
bool E_alpha_2() {
	if (l == 'i')
		return match('i');
}

// Definition of E_2' as per the given production
bool E_alpha_1() {
    if (l == '+') {
		if(match('+') && match('i') && E_alpha())
			return true;
    }
}

// Definition of E, as per the given production
bool E() {
    if (l == 'i') {
        if (match('i') && E_alpha()){
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
