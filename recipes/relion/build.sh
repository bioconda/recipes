#!/bin/bash
set -xe

mkdir -p "${PREFIX}/share/torch"

export CXXFLAGS="${CXXFLAGS} -O3"
export CPPFLAGS="${CPPFLAGS} -I${PREFIX}/include"
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"

if [[ `uname` == "Darwin" ]]; then
	export LDFLAGS="${LDFLAGS} -Wl,-headerpad_max_install_names -Wl,-rpath,${PREFIX}/lib"
	export CONFIG_ARGS="-DCMAKE_FIND_FRAMEWORK=NEVER -DCMAKE_FIND_APPBUNDLE=NEVER"
	export ADDITIONAL_ARGS="-DCUDA=OFF"
else
	export CONFIG_ARGS="-DCUDAToolkit_ROOT=${PREFIX}"
	export ADDITIONAL_ARGS=""
fi

cmake -S . -B build -DCMAKE_BUILD_TYPE=Release \
	-DGUI=OFF -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
	-DCMAKE_CXX_COMPILER="${CXX}" -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
	-DPYTHON_EXE_PATH="${PYTHON}" -DTORCH_HOME_PATH="${PREFIX}/share/torch" \
 	"${CONFIG_ARGS}" \
	"${ADDITIONAL_ARGS}"
cmake --build build --target install -j "${CPU_COUNT}" -v
