#!/bin/bash

export C_INCLUDE_PATH=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib

make CC=$CC
mkdir -p $PREFIX/bin
cp bin/fqtools $PREFIX/bin
