#!/bin/bash
set -e

mkdir -p ${PREFIX}/bin
cd src || exit 1
echo "0" > gitver.txt

export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"

#if [[ ${HOST} =~ .*darwin.* ]]; then
#	export MACOSX_DEPLOYMENT_TARGET=10.15
#fi

cp ${RECIPE_DIR}/vcxproj_make.py .
chmod +x vcxproj_make.py
python ./vcxproj_make.py --openmp --pthread --lrt --cppcompiler "${CXX}" --ccompiler "${CC}" --std "c++17"

# Verify binary exists and is executable
if [[ ! -f ../bin/reseek ]]; then
    echo "Error: reseek binary not found"
    exit 1
fi

install -v -m 0755 ../bin/reseek "${PREFIX}/bin"
