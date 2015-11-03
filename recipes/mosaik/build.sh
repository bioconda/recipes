#!/bin/bash

# cd to location of Makefile and source
cd $SRC_DIR/src

export PRFX=$PREFIX
make

binaries="\
MosaikAligner \
MosaikBuild \
MosaikJump \
MosaikText \
"

mkdir -p $PREFIX/bin
for i in $binaries; do cp $SRC_DIR/bin/$i $PREFIX/bin && chmod +x $PREFIX/bin/$i; done
