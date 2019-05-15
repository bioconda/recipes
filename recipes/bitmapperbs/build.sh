#!/bin/bash
chmod +x htslib/version.sh

make -f ${RECIPE_DIR}/newMakefile PREFIX=${PREFIX} CC=${CC} CXX=${CXX}

mkdir -p ${PREFIX}/bin
mv bitmapperBS ${PREFIX}/bin/
mkdir -p ${PREFIX}/lib
mv htslib/libhtsBit* ${PREFIX}/lib/
