#!/bin/bash 

set -x
mkdir -p build
cd build
export C_INCLUDE_PATH=${PREFIX}/include
export CXX_INCLUDE_PATH=${PREFIX}/include
export CPP_INCLUDE_PATH=${PREFIX}/include
export CPLUS_INCLUDE_PATH=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib
export BOOST_ROOT=${PREFIX}
export HTSLIB_ROOT=${PREFIX}
export CXXFLAGS="-ldeflate -lrt -lz -lbz2 -llzma -ldl"

#tricks make_dependencies to skip builds of packages already in bioconda, except zlib 
# (comments allude to needing this specific version)
mkdir -p $SRC_DIR/build/include/htslib
mkdir -p $SRC_DIR/build/bin
touch $SRC_DIR/build/bin/samtools
touch $SRC_DIR/build/bin/bcftools
touch $SRC_DIR/build/bin/rtg

cmake ../ -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DBOOST_ROOT="${PREFIX}" -DBoost_NO_SYSTEM_PATHS=ON -DCMAKE_BUILD_TYPE=Release \
  -DHTSLIB_ROOT="${PREFIX}" -DBOOST_LIBRARYDIR="${PREFIX}" -DBoost_USE_STATIC_LIBS=OFF \
  -DBOOST_INC="/usr/include" -DBOOST_LIB_IO="-lboost_iostreams" -DBOOST_LIB_PO="-lboost_program_options" \
  -DBOOST_LIB_SE="-lboost_serialization"
make
make install
