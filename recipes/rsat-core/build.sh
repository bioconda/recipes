#!/bin/bash

# RSAT_DEST="$PREFIX/opt/rsat/"
BASE=`pwd`
RSAT_DEST="$PREFIX/share/rsat/"
mkdir -p "$RSAT_DEST"
mkdir -p "$PREFIX/bin"
## mkdir -p "$PREFIX/share/rsat"

cp -a LICENSE.txt \
   perl-scripts \
   python-scripts \
   makefiles \
   R-scripts \
   RSAT_config_default.mk \
   RSAT_config_default.bashrc \
   RSAT_config_default.props \
   RSAT_config_default.conf \
   "$RSAT_DEST"

cp bin/rsat $PREFIX/bin/rsat
cp share/rsat/rsat.yaml $PREFIX/share/rsat/rsat.yaml

## Add relative links from share/rsat to the bin folder (necessary for GetProgramPath to find executables in bin, e.g. vmatch)
cd $PREFIX/share/rsat
ln -s ../../bin .
cd $PREFIX

## Make a link from share to opt (not sure this is required)
# ln -s share opt

# Build and dispatch compiled binaries
cd contrib
for dbin in info-gibbs count-words matrix-scan-quick retrieve-variation-seq variation-scan 
do
    echo "Compiling C/C++ program: $dbin"
    cd "$dbin"
    make clean && make CC=$CC CXX=$CXX && cp "$dbin" "$PREFIX/bin"
    cd ..
done
cd ..

# Build the R package with RSAT functions used by matrix-clustering
echo "Building R package TFBMclust"
cd R-scripts
R CMD INSTALL --no-multiarch --with-keep.source TFBMclust
cd ..


# Run the configuration script
echo "Running RSAT configuration in automatic mode"
cd $RSAT_DEST
perl-scripts/configure_rsat.pl -auto \
  rsat_site=conda_rsat \
  rsat_www=auto \
  ucsc_tools=1 \
  ensembl_tools=1 \
  LOGO_PROGRAM=weblogo
cd $BASE

