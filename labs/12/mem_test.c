// fortify_test.c
#include<stdio.h>
#include<string.h>

int main(int argc, char **argv) {
char buffer[5];
printf ("Buffer Contains: %s , Size Of Buffer is %ld\n",
                               buffer,sizeof(buffer));
//strcpy(buffer,"deadbeef");
strcpy(buffer,argv[1]);
printf ("Buffer Contains: %s , Size Of Buffer is %ld\n",
                               buffer,sizeof(buffer));
}
