#include <stdio.h>

void foo(){
    float a,b,c = 1;
    a = b + c * 60;
}

int main(void) {
    printf("Hello World\n");
    foo();
    return 0; 
}
