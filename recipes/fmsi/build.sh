#!/bin/bash

mkdir -p ${PREFIX}/bin

export INCLUDES="-I${PREFIX}/include"
export LIBPATH="-L${PREFIX}/lib"
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
export CXXFLAGS="${CXXFLAGS} -O3 -I${PREFIX}/include"

make CXX="${CXX}" CXXFLAGS="${CXXFLAGS}" \
	CPPFLAGS="${CPPFLAGS}" LDFLAGS="${LDFLAGS}" \
	-j"${CPU_COUNT}"

chmod 0755 ${PREFIX}/bin/fmsi
