#!/bin/sh
set -x -e

#compile
#conda install -p $PREFIX libgfortran=3.0 -y
# backup to "gfortran" in conda GFORTRAN is not set
PFTOOLS_PROGRAMS="pfscanV3 pfsearchV3 gtop pfmake pfscan pfw ptoh htop pfscale pfsearch psa2msa 2ft 6ft ptof"
mkdir build
cd build/
cmake -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}/bin" ..
make CC=${CC} CXX=${CXX} F77=${GFORTRAN} CFLAGS="$CFLAGS $LDFLAGS"
make install
make test

ls -l ${PREFIX}/bin
