#!/bin/sh

export CFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"
export CPATH=${PREFIX}/include

autoreconf -fi

./configure --prefix=$HOME/entropy

make 
make install

