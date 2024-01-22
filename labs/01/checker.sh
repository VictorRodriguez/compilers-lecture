#!/usr/bin/bash


if [ -f "test.patch" ]
then
    echo "patch exist"
    git apply --check test.patch
    if [ $? -eq 0 ]
    then
        echo "Patch apply clean"
        patch -p1 < test.patch
    fi

fi

make
objdump -d ./simple_foo > log
if [ -f asm-analytics.sh ]
then
    bash asm-analytics.sh log
    exit 0
fi
if [ -f asm-analytics.py ]
then
    python asm-analytics.py log
    exit 0
fi

