#!/bin/bash

# Compile
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX
make
# Move to conda dir structure
mkdir -p $PREFIX/bin;
cp ./3seq $PREFIX/bin/
# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
CHANGE="activate"
mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
# Associate p value table in shared directory with 3seq
mkdir -p $PREFIX/share/3seq;
wget -P $PREFIX/share/3seq/ https://www.dropbox.com/s/zac4wotgdmm3mvb/pvaluetable.2017.700.tgz
tar xfz $PREFIX/share/3seq/pvaluetable.2017.700.tgz  -C $PREFIX/share/3seq/
#echo "3seq should now be associated with the newly-downloaded p value table:\n3seq -c $PREFIX/share/3seq/PVT.3SEQ.2017.700\n" >> $PREFIX/.messages.txt
