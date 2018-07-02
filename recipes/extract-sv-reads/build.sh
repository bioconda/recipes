#!/bin/bash
mkdir -p build
cd build
mv ../conda_build.sh .
CFLAGS="-I$PREFIX/include" LDFLAGS="-L$PREFIX/lib" cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX -DHTSLIB_USE_LIBCURL=1 -DHTSLIB_USE_LZMA=1 -DHTSLIB_USE_BZ2=1 ..
make
make install
