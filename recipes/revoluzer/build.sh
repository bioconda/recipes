#!/bin/bash
export LIBRARY_PATH=${PREFIX}/lib
export LD_LIBRARY_PATH=${PREFIX}/lib
export CPATH=${PREFIX}/include
export C_INCLUDE_PATH=${PREFIX}/include
export CPLUS_INCLUDE_PATH=${PREFIX}/include
export CPP_INCLUDE_PATH=${PREFIX}/include
export CXX_INCLUDE_PATH=${PREFIX}/include
export CMAKE_INCLUDE_PATH=${PREFIX}/include
export CMAKE_PREFIX_PATH=${PREFIX}

echo ${BUILD_PREFIX}/include
ls ${BUILD_PREFIX}/include
echo "===================================="

cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -H. -Bbuild -DCMAKE_BUILD_TYPE=Generic -DEXTRA_FLAGS='-march=sandybridge -Ofast'
cmake --build build
mkdir -p $PREFIX/bin
mv bin/* $PREFIX/bin
