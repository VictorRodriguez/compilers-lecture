all:
	gcc -fdump-tree-cfg-graph example.c
	gcc -O2 -ftree-vectorize loop-test.c -o loop-test -fopt-info-vec &> loop-build.log

clean:
	@find . -type f -executable -exec sh -c "file -i '{}' | grep -q 'x-executable; charset=binary'" \; -print | xargs rm -f
	rm -rf a.out example.c.012t.cfg  example.c.012t.cfg.dot

