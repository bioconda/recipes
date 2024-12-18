#!/bin/bash

# Needed for building utils dependency
export INCLUDE_PATH="${PREFIX}/include"
export LIBRARY_PATH="${PREFIX}/lib"
export LDFLAGS="${LDFLAGS} -pthread -L${PREFIX}/lib"

if [[ `uname` == "Darwin" ]]; then
	export CONFIG_ARGS="-DCMAKE_FIND_FRAMEWORK=NEVER -DCMAKE_FIND_APPBUNDLE=NEVER"
	export CFLAGS="${CFLAGS} -O3"
else
	export CONFIG_ARGS=""
	export CFLAGS="${CFLAGS} -O3 -lrt"
fi

case $(uname -m) in
    arm64|aarch64) cp -rf lib/aln/sse2neon.h ${PREFIX}/include ;;
esac

cmake -S . -B build -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER="${CC}" \
  -DCMAKE_C_FLAGS="${CFLAGS}" "${CONFIG_ARGS}"
cmake --build build --target install -j 1 -v

# Needed to run asset builder
sed -i.bak '1 s|^.*$|#!/usr/bin/env perl|g' ${PREFIX}/bin/build_biscuit_QC_assets.pl
