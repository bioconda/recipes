#!/bin/sh

make all PARALLEL=1 CXX=$CXX CXXFLAGS="-D__STDC_FORMAT_MACROS -I${PREFIX}/include -L${PREFIX}/lib"
mkdir -p $PREFIX/bin
cp src/delly $PREFIX/bin
