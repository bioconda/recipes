#!/bin/bash

#strictly use anaconda build environment
CC=${PREFIX}/bin/gcc
CXX=${PREFIX}/bin/g++

mkdir -p $PREFIX/bin

./install.sh

mv install.sh install.sh.old

mv exe/* $PREFIX/bin

mkdir -p $PREFIX/opt/clark
mv *.sh $PREFIX/opt/clark

