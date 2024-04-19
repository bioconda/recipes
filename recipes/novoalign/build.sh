#!/bin/bash
set -eux

mkdir -p "${PREFIX}/bin"

if [ $(uname -m) == "aarch64" ]; then
    for makefile in $(find ./ -name "Makefile"); do
        sed -i'.bak' "s/-m64//" $makefile
    done
fi

# Compile and install novo2maq
make -C novo2maq -j${CPU_COUNT} \
    CC="${CC}" \
    CXX="${CXX}" \
    CFLAGS="${CFLAGS} ${CPPFLAGS} -g -Wall -O2 -m64 ${LDFLAGS}" \
    CXXFLAGS="${CXXFLAGS} ${CPPFLAGS} -g -Wall -O2 -m64 -fpermissive ${LDFLAGS}"
cp novo2maq/novo2maq ${PREFIX}/bin

# Install all executables
find . -maxdepth 1 -perm -111 -type f -exec cp {} ${PREFIX}/bin ';'

# Install license script
cp ${RECIPE_DIR}/novoalign-license-register.sh ${PREFIX}/bin/novoalign-license-register

# Install documentation
DOC_DIR=${PREFIX}/share/doc/novoalign
mkdir -p ${DOC_DIR}
cp *.pdf *.txt ${RECIPE_DIR}/license.txt ${DOC_DIR}
