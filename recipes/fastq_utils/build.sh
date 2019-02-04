#!/bin/bash

mkdir -p $PREFIX/bin

export C_INCLUDE_PATH="${PREFIX}/include:${PREFIX}/include/bam"
export CPP_INCLUDE_PATH="${PREFIX}/include"
export CXX_INCLUDE_PATH="${PREFIX}/include"
export CPLUS_INCLUDE_PATH="${PREFIX}/include"
export LIBRARY_PATH="${PREFIX}/lib"

# Run the main install

make
make install

# Copy executables into prefix

cp bin/* $PREFIX/bin
