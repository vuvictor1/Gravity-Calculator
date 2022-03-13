#!/bin/bash

#Author: Victor V. Vu
#Descrption: BASH compilation file

#Removes old files when we create a new compilation
rm *.o
rm *.out

#Echo works the same way cout does
echo "Compiling files..."

#Compiles the assembly code
nasm -f elf64 -o gravity.o gravity.asm

#Compiles the C++ code
g++ -c -m64 -std=c++17 -fno-pie -no-pie -o driver.o driver.cpp

#Compiles the C code
gcc -c -m64 -std=c11 -no-pie -o isfloat.o isfloat.c

#Link files together
g++ -m64 -std=c++17 -fno-pie -no-pie -o ./linked.out gravity.o driver.o isfloat.o -lm

#Another echo that couts
echo "Compilation successful! Running Program"

#Runs the file linked.out
./linked.out
