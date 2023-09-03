#!/bin/bash
export CFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"
export CPATH=${PREFIX}/include
autoreconf -i --verbose
./configure --prefix=$PREFIX
make install
