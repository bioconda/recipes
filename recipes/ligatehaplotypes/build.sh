#!/bin/bash
export CFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"

sed -i.bak 's/\/usr\/local/${PREFIX}/' makefile
make
ls
pwd
make install
