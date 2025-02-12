#!/bin/bash
set -xe

export CXXFLAGS="${CXXFLAGS} -O3 -I${PREFIX}/include"
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"

if [[ `uname` == "Darwin" ]]; then
	export CONFIG_ARGS="-DCMAKE_FIND_FRAMEWORK=NEVER -DCMAKE_FIND_APPBUNDLE=NEVER"
	export ADDITIONAL_ARGS="-DCUDA=OFF"
else
	export CONFIG_ARGS="-DCUDAToolkit_ROOT=${PREFIX} -DCMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES=${PREFIX}/include"
	export ADDITIONAL_ARGS=""
fi

cmake -S . -B build "${CMAKE_ARGS}" -DCMAKE_BUILD_TYPE=Release \
	-DGUI=OFF -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
	-DCMAKE_CXX_COMPILER="${CXX}" -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
	"${CONFIG_ARGS}" \
	"${ADDITIONAL_ARGS}"
cmake --build build --target install -j "${CPU_COUNT}" -v
