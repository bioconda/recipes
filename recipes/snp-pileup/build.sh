#!/bin/bash

export CFLAGS="-I$PREFIX/include"
export CPPFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"

# function install_htslib(){
#     # Download and install htslib. Compiled stuff is in `pwd`/htslib
#     pushd .
#     rm -f htslib-1.8.tar.bz2
#     wget https://github.com/samtools/htslib/releases/download/1.8/htslib-1.8.tar.bz2
#     tar xf htslib-1.8.tar.bz2
#     rm htslib-1.8.tar.bz2
#     mv htslib-1.8 htslib
#     cd htslib
#     ./configure --prefix=`pwd`
#     make -j 4
#     make install
#     popd
# }

mkdir -p $PREFIX/bin

cd inst/extcode/

g++ -std=c++11 -I$PREFIX/include snp-pileup.cpp \
     -L$PREFIX/lib -lhts -Wl,-rpath=$PREFIX/lib -o snp-pileup

# install_htslib
#ln -s $PREFIX/lib/libhts.a $PREFIX/lib/libhts-static.a
#
#g++ -std=c++11 -o snp-pileup snp-pileup.cpp -I$PREFIX/include -L$PREFIX/lib -lm -lhts-static -lcurl -lz -lpthread -lcrypto -llzma -lbz2
#
./snp-pileup --help
ln -s `pwd`/snp-pileup $PREFIX/bin/snp-pileup
# mv snp-pileup $PREFIX/bin/
cd $PREFIX
snp-pileup --help
