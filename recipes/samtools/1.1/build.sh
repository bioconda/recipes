#!/bin/sh
sed -i.bak -e 's/-lcurses/-lncurses/' Makefile
sed -i.bak -e "s|CFLAGS=\s*-g\s*-Wall\s*-O2\s*|CFLAGS= -g -Wall -O2 -I$NCURSES_INCLUDE_PATH/ncurses/ -I$NCURSES_INCLUDE_PATH -L$NCURSES_LIB_PATH|g" Makefile
make
mkdir -p $PREFIX/bin
mv samtools $PREFIX/bin

# used by tophat --with-bam
mv libbam.a $PREFIX/lib/
mkdir -p $PREFIX/include/bam
ln -s version.h version.hpp
mv *.h *.hpp $PREFIX/include/bam
