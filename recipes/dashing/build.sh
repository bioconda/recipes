#!/bin/bash

set -xeu -o pipefail

export CPP_INCLUDE_PATH=${PREFIX}/include
export CPLUS_INCLUDE_PATH=${PREFIX}/include
export CXX_INCLUDE_PATH=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib

pushd bonsai
rm -rf zstd
git clone --recursive --single-branch --branch dev https://github.com/facebook/zstd
pushd zstd
make CC=$CC lib && mv lib/libzstd.a ..
popd
popd

# Handle architecture-specific flags
ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ]; then
    sed -i.bak 's/-mpopcnt//g' Makefile
fi

sed -i.bak "s/ -lzstd//g" Makefile
make CC=$CC CXX=$CXX
make install PREFIX=$PREFIX
