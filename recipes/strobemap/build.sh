#!/bin/bash
#
# CONDA build script variables 
# 
# $PREFIX The install prefix
# $PKG_NAME The name of the package
# $PKG_VERSION The version of the package
# $PKG_BUILDNUM The build number of the package
#
set -eu -o pipefail

cd $SRC_DIR
mkdir -p $PREFIX/bin/
cp StrobeMap $PREFIX/bin/
cp -r modules $PREFIX/bin/
cp -r evaluation $PREFIX/bin/
