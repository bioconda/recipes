#!/bin/bash
set -e

mkdir -p ${PREFIX}/bin
cd src || exit 1
cp ${RECIPE_DIR}/vcxproj_make.py .
echo "${PKG_VERSION}" > gitver.txt
chmod +x vcxproj_make.py

./vcxproj_make.py --openmp --cppcompiler ${CXX}

# Verify binary exists and is executable
if [ ! -f ../bin/muscle ]; then
    echo "Error: muscle binary not found"
    exit 1
fi

cp ../bin/muscle ${PREFIX}/bin/muscle
