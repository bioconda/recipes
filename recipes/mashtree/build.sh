#!/bin/bash

set -x -e

export INCLUDE_PATH="${BUILD_PREFIX}/include"
export LIBRARY_PATH="${BUILD_PREFIX}/lib"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${BUILD_PREFIX}/lib"

export LDFLAGS="-L${BUILD_PREFIX}/lib"
export CPPFLAGS="-I${BUILD_PREFIX}/include"


mkdir -p $BUILD_PREFIX/bin

mkdir -p perl-build
cp bin/*pl perl-build
cp bin/mashtree perl-build
cp lib/ perl-build/lib
cp ${RECIPE_DIR}/Build.PL perl-build

cd perl-build

perl ./Build.PL
perl ./Build manifest
perl ./Build install --installdirs site

chmod +x $BUILD_PREFIX/bin/mashtre*
chmod +x $BUILD_PREFIX/bin/min_abundance*
