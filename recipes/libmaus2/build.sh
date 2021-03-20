#!/bin/bash
set -eu
export LIBS="-lstdc++fs -lcurl -lio_lib"

./configure --prefix $PREFIX --with-snappy --with-io_lib

cat config.log

make
make install
