#!/bin/sh

cd $SRC_DIR

# rm -f "src/magic.h"
./configure --prefix=$PREFIX --datadir=$PREFIX/share --enable-static --enable-fsect-man5 --disable-silent-rules --disable-dependency-tracking
make
make install
# cp $PREFIX/share/misc/magic.mgc $HOME/.magic.mgc
