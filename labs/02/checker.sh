#!/usr/bin/bash

patch -p1 < test.patch
make
./my_compiler sample_ok.c
./my_compiler sample_w_errors.c
