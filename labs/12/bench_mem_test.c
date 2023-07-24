// fortify_test.c
#include<stdio.h>
#include<string.h>
#define MAX 100000000

char buffer[5];

void foo(char *value){
    strcpy(buffer,value);
}

int main(int argc, char **argv) {
    printf ("Buffer Contains: %s , Size Of Buffer is %ld\n",
                               buffer,sizeof(buffer));
    int i,x;
    for (x=0; x<MAX; x++){
        for (i=0; i<256; i++){
            foo(argv[1]);
        }
    }
    printf ("Buffer Contains: %s , Size Of Buffer is %ld\n",
                               buffer,sizeof(buffer));
}
