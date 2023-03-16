#!/usr/bin/env bash
set -e
set -x

export INCLUDE_PATH="${PREFIX}/include"
export CPPFLAGS="-I${PREFIX}/include"

sed -i.bak "s#gcc#${CC}#;s#g++#${CXX}#" MSToolkit/Makefile
make CXX=${CXX} CXXFLAGS="${CXXFLAGS} -mcmodel=large -fpic" CFLAGS="${CFLAGS} -mcmodel=large -fpic"

mkdir -p "$PREFIX"/bin
cp comet.exe ${PREFIX}/bin/comet
chmod a+x ${PREFIX}/bin/comet
cd "$PREFIX"/bin/
ln -s comet comet.exe
