#!/usr/bin/bash


if [ -f "test.patch" ]
then
    echo "patch exist"
    git apply --check test.patch
    if [ $? -eq 0 ]
    then
        echo "Patch apply clean"
        git apply test.patch
        make
        objdump -d ./simple_foo > log
        if [ -d asm-analytics.sh ]
        then
            bash asm-analytics.sh log
            exit 0
        fi
        if [ -d asm-analytics.py ]
        then
            bash asm-analytics.py log
        fi
    fi
fi


