#!/bin/bash

mkdir -p ${PREFIX}/bin
export C_INCLUDE_PATH=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib
make 
make install
cp bin/* ${PREFIX}/bin
