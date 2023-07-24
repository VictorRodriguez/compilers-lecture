all:
	gcc main.c -o main
	gcc bench.c -fstack-protector-all -o bench-fstack-protection-all
	gcc bench.c -fstack-protector-strong -o bench-fstack-protection-strong
	gcc -D_FORTIFY_SOURCE=1 -Wall -g -O2 mem_test.c -o mem_test
	gcc -D_FORTIFY_SOURCE=1 -Wall -g -O2 vuln.c -o vuln
	gcc -Wall -g -O2 bench_mem_test.c -o bench_mem_test
	gcc -D_FORTIFY_SOURCE=2 -Wall -g -O2 bench_mem_test.c -o bench_mem_test-forty-2
	gcc -Wall -Wextra -Wformat-security  printf-secure.c -o printf-secure

rop:
	export CFLAGS=""
	export CXXFLAGS=""
	export FCFLAGS=""
	export FFLAGS=""
	gcc -m32 -O0 vuln.c -o vuln -fno-stack-protector --static -fno-pic

clean:
	rm -rf main
	rm -rf bench-fstack-protection-all
	rm -rf bench-fstack-protection-strong
	rm -rf vuln
	rm -rf mem_test
	rm -rf bench_mem_test
	rm -rf bench_mem_test-forty-2
	rm -rf printf-secure
