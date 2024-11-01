#!/bin/bash

export LDFLAGS="$LDFLAGS -L$PREFIX/lib"
export CPATH=${PREFIX}/include
export LIBRARY_PATH=$LIBRARY_PATH:${PREFIX}/lib
export C_INCLUDE_PATH=$C_INCLUDE_PATH:${PREFIX}/include
export PATH=$BUILD_PREFIX/bin:$PATH

make \
  CXX="${CXX} ${CPPFLAGS} ${CXXFLAGS} " \
  CFLAGS="${CFLAGS} "

install -d "${PREFIX}/bin"
install fc-virus "${PREFIX}/bin/"
