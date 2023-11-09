#!/bin/bash
set -ex

export CPLUS_INCLUDE_PATH=${PREFIX}/include
export CPP_INCLUDE_PATH=${PREFIX}/include
export CXX_INCLUDE_PATH=${PREFIX}/include

#to ensure zlib location
export CFLAGS="$CFLAGS -I$PREFIX/include"
export LDFLAGS="$LDFLAGS -L$PREFIX/lib"

mkdir -p $PREFIX/bin
mkdir -p $PREFIX/lib

echo "PREFIX:" ${PREFIX}
cmake -DHASH_MAP=USE_TSL_ROBIN_MAP -DCMAKE_CXX_FLAGS="-O3" 
echo "CMAKE PASSED"
echo "SRC_DIR:" ${SRC_DIR}
pwd
ls .
ls ..
ls ${SRC_DIR}
cmake --build . --target all
ls .

cp ipk/ipk-aa $PREFIX/bin
cp ipk/ipk-aa-pos $PREFIX/bin
cp ipk/ipk-dna $PREFIX/bin
cp ipk.py $PREFIX/bin

chmod +x $PREFIX/bin/ipk-*
