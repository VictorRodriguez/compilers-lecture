#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>


/***************************
Example:
abbbbbc
abbbb
abc
abcbcbcc
ac

Grammar:
S --> aBc
B --> bc | b
***************************/

char l;


bool S();
bool B();
bool B_1();
bool B_2();
bool B_3();



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

// Definition of B_1 as per the given production
bool B_1() {
    if (l == 'b') {
		if(match('b') && match('c'))
			return true;
    }else {
			return false;
	}
}

// Definition of B_1 as per the given production
bool B_2() {
    if (l == 'b') {
		if(match('b'))
			return true;
    }else{
		return false;
	}
}

// Definition of B_3 as per the given production
bool B_3() {
	if (l == '\n'){
		return true;
	}else{
		return false;
	}
}

// Definition of B as per the given production
bool B(){
	if(B_1() || B_2() || B_3()){
		return true;
	}else{
		error();
	}
}


// Definition of S, as per the given production
bool S() {
    if (l == 'a') {
        if (match('a') && B() && match('c')){
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
	    S();

    } while (l != '\n' && l != EOF);

    if (l == '\n')
        printf("Parsing Successful\n");
}
