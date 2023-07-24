
// Compile with gcc fprintf.c -m32 -fanalyzer and see how
// Wanalyzer-unsafe-call-within-signal-handler works
// Important it has to be with signal, if only printf(buffer)
// it will not be detected by compiler

#include<stdio.h>
#include <string.h>
#include <signal.h>

static void handler(int signum, char buffer[100]){
    printf(buffer);
}

int main(int argc, char** argv) {
    char buffer[100];
    strncpy(buffer, argv[1], 100);
	signal(SIGINT, handler);
    return 0;
}
