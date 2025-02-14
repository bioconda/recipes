#!/bin/bash
set -eu -o pipefail

./configure --prefix=${PREFIX} --enable-libcurl --with-libdeflate --enable-plugins --enable-gcs --enable-s3
make install

cd SeqLib
ln -s ../htslib .
cd ..

cmake -DHTSLIB_DIR=htslib
make CC=${CC} CXX=${CXX} CFLAGS="-fcommon ${CFLAGS} -L${PREFIX}/lib" CXXFLAGS="-fcommon ${CXXFLAGS} -UNDEBUG -L${PREFIX}/lib" LDFLAGS="${LDFLAGS}"

echo "#######################"
echo "### DEBUGGING START ###"
echo "#######################"

find . -name svaba

echo "#####################"
echo "### DEBUGGING END ###"
echo "#####################"

mkdir -p ${PREFIX}/bin
cp bin/svaba ${PREFIX}/bin/
