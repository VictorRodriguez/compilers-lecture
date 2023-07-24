# Security Flags at GCC and its impact in performance

Stack buffer overflows are a longstanding problem for C programs that leads to
all manner of ills, many of which are security vulnerabilities. The biggest
problems have typically been with string buffers on the stack coupled with bad
or missing length tests. A programmer who mistakenly leaves open the
possibility of overrunning a buffer on a function's stack may be allowing
attackers to overwrite the return pointer pushed onto the stack earlier. Since
the attackers may be able to control what gets written, they can control where
the function returns ( based on https://lwn.net/Articles/584225/ ) 

GCC, like many compilers, offers features to help detect and prevent this
vulnerabilities 

This basic document describe the the following security flags: 

```
Stack execution protection:             LDFLAGS="-z noexecstack"
Data relocation and protection (RELRO): LDLFAGS="-z relro -z now"
Stack-based Buffer Overrun Detection:   CFLAGS=”-fstack-protector-strong”
                                          if using GCC 4.9 or newer,
                                          otherwise CFLAGS="-fstack-protector"
Fortify source:                         CFLAGS="-O2 -D_FORTIFY_SOURCE=2"
Format string vulnerabilities:          CFLAGS="-Wformat -Wformat-security"
```


## GCC Stack Protection Mechanisms (CFLAGS=”-fstack-protector-strong”)

Stack-based Buffer Overrun Detection:   CFLAGS=”-fstack-protector-strong”

This flag emits extra code to check for buffer overflows, such as stack
smashing attacks. This is done by adding a guard variable to functions with
vulnerable objects (canary). The basic idea behind stack protection is to push
a "canary" (a randomly chosen integer) on the stack just after the function
return pointer has been pushed. The canary value is then checked before the
function returns; if it has changed, the program will abort. Generally, stack
buffer overflow (aka "stack smashing") attacks will have to change the value of
the canary as they write beyond the end of the buffer before they can get to
the return pointer. Since the value of the canary is unknown to the attacker,
it cannot be replaced by the attack. Thus, the stack protection allows the
program to abort when that happens rather than return to wherever the attacker
wanted it to go.

Putting stack protection into every function is both overkill and may hurt
performance, so one of the GCC options chooses a subset of functions to
protect. 

* The existing -fstack-protector-all option will protect all functions
* The -fstack-protector option chooses any function that declares a character
  array of eight bytes or more in length on its stack.
* The -fstack-protector-strong option has been developed to broaden the scope
  of the stack protection without extending it to every function in the
  program.

Example code for -fstack-protector-strong

```
int foo(int i) {
    return i;
}

int main() {
    int ret;
    int i = 10;
    ret = foo(i);
    return ret;
}
```

If we compile with

```
gcc main.c -o main -fstack-protector-all
```

We force to all the functions to have the security protection enebale, the foo
function then generate the following code

```
0000000000401112 <foo>:
  401112:       48 83 ec 18             sub    $0x18,%rsp
  401116:       ba 28 00 00 00          mov    $0x28,%edx
  40111b:       64 48 8b 0a             mov    %fs:(%rdx),%rcx
  40111f:       48 89 4c 24 08          mov    %rcx,0x8(%rsp)
  401124:       31 c9                   xor    %ecx,%ecx
  401126:       48 8b 74 24 08          mov    0x8(%rsp),%rsi
  40112b:       64 48 33 32             xor    %fs:(%rdx),%rsi
  40112f:       75 07                   jne    401138 <foo+0x26>
  401131:       89 f8                   mov    %edi,%eax
  401133:       48 83 c4 18             add    $0x18,%rsp
  401137:       c3                      retq
  401138:       e8 f3 fe ff ff          callq  401030 <__stack_chk_fail@plt>
```
If we change to use -fstack-protector-strong the foo function is not affected: 


```
00000000004010f2 <foo>:
  4010f2:       89 f8                   mov    %edi,%eax
  4010f4:       c3                      retq

00000000004010f5 <main>:
  4010f5:       b8 0a 00 00 00          mov    $0xa,%eax
  4010fa:       c3                      retq
  4010fb:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
```
The -fstack-protector-strong is recomended to be used to do not affect the
perfomrance, instead of protecting all functions that coudl affect the
perfomrance , the next question is how much coudl this falg affect the
performance ? 

Here is a simple benchmark code: 

```
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#define MAX 100000000

static struct timeval tm1;
int a[256], b[256], c[256];

void foo();

int main(){
    foo();
    return 0;
}

void foo(){
    int i,x;
    for (x=0; x<MAX; x++){
        for (i=0; i<256; i++){
            a[i] = b[i] + c[i];
        }
    }
}
```

with -fstack-protection-all: 

```
0000000000401112 <foo>:
  401112:       48 83 ec 18             sub    $0x18,%rsp
  401116:       64 48 8b 04 25 28 00    mov    %fs:0x28,%rax
  40111d:       00 00
  40111f:       48 89 44 24 08          mov    %rax,0x8(%rsp)
  401124:       31 c0                   xor    %eax,%eax
  401126:       b9 40 42 0f 00          mov    $0xf4240,%ecx
  40112b:       eb 04                   jmp    401131 <foo+0x1f>
  40112d:       ff c9                   dec    %ecx
  40112f:       74 25                   je     401156 <foo+0x44>
  401131:       b8 00 00 00 00          mov    $0x0,%eax
  401136:       8b 90 60 44 40 00       mov    0x404460(%rax),%edx
  40113c:       03 90 60 40 40 00       add    0x404060(%rax),%edx
  401142:       89 90 60 48 40 00       mov    %edx,0x404860(%rax)
  401148:       48 83 c0 04             add    $0x4,%rax
  40114c:       48 3d 00 04 00 00       cmp    $0x400,%rax
  401152:       75 e2                   jne    401136 <foo+0x24>
  401154:       eb d7                   jmp    40112d <foo+0x1b>
  401156:       48 8b 44 24 08          mov    0x8(%rsp),%rax
  40115b:       64 48 33 04 25 28 00    xor    %fs:0x28,%rax
  401162:       00 00
  401164:       75 05                   jne    40116b <foo+0x59>
  401166:       48 83 c4 18             add    $0x18,%rsp
  40116a:       c3                      retq
  40116b:       e8 c0 fe ff ff          callq  401030 <__stack_chk_fail@plt>
  ```
  
  with -fstack-protector-strong
  
  ```
  00000000004010f2 <foo>:
  4010f2:       b9 40 42 0f 00          mov    $0xf4240,%ecx
  4010f7:       eb 04                   jmp    4010fd <foo+0xb>
  4010f9:       ff c9                   dec    %ecx
  4010fb:       74 25                   je     401122 <foo+0x30>
  4010fd:       b8 00 00 00 00          mov    $0x0,%eax
  401102:       8b 90 60 44 40 00       mov    0x404460(%rax),%edx
  401108:       03 90 60 40 40 00       add    0x404060(%rax),%edx
  40110e:       89 90 60 48 40 00       mov    %edx,0x404860(%rax)
  401114:       48 83 c0 04             add    $0x4,%rax
  401118:       48 3d 00 04 00 00       cmp    $0x400,%rax
  40111e:       75 e2                   jne    401102 <foo+0x10>
  401120:       eb d7                   jmp    4010f9 <foo+0x7>
  401122:       c3                      retq
  ```
  
The difernece in terms of performance is: 

```
$ perf stat ./bench-fstack-protection-strong
Executed 3 times: 
  154,054,541,632 instructions:u # 2.84  insn per cycle
  154,059,056,179 instructions:u # 2.84  insn per cycle
  154,013,291,687 instructions:u # 2.84  insn per cycle

Mean (Average):	Mean (Average):	154042296499.33 instructions
Sample Standard Deviation: 14560845.185207 instructions # 2.84 insn per cycle
```

```
$ perf stat ./bench-fstack-protection-all
Executed 3 times: 
    153,987,502,402 instructions:u # 2.84  insn per cycle
    153,995,330,286 instructions:u # 2.84  insn per cycle
    154,004,792,847 instructions:u # 2.84  insn per cycle

Mean (Average):	153995875178.33 instructions 
Sample Standard Deviation: 4998751.6046743 instructions # 2.84  insn per cycle
```


The delta in performance ( instructions ) of this example by using th flag :
  * -fstack-protection-all ( forcing to use fstack protection in all functions,simulate the worst case scenario )
  against: 
  * -fstack-protection-stong ( less functions are afected ) 
is 

```
abs( 154042296499.33 - 153995875178.33 ) =  46421321 instructions = ~0.03 % of degradation
```
## Fortify source (CFLAGS="-O2 -D_FORTIFY_SOURCE=2")

The FORTIFY_SOURCE macro provides lightweight support for detecting buffer
overflows in various functions that perform operations on memory and strings.
Not all types of buffer overflows can be detected with this macro, but it does
provide an extra level of validation for some functions that are potentially a
source of buffer overflow flaws. (based on
https://access.redhat.com/blogs/766093/posts/1976213)

FORTIFY_SOURCE provides buffer overflow checks for the following functions:

```
memcpy, mempcpy, memmove, memset, strcpy, stpcpy, strncpy, strcat, 
strncat, sprintf, vsprintf, snprintf, vsnprintf, gets.
```
[reference = http://man7.org/linux/man-pages/man7/feature_test_macros.7.html]


For example the next code : 

```
#include <stdio.h>

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
```

Is a good example of vulneravility and by following some simple steps in 

https://github.com/VictorRodriguez/operating-systems-lecture/tree/master/labs/gcc/security

We can easily access to the secretFunction() by buffer overflow

When we compile with: -D_FORTIFY_SOURCE=1 we get 

```
vuln.c: In function ‘echo’:
vuln.c:18:5: warning: ignoring return value of ‘scanf’, declared with attribute warn_unused_result [-Wunused-result]
     scanf("%s", buffer);
     ^~~~~~~~~~~~~~~~~~~
```

As we can see the compiler (GCC 8.1) do a very good job by detecting the
security issue at scanf function

Compiling with:

```
gcc -Wall -g -O2 vuln.c -o vuln
```

Generates no issue or warning 

Taking another example with more easy to handle buffer overflow

```
#include<stdio.h>
#include<string.h>

int main(int argc, char **argv) {
char buffer[5];
printf ("Buffer Contains: %s , Size Of Buffer is %ld\n",
                               buffer,sizeof(buffer));
strcpy(buffer,"deadbeef");
printf ("Buffer Contains: %s , Size Of Buffer is %ld\n",
                               buffer,sizeof(buffer));
}
```

with -D_FORTIFY_SOURCE=1  we get:

```
$ gcc -D_FORTIFY_SOURCE=1 -Wall -g -O2 mem_test.c -o mem_test
In file included from /usr/include/string.h:494,
                 from mem_test.c:3:
In function ‘strcpy’,
    inlined from ‘main’ at mem_test.c:9:1:
/usr/include/bits/string_fortified.h:90:10: warning: ‘__builtin___memcpy_chk’ forming offset [6, 9] is out of the bounds [0, 5] of object ‘buffer’ with type ‘char[5]’ [-Warray-bounds]
   return __builtin___strcpy_chk (__dest, __src, __bos (__dest));
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mem_test.c: In function ‘main’:
mem_test.c:6:6: note: ‘buffer’ declared here
 char buffer[5];
      ^~~~~~
```

The compiler returns a warning because it correctly detects the buffer overflaw
in the buffer variable:

if we modify the strcpy(buffer,"deadbeef") to strcpy(buffer,argv[1])

-D_FORTIFY_SOURCE=1 will not detect a thing , because at compile tiem it does
not has an idea of the lenght of the string to copy to buffer and if it will
generate a buffer overflow. However with -D_FORTIFY_SOURCE=2 it does generate
code to check at build time:

```
$ gcc -D_FORTIFY_SOURCE=2 -Wall -g -O2 mem_test.c -o mem_test
$ ./mem_test aaaaaaaaaaaaaa
Buffer Contains:  , Size Of Buffer is 5
*** buffer overflow detected ***: ./mem_test terminated
Aborted (core dumped)
```

  

Performance can be measure with the next code: 

```
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
```


If we disassemble the binary output of the above command, we can see the call
to <__strcpy_chk@plt>, which checks for a potential buffer overflow:

```
00000000004011a0 <foo>:
  4011a0:       48 89 fe                mov    %rdi,%rsi
  4011a3:       ba 05 00 00 00          mov    $0x5,%edx
  4011a8:       bf 39 40 40 00          mov    $0x404039,%edi
  4011ad:       e9 7e fe ff ff          jmpq   401030 <__strcpy_chk@plt>
  4011b2:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
  4011b9:       00 00 00
  4011bc:       0f 1f 40 00             nopl   0x0(%rax)
```

The difernece in terms of performance is: 

```
gcc -D_FORTIFY_SOURCE=2 -Wall -g -O2 bench_mem_test.c -o bench_mem_test-forty-2

perf stat ./bench_mem_test-forty-2 aaa

   1,485,272,192,918 instructions:u # 2.31  insn per cycle
   1,485,453,650,633 instructions:u # 2.31  insn per cycle
   1,485,491,542,369 instructions:u # 2.31  insn per cycle

Mean (Average):	Mean (Average):	1485405795306.7 instructions
Sample Standard Deviation: 67690828.052631 instructions # 2.31 insn per cycle
```


```
gcc -Wall -g -O2 bench_mem_test.c -o bench_mem_test

perf stat ./bench_mem_test aaa

   1,485,386,835,017 instructions:u # 2.3  insn per cycle
   1,485,194,110,041 instructions:u # 2.3  insn per cycle
   1,485,184,126,261 instructions:u # 2.3  insn per cycle

Mean (Average):	Mean (Average):	1485255023773 instructions
Sample Standard Deviation: 65968608.694825 instructions # 2.3 insn per cycle
```

The delta in performance ( instructions ) of this example by using this flag :
  
  * -D_FORTIFY_SOURCE=2
  
is

```
abs( 1485405795306.7 - 1485255023773 ) =  150771533.7 instructions = ~0.01 % of degradation
```

## Format string vulnerabilities( CFLAGS="-Wformat -Wformat-security")

-Wformat check calls to printf and scanf, etc., to make sure that the arguments
supplied have types appropriate to the format string specified, and that the
conversions specified in the format string make sense. This includes standard
functions, and others specified by format attributes (see Function Attributes),
in the printf, scanf, strftime and strfmon (an X/Open extension, not in the C
standard) families (or other target-specific families). 

With -Wformat-security if -Wformat is specified, also warn about uses of format
functions that represent possible security problems. At present, this warns
about calls to printf and scanf functions where the format string is not a
string literal and there are no format arguments, as in printf (foo);. This may
be a security hole if the format string came from untrusted input and contains
‘%n’. (This is currently a subset of what -Wformat-nonliteral warns about, but
in future warnings may be added to -Wformat-security that are not included in
-Wformat-nonliteral.)

[taken from https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html]

Example of code that -Wformat-security detects

```
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

$ gcc -Wall -Wextra -Wformat-security  printf-secure.c
printf-secure.c: In function ‘foo’:
printf-secure.c:5:5: warning: format not a string literal and no format arguments [-Wformat-security]
     printf(s);
     ^~~~~~
```

There is no performance penalty since the code is not affected , just a warning
is generated at compile time 

## Data relocation and protection (RELRO): LDLFAGS="-z relro -z now"

A dynamically linked ELF binary uses a look-up table called Global Offset Table
(GOT) to dynamically resolve functions that are located in shared libraries.
There are several steps in the middle to make it possible: 

* First, the function call is actually pointing to the Procedure Linkage Table
  (PLT), which exists in the .plt section of the binary.

* The .plt section contains x86 instructions that point directly to the GOT,
  which lives in the .got.plt section.

* The .got.plt section contains binary data. The GOT contain pointers back to
  the PLT or to the location of the dynamically linked function.

By default, the GOT is populated dynamically while the program is running. The
first time a function is called, the GOT contains a pointer back to the PLT,
where the linker is called to find the actual location of the function in
question (this is the part we’re not going into detail about). The location
found is then written to the GOT. The second time a function is called, the GOT
contains the known location of the function. This is called “lazy binding.”.
Since we know that the GOT lives in a predefined place and is writable, all
that is needed is a bug that lets an attacker write four bytes anywhere.

To prevent this kind of exploitation technique, we can tell the linker to
resolve all dynamically linked functions at the beginning of execution and make
the GOT read-only. For this case the compiler provide 2 flags 

* -Wl,-z,now : It Disable lazy binding. 
* -Wl,-z,relro : Makes Read-only segments after relocation	

The performance of RELocation Read-Only depends on the number of times the
library is called, is hard to generate a micr benchmark for it

[source https://developers.redhat.com/blog/2018/03/21/compiler-and-linker-flags-gcc/]
[source https://medium.com/@HockeyInJune/relro-relocation-read-only-c8d0933faef3]

## Stack execution protection: LDFLAGS="-z noexecstack"

Buffer overflow exploits often put some code in a program's data area or stack, and then jump to it. If all writable addresses are non-executable, such an attack is prevented. 

By default, gcc will mark the stack non-executable, unless an executable stack is needed for function trampolines. The gcc marking can be overridden via the -z execstack or -z noexecstack compiler flags.

As we can see in the following example: 

```
$ gcc main.c -o main-execstack -z execstack
$ objdump -p main-execstack | grep -i -A1 stack
main-execstack:     file format elf64-x86-64

--
   STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**4
         filesz 0x0000000000000000 memsz 0x0000000000000000 flags rwx
```

The stack is marked with flags for read, write and execute ( flags rwx )

if we compile with -z noexecstack the stack shows: 

```
$ gcc main.c -o main-noexecstack -z noexecstack
$ objdump -p main-noexecstack | grep -i -A1 stack
main-noexecstack:     file format elf64-x86-64

--
   STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**4
         filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
```

With no executable flag ( flags rw- ) 

[source https://www.win.tue.nl/~aeb/linux/hh/protection.html]

Same information could be read with the readelf -l tool , looking for the PT_GNU_STACK. The PT_GNU_STACK is an ELF header item that indicates whether the binary has an executable stack. 


```
$ readelf -l ./main-noexecstack | grep -i -A1 stack
  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RW     0x10
```

The performance in this case is not affected since the compilers by default has the flag as -z noexecstack. 
