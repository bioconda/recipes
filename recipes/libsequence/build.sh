#!/bin/bash

CXXFLAGS="-O3 -DNDEBUG" CPPFLAGS="-I$PREFIX/include $CPPFLAGS" LDFLAGS="-L$PREFIX/lib $LDFLAGS" ./configure --prefix=$PREFIX
make
make install

