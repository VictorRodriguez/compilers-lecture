#include <stdio.h>
#include <stdlib.h>

/*
 * IMPORTANT: To compile 32 bit binaries on 64 bit Linux version, you have to
 * Install libx32gcc development package and 32 bit GNU C Library
 * IN GCC 10 in CLR compile as:
 * gcc -m32 -O0 vuln.c -o vuln -fno-stack-protector --static -fno-pic
 * python2 -c 'import struct; print "l"*32+struct.pack("i",0x08049db5)' | ./vuln
 */


int modified = 0;

void secretFunction_variable(){
	if(modified != 0) {
		printf("you have changed the 'modified' variable\n");
	} else {
		printf("Try again?\n");
	}
}

void secretFunction_mul(int a, int b)
{
      printf("The answer is %d\n", a*b);
      exit(0);
}

void secretFunction()
{
    printf("Congratulations!\n");
    printf("You have entered in the secret function!\n");
}

void echo()
{
    char buffer[20];

    printf("Enter some text:\n");
    scanf("%s", buffer);
    printf("You entered: %s\n", buffer);
}

int main()
{
    echo();

    return 0;
}
