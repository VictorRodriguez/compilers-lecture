# Lab 08

Most C compilers (including the GCC compilers) allow a user to examine the
machine instructions generated for a given source program. Run the following
program through such a C compiler and examine the instructions generated for
the for loop. Next, recompile the program, enabling optimization, and reexamine
the instructions generated for the for loop. What improvements have been made?

Assuming that the program spends all of its time in the for loop, estimate the
speedup obtained. Write a suitable main C function that allocates and
initializes a million-element array to pass to proc. Execute and time the
unoptimized and optimized versions of the program and evaluate the accuracy
of your estimate:


```
int proc(int a[]) {
	int sum = 0, i;
	for (i=0; i < 1000000; i++)
		sum += a[i];
	return sum;
	}
```
