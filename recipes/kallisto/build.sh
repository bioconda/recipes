#!/bin/bash

mkdir -p "${PREFIX}/bin"
export M4="${BUILD_PREFIX}/bin/m4"

cd ext/htslib || exit 1
autoreconf --force --install --verbose
./configure
cd ../.. || exit 1

if [[ `uname` == "Darwin" ]]; then
	export CONFIG_ARGS="-DCMAKE_FIND_FRAMEWORK=NEVER -DCMAKE_FIND_APPBUNDLE=NEVER"
else
	export CONFIG_ARGS=""
fi

cmake -S. -B build -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
	-DUSE_HDF5=ON -DUSE_BAM=ON -DBUILD_FUNCTESTING=ON -DMAX_KMER_SIZE=64 \
	-DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER="${CXX}" \
	-DCMAKE_CXX_FLAGS="${CXXFLAGS} -O3 -I${PREFIX}/include" \
	-DENABLE_AVX2=OFF -DCOMPILATION_ARCH=OFF \
	"${CONFIG_ARGS}"

cmake --build build --target install -v
