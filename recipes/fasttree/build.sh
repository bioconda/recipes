#!/bin/bash

mkdir -p $PREFIX/bin

# build FastTree
$CC $CFLAGS $LDFLAGS -Wall -O3 -DUSE_DOUBLE -funroll-loops $SRC_DIR/FastTree-2.1.10.c -lm -o $PREFIX/bin/FastTree
chmod +x $PREFIX/bin/FastTree
cp -f -- $PREFIX/bin/FastTree $PREFIX/bin/fasttree

# Build FastTreeMP
$CC $CFLAGS $LDFLAGS -Wall -DOPENMP -fopenmp -O3 -DUSE_DOUBLE -funroll-loops $SRC_DIR/FastTree-2.1.10.c -lm -o $PREFIX/bin/FastTreeMP
chmod +x $PREFIX/bin/FastTreeMP
