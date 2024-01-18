#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

//FIXME

/***************************
Example:
Grammar:
E --> i E'A
E' --> + i E' | e
***************************/

char l;


bool E_alpha();
bool E_alpha_1();
bool E_alpha_2();
bool E_alpha_3();
bool E_alpha_4();



void error(){
	printf("Error\n");
	exit(-1);
};

// Match function
bool match(char t) {
    if (l == t) {
        l = getchar();
		return true;
    }
    else
		error();
};


bool E_alpha_4() {
    if (l == '*') {
		if(match('*') && match('i') && E_alpha())
			return true;
    }else{
		return false;
	};
};


bool E_alpha_3() {
    if (l == '-') {
		if(match('-') && match('i') && E_alpha())
			return true;
    }else{
		return false;
	};
}; 

// Definition of E_1' as per the given production
bool E_alpha_2() {
	if (l == '\n'){
		return true;
	}else{
		return false;
	};
};

// Definition of E_2' as per the given production
bool E_alpha_1() {
    if (l == '+') {
		if(match('+') && match('i') && E_alpha())
			return true;
    }else{
		return false;
	}
};

// Definition of E' as per the given production
bool E_alpha(){
	if(E_alpha_1() || E_alpha_2() || E_alpha_3() || E_alpha_4()){
		return true;
	}else{
		error();
	};
};

// Definition of E, as per the given production
bool E() {
    if (l == 'i') {
        if (match('i') && E_alpha()){
			return true;
		}
    }else{
		error();
	}
};

int main() {

    do {
        l = getchar();
		// E is a start symbol.
	    E();

    } while (l != '\n' && l != EOF);

    if (l == '\n')
        printf("Parsing Successful\n");
};