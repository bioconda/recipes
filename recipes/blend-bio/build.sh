#!/bin/bash

mkdir -p $PREFIX/bin

export CPATH=${PREFIX}/include

make INCLUDES="-I$PREFIX/include" CFLAGS="-g -Wall -O2 -Wc++-compat -march=native -mavx2 -msse4.1 -L$PREFIX/lib" 
cp blend $PREFIX/bin
