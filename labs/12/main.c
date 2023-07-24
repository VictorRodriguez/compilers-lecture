#include <stdio.h>

int foo(int i) {
    return i;
}

int main() {
    int ret;
    int i = 10;
    ret = foo(i);
    return ret;
}
