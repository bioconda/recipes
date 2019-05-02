#!/bin/bash
set -ef -o pipefail

rm -rf bamtools
mkdir -p bamtools/inclue
ln -s $BUILD_PREFIX/lib bamtools/
ln -s $BUILD_PREFIX/include/bamtools bamtools/include/
ls bamtools/lib
ls bamtools/include
mkdir -p build
pushd build

mkdir -p $PREFIX/bin

cmake -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_CXX_COMPILER=${CXX} ${SRC_DIR}
make
cp src/bam-read $PREFIX/bin/
popd
