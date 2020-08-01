#!/bin/bash
set +ex

# Add zlib support
export CFLAGS="-I$PREFIX/include"
export CXX_INCLUDE_DIR=$PREFIX/include
export CPP_INCLUDE_DIR=$PREFIX/include
export CPPLUS_INCLUDE_DIR=$PREFIX/include
export LDFLAGS="-L$PREFIX/lib"
export CPATH=${PREFIX}/include
export CPP_INCLUDE_PATH=${PREFIX}/include
export CPLUS_INCLUDE_PATH=${PREFIX}/include
export CXX_INCLUDE_PATH=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib


# build
./autogen.sh
./configure --prefix=${PREFIX} 
make
make install
