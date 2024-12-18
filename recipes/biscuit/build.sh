#!/bin/bash

if [[ `uname` == "Darwin" ]]; then
	ln -sf ${CC} ${PREFIX}/bin/gcc
else
	ln -sf ${CC} ${PREFIX}/bin/gcc
fi

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
    arm64|aarch64) cp -rfv ${RECIPE_DIR}/sse2neon.h ${SRC_DIR}/lib/aln/ ;;
esac

cmake -S . -B build -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
	-DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER="${CC}" \
	-DCMAKE_C_FLAGS="${CFLAGS}" -DCMAKE_INCLUDE_PATH="${PREFIX}/include" \
	-DCMAKE_LIBRARY_PATH="${PREFIX}/lib" -DZLIB_ROOT="${PREFIX}" \
	"${CONFIG_ARGS}"
cmake --build build --target install -v

# Needed to run asset builder
sed -i.bak '1 s|^.*$|#!/usr/bin/env perl|g' ${PREFIX}/bin/build_biscuit_QC_assets.pl
rm -rf ${PREFIX}/bin/*.bak
rm -rf ${PREFIX}/bin/gcc
