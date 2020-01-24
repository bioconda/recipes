#!/bin/bash

export CPLUS_INCLUDE_PATH=${CPLUS_INCLUDE_PATH}:${PREFIX}/include
export LIBRARY_PATH="${PREFIX}/lib"
export LD_LIBRARY_PATH="${PREFIX}/lib"

mkdir -p "$PREFIX/libexec" "$PREFIX/bin"

# src/Makefile uses
# > CXX = g++
# > CXXFLAGS = -Wall -fopenmp -O3
# We patch these to add to environment, rather than override
# because we can't get to the `make` call easily.
sed -i.bak 's/CXX *=/CXX ?=/; s/CXXFLAGS *=/CXXFLAGS +=/' src/Makefile 

# Work around "unknown type name 'mach_port_t'" error
if [ x"$(uname)" == x"Darwin" ]; then
  CXXFLAGS="$CXXFLAGS -D_DARWIN_C_SOURCE"
  CPPFLAGS="$CPPFLAGS -D_DARWIN_C_SOURCE"
  export CXXFLAGS CPPFLAGS
fi

chmod u+x install_kraken.sh
./install_kraken.sh "$PREFIX/libexec"
for bin in kraken kraken-build kraken-filter kraken-mpa-report kraken-report kraken-translate; do
    chmod +x "$PREFIX/libexec/$bin"
    ln -s "$PREFIX/libexec/$bin" "$PREFIX/bin/$bin"
    # Change from double quotes to single in case of special chars
    sed -i.bak "s#my \$KRAKEN_DIR = \"$PREFIX/libexec\";#my \$KRAKEN_DIR = '$PREFIX/libexec';#g" "$PREFIX/libexec/${bin}"
    rm -rf "$PREFIX/libexec/${bin}.bak"
done
