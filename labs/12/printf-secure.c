#include <stdio.h>
#include <stdlib.h>

void foo(char *s) { 
    printf(s); 
}

int main(){
    char greeting[] = "Hello";
    foo(greeting);
    return EXIT_SUCCESS;
}
