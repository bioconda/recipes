#!/usr/bin/env bash

sed -i.backup \
    -e "s|gcc|$CC|g" \
    -e "s|-lz|-lz -I${PREFIX}/include|g \
    util/Makefile
make
mkdir ${PREFIX}/bin
cp bin/* ${PREFIX}/bin
