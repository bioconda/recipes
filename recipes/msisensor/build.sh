#!/bin/bash

export CFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"
export CPATH=${PREFIX}/include

curl -L https://github.com/samtools/samtools/archive/0.1.19.tar.gz > 0.1.19.tar.gz

tar -xzf 0.1.19.tar.gz
cd samtools-0.1.19
make
export SAMTOOLS_ROOT=$PWD

cd ..
make

mkdir -p $PREFIX/bin
cp msisensor $PREFIX/bin
