# Detection of SIMD loops for optimization


## Introduction

The rapid evolution of computer architectures has also led to an insatiable
demand for new compiler technology. Almost all high-performance systems take
advantage of the same two basic techniques: parallelism and memory hierarchies.
Parallelism can be found at several levels: at the instruction level, where
multiple operations are executed simultaneously and at the processor level,
where different threads of the same application are run on different
processors. Memory hierarchies are a response to the basic limitation that we
can build very fast storage or very large storage, but not storage that is both
fast and large.

## Goal

This final project will be able to detect one of the core parts of source code
for optimizations: loops that execute single instruction multiple data code.

## Design

Having the next code:

```C

float a[256] = {0};
float b[256] = {0};
float c[256] = {0};

int main(){
	for(int x = 0; x < 10000000; x++)
		for (int i=0; i<256; i++){
			c[i] = a[i] + b[i];
		}
}

```

Your project should be a binary that by reading the C code prints:

```
	loop detected in line 8, canidate for SIM
```


## Report and presentation

Presentation should be done in front of the team with a writen [report] made in
latex.

Teams have to deliver:

	* Printed report
	* Printed LateX code
	* Send presentation to profesor

Resources:
	* https://www.epaperpress.com/lexandyacc/intro.html

[report](https://github.com/VictorRodriguez/operating-systems-lecture/blob/master/projects/report.tex)
