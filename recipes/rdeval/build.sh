#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o xtrace

cd "$SRC_DIR"

export CXXFLAGS="$CXXFLAGS -O3 -I$PREFIX/include"
export LDFLAGS="$LDFLAGS -L$PREFIX/lib"

make -j"${CPU_COUNT}" CXX="${CXX}"
install -v -m 0755 build/bin/rdeval "$PREFIX/bin/rdeval"
