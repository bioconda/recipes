#!/usr/bin/env bash
# Build file is copied from VarScan
# https://github.com/bioconda/bioconda-recipes/blob/master/recipes/varscan/build.sh
# This file was automatically generated by the sbt-bioconda plugin.

outdir=$PREFIX/share/$PKG_NAME-$PKG_VERSION-$PKG_BUILDNUM
mkdir -p $outdir
mkdir -p $PREFIX/bin
cp BaseCounter-assembly-0.1.jar $outdir/BaseCounter-assembly-0.1.jar
cp $RECIPE_DIR/biopet-basecounter.py $outdir/biopet-basecounter
ln -s $outdir/biopet-basecounter $PREFIX/bin

