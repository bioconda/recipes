#!/bin/bash

export CFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"
export CPATH=${PREFIX}/include

./configure
make
mkdir -p $PREFIX/bin
cp phyml $PREFIX/bin
