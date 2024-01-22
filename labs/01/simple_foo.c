#include <stdio.h>

int array_test[256];

float foo(){
    float a,c = 1;
    float b = 1;
    a = b + c * 60;
    return a;
}

int main(void) {
    printf("Hello World\n");
    float result = foo();
    printf("%f\n",result);
    return 0;
}
